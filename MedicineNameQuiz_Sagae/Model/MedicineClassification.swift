//
//  SelectedClassification.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import Foundation

enum MedicineClassification: String {
    case internalMedicine = "内用薬"
    case injectionMedicine = "注射薬"
    case externalMedicine = "外用薬"
    case customMedicine = "カスタム"

    // すべてのケース
    static let allCases: [MedicineClassification] = [
        .internalMedicine,
        .injectionMedicine,
        .externalMedicine,
        .customMedicine
    ] // allCases ここまで
} // SelectedClassificationここまで
