//
//  ModeSelectionViewModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/03/22.
//

import Foundation

@Observable
final class ModeSelectionViewModel {
    // 問題を選択するために用いる番号
    var questionIndex: Int = -1
    // モード選択を管理する変数
    var modeSelection: StudyMode = .brandToGeneric
    // 問題を格納する配列
    var questions: [StudyItem] = []
    // ダミーのリスト
    let dummyQuestionNameList: [String] = ["さがえ薬局リスト", "ながつ薬局リスト", "こばやし薬局リスト"]

    // 問題を作成するメソッド
    // TODO: CoreDataからの問題作成もこのメソッドで行う（CoreDataからの出題を実装する際に、ダミーの問題の部分をCoreDataのデータにする処理を書く）
    func createQuestions() {
        if questionIndex < 0 {
            let csvStudyItems = CSVLoader.loadCsvFile(resourceName: "MedicineNameList")
                // カンマ（,）で分割した配列を作成
                .map { $0.components(separatedBy: ",") }
                // StudyItem構造体にする
                .map {
                    StudyItem(category: MedicineCategory.getCategory(from: $0[1]),
                              brandName: $0[2],
                              genericName: $0[3],
                              studyResult: .incorrect)
                } // map ここまで
            // csvのデータをシャッフルして初めの20個を出題
            questions = Array(csvStudyItems.shuffled()[0..<20])
        } else {
            // ダミーの問題を出題
            questions = [
                StudyItem(category: .oral,
                          brandName: "ダミーの商品名",
                          genericName: "ダミーの一般名",
                          studyResult: .incorrect)
            ] // dummyStudyItem ここまで
        } // if ここまで
    } // createQuestions ここまで
} // ModeSelectionViewModel ここまで
