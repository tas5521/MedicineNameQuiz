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
    // 薬の検索に使う変数
    var searchMedicineNameText: String = ""
    // 検索された薬名データを格納する配列
    var searchedMedicineNameData: [MedicineItem] {
        // 検索キーワードが空だったら、全てのデータを表示
        if searchMedicineNameText.isEmpty {
            return medicineClassification.medicineNameData
            // 検索キーワードが入力されていたら
        } else {
            // 検索キーワードを先発品名または一般名に含むデータを探す
            let filteredMedicineNameData = medicineClassification.medicineNameData.filter( { medicineName in
                medicineName.originalName.contains(searchMedicineNameText) || medicineName.genericName.contains(searchMedicineNameText)
            }) // filteredMedicineNameData ここまで
            // 検索キーワードを先発品名または一般名に含むデータを表示
            return filteredMedicineNameData
        } // if ここまで
    } // searchedMedicineNameData ここまで
} // MedicineListViewModel ここまで
