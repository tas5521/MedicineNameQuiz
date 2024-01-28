//
//  MedicineNameItem.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import Foundation

struct MedicineNameItem: Identifiable {
    var id: UUID = UUID()
    var originalName: String
    var genericName: String
} // MedicineNameItem ここまで
