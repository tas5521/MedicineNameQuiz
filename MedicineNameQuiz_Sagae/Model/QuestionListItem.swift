//
//  QuestionListItem.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import Foundation

struct QuestionListItem: Identifiable {
    var id: UUID = UUID()
    var listName: String
    var date: Date
    var questions: [MedicineItem]
} // QuestionListItem ここまで
