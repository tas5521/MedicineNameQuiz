//
//  ModeSelectionViewModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/03/22.
//

import SwiftUI

@Observable
final class ModeSelectionViewModel {
    // Pickerの変数
    // 問題リストを識別するID
    var questionListID: UUID = UUID() {
        didSet {
            saveUserSelection()
        }
    }
    // 出題設定を管理する変数
    var questionSelection: QuestionSelectionMode = .all {
        didSet {
            saveUserSelection()
        }
    }
    // モード選択を管理する変数
    var studyMode: StudyMode = .brandToGeneric {
        didSet {
            saveUserSelection()
        }
    }

    // 問題を格納する配列
    var questions: [StudyItem] = []

    private let userDefaultsKey = "setting"

    // 問題を作成するメソッド
    func createQuestions(fetchedLists: FetchedResults<QuestionList>) {
        // CoreDataから、該当するIDを持つ問題を取得
        if let questionList = fetchedLists.first(where: { $0.id == questionListID }) {
            // StudyItem型に変換
            let studyItems = (questionList.questions as? Set<Question>)?
                .map {
                    StudyItem(id: $0.id ?? UUID(),
                              category: MedicineCategory.getCategory(from: $0.category ?? ""),
                              brandName: $0.brandName ?? "",
                              genericName: $0.genericName ?? "",
                              studyResult: StudyResult(rawValue: $0.studyResult ?? "") ?? .unanswered)
                } ?? []
            switch questionSelection {
            // 全ての問題を出題する設定の場合
            case .all:
                // データをシャッフルして出題
                questions = studyItems.shuffled()
            // 未回答もしくは不正解の問題を出題する設定の場合
            case .unansweredOrIncorrect:
                // まだ正解していない問題を取得
                let filteredItems = studyItems.filter({ $0.studyResult != .correct })
                // 全ての問題に正解している場合、全問をシャッフルして出題
                if filteredItems.isEmpty {
                    questions = studyItems.shuffled()
                } else {
                    // まだ正解していない問題がある場合、シャッフルして出題
                    questions = filteredItems.shuffled()
                } // if ここまで
            } // switch  ここまで
        } // if let ここまで
    } // createQuestions ここまで

} // ModeSelectionViewModel ここまで

extension ModeSelectionViewModel {

    private struct UserSelection: Encodable, Decodable {
        var questionSelection: String?
        var questionListID: String?
        var studyMode: String?
    }

    // Pickerの選択の状態を保存するメソッド
    func saveUserSelection() {
        // 参考：https://qiita.com/taro-ken/items/8bdbc86c53452a443c85#%E4%BF%9D%E5%AD%98

        let userSelection = UserSelection(
            questionSelection: questionSelection.rawValue,
            questionListID: questionListID.uuidString,
            studyMode: studyMode.rawValue)

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        if let data = try? encoder.encode(userSelection) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    } // saveUserSelection ここまで

    // Pickerの選択の状態を読み込むメソッド
    func loadUserSelection() {
        // 参考：https://qiita.com/taro-ken/items/8bdbc86c53452a443c85#%E5%91%BC%E3%81%B3%E5%87%BA%E3%81%97

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            if let userSelection = try? decoder.decode(UserSelection.self, from: data) {
                if let questionSelection = userSelection.questionSelection,
                   let questionListID = userSelection.questionListID,
                   let studyMode = userSelection.studyMode {
                    self.questionSelection = .init(rawValue: questionSelection) ?? .all
                    self.questionListID = UUID(uuidString: questionListID) ?? UUID()
                    self.studyMode = .init(rawValue: studyMode) ?? .brandToGeneric
                }
            }
        }
    }

}
