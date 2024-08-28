//
//  QuestionSelectionMode.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/05/01.
//

import Foundation

enum QuestionSelectionMode: String, CaseIterable, Codable {
    // 全ての問題
    case all = "全ての問題"
    // まだ答えていない問題もしくは間違えた問題
    case unansweredOrIncorrect = "わからない問題"
} // QuestionSelectionMode ここまで
