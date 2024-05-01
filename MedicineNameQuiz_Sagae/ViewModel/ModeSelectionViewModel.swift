//
//  ModeSelectionViewModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/03/22.
//

import SwiftUI

@Observable
final class ModeSelectionViewModel {
    // 出題設定を管理する変数
    var questionSelection: QuestionSelectionMode = .all
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
