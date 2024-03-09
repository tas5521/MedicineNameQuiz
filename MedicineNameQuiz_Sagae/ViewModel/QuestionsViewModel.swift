//
//  QuestionsViewModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/03/09.
//

import Foundation

@Observable
final class QuestionsViewModel {
    // 問題の配列
    var questions: [MedicineItem] {
        // NSSet型のquestionList.questionsをSet<Question>型にキャスト
        guard let questions = questionList.questions as? Set<Question> else { return [] }
        // MedicineItem型にして、商品名の昇順にソート
        return questions.map {
            MedicineItem(
                category: MedicineCategory(rawValue: $0.category ?? "") ?? .custom,
                brandName: $0.brandName ?? "",
                genericName: $0.genericName ?? ""
            )
        }
        .sorted(by: { $0.brandName < $1.brandName })
    } // questions ここまで
    // 薬の名前の検索テキスト
    var medSearchText: String = ""
    // 問題リスト
    let questionList: QuestionList

    // イニシャライザ
    init(questionList: QuestionList) {
        self.questionList = questionList
    } // init ここまで
} // QuestionsViewModel ここまで
