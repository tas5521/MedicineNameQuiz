//
//  MedicineListViewModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/01/29.
//

import Foundation

@Observable
final class MedicineListViewModel {
    // 選択されているタブを管理する変数
    var medicineClassification: MedicineClassification = .internalMedicine
    // 薬データを格納する変数
    var medicineNameData: [MedicineItem] {
        medicineClassification.medicineNameData
    } // medicineNameData ここまで
} // MedicineListViewModel ここまで
