//
//  ModeSelectionViewModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/03/22.
//

import SwiftUI

@Observable
final class ModeSelectionViewModel {
    // 問題を選択するために用いる番号
    var questionIndex: Int = 0
    // モード選択を管理する変数
    var modeSelection: StudyMode = .brandToGeneric
    // 問題を格納する配列
    var questions: [StudyItem] = []

    // 問題を作成するメソッド
    func createQuestions(questionLists: FetchedResults<QuestionList>) {
        if questionIndex == 0 {
            // CSVからデータを取得
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
            // csvStudyItemsの配列の要素数が20未満の場合は、最後のindexの値を要素の数にする。20以上の場合は、20個にする
            let endIndex = min(20, csvStudyItems.count)
            // csvのデータをシャッフルして初めの20個（20未満なら要素数分）を出題
            questions = Array(csvStudyItems.shuffled()[0..<endIndex])
        } else {
            // CoreDataから問題を取得し、StudyItem型に変換
            // questionIndex = 0にランダム20問を割り当てたので、ここをquestionIndex - 1にしないとindex番号がズレてしまう。
            let studyItems = (questionLists[questionIndex - 1].questions as? Set<Question>)?
                .map {
                    StudyItem(category: MedicineCategory.getCategory(from: $0.category ?? ""),
                              brandName: $0.brandName ?? "",
                              genericName: $0.genericName ?? "",
                              studyResult: .incorrect)
                } ?? []
            // データをシャッフルして出題
            questions = studyItems.shuffled()
        } // if ここまで
    } // createQuestions ここまで
} // ModeSelectionViewModel ここまで
