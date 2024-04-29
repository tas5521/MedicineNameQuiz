//
//  ModeSelectionViewModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/03/22.
//

import SwiftUI

@Observable
final class ModeSelectionViewModel {
    // 問題リストを識別するID（初期値はランダム20のものを使用）
    var questionListID: UUID = DefaultUUID.random20
    // 問題を格納する配列
    var questions: [StudyItem] = []

    // 問題を作成するメソッド
    func createQuestions(fetchedLists: FetchedResults<QuestionList>) {
        // 問題リストを識別するIDがランダム20のものの場合
        if questionListID == DefaultUUID.random20 {
            // ランダム20問を出題
            questions = createRandom20()
        } else {
            // ユーザーが独自に作成した問題リストからの出題の場合（問題を識別するIDがランダム20のものではない場合）
            // CoreDataから、該当するIDを持つ問題を取得
            if let questionList = fetchedLists.first(where: { $0.id == questionListID }) {
                // StudyItem型に変換
                let studyItems = (questionList.questions as? Set<Question>)?
                    .map {
                        StudyItem(category: MedicineCategory.getCategory(from: $0.category ?? ""),
                                  brandName: $0.brandName ?? "",
                                  genericName: $0.genericName ?? "",
                                  studyResult: .unanswered)
                    } ?? []
                // データをシャッフルして出題
                questions = studyItems.shuffled()
            } else {
                // CoreDataから、該当するIDを持つ問題を取得できなかった場合、ランダム20問を出題（クラッシュの回避のため）
                questions = createRandom20()
            } // if let ここまで
        } // if ここまで
    } // createQuestions ここまで

    // ランダム20問を作成するメソッド
    private func createRandom20() -> [StudyItem] {
        // CSVからデータを取得
        let csvStudyItems = CSVLoader.loadCsvFile(resourceName: "MedicineNameList")
            // カンマ（,）で分割した配列を作成
            .map { $0.components(separatedBy: ",") }
            // StudyItem構造体にする
            .map {
                StudyItem(category: MedicineCategory.getCategory(from: $0[1]),
                          brandName: $0[2],
                          genericName: $0[3],
                          studyResult: .unanswered)
            } // map ここまで
        // csvStudyItemsの配列の要素数が20未満の場合は、最後のindexの値を要素の数にする。20以上の場合は、20個にする
        let endIndex = min(20, csvStudyItems.count)
        // csvのデータをシャッフルして初めの20個（20未満なら要素数分）を出題
        return Array(csvStudyItems.shuffled()[0..<endIndex])
    } // createRandom20 ここまで
} // ModeSelectionViewModel ここまで
