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
    // 検索された薬名データを格納する配列
    var searchedMedicineNameData: [MedicineNameItem] = []

    // 薬名を検索するメソッド
    func searchMedicineName(keyword: String) {
        // 検索キーワードが空だったら、全てのデータを表示
        if keyword == "" {
            searchedMedicineNameData = medicineNameData
            // 検索キーワードが入力されていたら
        } else {
            // 検索キーワードを先発品名または一般名に含むデータを探す
            let filteredMedicineNameData = medicineNameData.filter( { medicineName in
                medicineName.originalName.contains(keyword) || medicineName.genericName.contains(keyword)
            }) // filteredMedicineNameData ここまで
            // 検索キーワードを先発品名または一般名に含むデータを表示
            searchedMedicineNameData = filteredMedicineNameData
        } // if ここまで
    } // searchMedicineName ここまで
} // MedicineListViewModel ここまで
