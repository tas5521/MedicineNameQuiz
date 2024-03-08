//
//  QuestionsViewModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/03/09.
//

import Foundation

@Observable
final class QuestionsViewModel {
    // 問題リスト
    let questionList: QuestionList
    // 問題の配列
    var questions: [MedicineItem] {
        self.getQuestionItems(from: questionList.questions as? Set<Question> ?? [])
    } // questions ここまで

    // イニシャライザ
    init(questionList: QuestionList) {
        self.questionList = questionList
    } // init ここまで

    // [MedicineItem]型の配列を取得するメソッド
    private func getQuestionItems(from questions: Set<Question>) -> [MedicineItem] {
        questions.map {
            MedicineItem(
                category: MedicineCategory(rawValue: $0.category ?? "") ?? .custom,
                brandName: $0.brandName ?? "",
                genericName: $0.genericName ?? ""
            )
        }
        .sorted(by: { $0.brandName < $1.brandName })
    } // getQuestionItems ここまで
} // QuestionsViewModel ここまで
