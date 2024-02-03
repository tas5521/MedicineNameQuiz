//
//  MedicineItem.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import Foundation

struct MedicineItem: Identifiable {
    var id: UUID = UUID()
    var medicineCategory: String
    var originalName: String
    var genericName: String
} // MedicineItem ここまで
