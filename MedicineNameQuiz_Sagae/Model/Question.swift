//
//  Question.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import Foundation

struct Question: Identifiable {
    var id: UUID = UUID()
    var originalName: String
    var genericName: String
} // Question ここまで
