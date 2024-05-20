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
    var questionListID: UUID = UUID()
    // 出題設定を管理する変数
    var questionSelection: QuestionSelectionMode = .all
    // モード選択を管理する変数
    var studyMode: StudyMode = .brandToGeneric

    // 問題を格納する配列
    var questions: [StudyItem] = []
    
    // UserDefaultsの保存と読み出しで使うキー
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
    
    // Pickerの選択の状態を保存するメソッド
    func saveUserSelection() {
        // UserSelectionのインスタンスを生成
        let userSelection = UserSelection(questionListID: questionListID,
                                          studyMode: studyMode,
                                          questionSelection: questionSelection)
        // JSONEncoderのインスタンスを生成
        let encoder = JSONEncoder()
        // プロパティ名をどのようにエンコードするかを指定（ここでは、Swiftのプロパティ名をそのままJSONのキー名として使用）
        encoder.keyEncodingStrategy = .useDefaultKeys
        // userSelectionをバイナリデータに変換
        if let data = try? encoder.encode(userSelection) {
            // UserDefaultsに保存
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } // if let ここまで
    } // saveUserSelection ここまで
} // ModeSelectionViewModel ここまで

extension ModeSelectionViewModel {
    private struct UserSelection: Codable {
        var questionListID: UUID
        var studyMode: StudyMode
        var questionSelection: QuestionSelectionMode
    } // UserSelection ここまで
} // ModeSelectionViewModel拡張 ここまで
