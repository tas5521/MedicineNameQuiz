//
//  MedicineListItem.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/12/21.
//

import Foundation

struct MedicineListItem: Identifiable {
    var id: UUID = UUID()
    let originalName: String
    let genericName: String
    var checked: Bool
} // QuestionListItem ここまで
