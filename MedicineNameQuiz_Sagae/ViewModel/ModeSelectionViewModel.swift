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
        // 値が変更されたら、UserDefaultsに保存
        didSet {
            saveUserSelection()
        } // didSet ここまで
    } // questionListID ここまで
    // モード選択を管理する変数
    var studyMode: StudyMode = .brandToGeneric {
        // 値が変更されたら、UserDefaultsに保存
        didSet {
            saveUserSelection()
        } // didSet ここまで
    } // studyMode ここまで
    // 出題設定を管理する変数
    var questionSelection: QuestionSelectionMode = .all {
        // 値が変更されたら、UserDefaultsに保存
        didSet {
            saveUserSelection()
        } // didSet ここまで
    } // questionSelection ここまで

    // 問題を格納する配列
    var questions: [StudyItem] = []

    // UserDefaultsの保存と読み出しで使うキー
    private let userDefaultsKey = "userSelection"

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

    // Pickerの選択の状態を読み込むメソッド
    func loadUserSelection() {
        // JSONDecoderのインスタンスを生成
        let decoder = JSONDecoder()
        // JSONのキー名をSwiftの型のプロパティ名にどのようにマッピングするかを指定（JSONのキー名をそのままSwiftのプロパティ名として使用）
        decoder.keyDecodingStrategy = .useDefaultKeys
        // UserDefaultsからデータを取得
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else { return }
        // Userdefaultsから取得したデータをUserSelection構造体に変換
        if let userSelection = try? decoder.decode(UserSelection.self, from: data) {
            // UserSelection構造体から各Pickerの状態を取得
            questionListID = userSelection.questionListID
            studyMode = userSelection.studyMode
            questionSelection = userSelection.questionSelection
        } // if let ここまで
    } // loadUserSelection ここまで
} // ModeSelectionViewModel ここまで

extension ModeSelectionViewModel {
    private struct UserSelection: Codable {
        var questionListID: UUID
        var studyMode: StudyMode
        var questionSelection: QuestionSelectionMode
    } // UserSelection ここまで
} // ModeSelectionViewModel拡張 ここまで
