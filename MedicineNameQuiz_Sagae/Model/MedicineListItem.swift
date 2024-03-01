//
//  MedicineListItem.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/12/21.
//

import Foundation

struct MedicineListItem: Identifiable {
    var id: UUID = UUID()
    let medicineCategory: MedicineClassification
    let brandName: String
    let genericName: String
    var selected: Bool
} // MedicineListItem ここまで
