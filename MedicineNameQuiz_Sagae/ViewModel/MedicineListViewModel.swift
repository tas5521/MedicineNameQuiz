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
    var category: MedicineCategory = .oral
    // 薬の検索に使う変数
    var medSearchText: String = ""
    // Viewに表示する薬名を格納する配列
    var items: [MedicineItem] {
        let medicineNameData: [MedicineItem] = category.medicineNameData
        // 検索条件がなければ、検索せずに全てのデータを返す
        guard medSearchText.isEmpty == false else {
            return medicineNameData
        } // guard ここまで
        // 検索キーワードを商品名または一般名に含むデータを探す
        let filteredMedicines = medicineNameData.filter({ medicineName in
            medicineName.brandName.contains(medSearchText) || medicineName.genericName.contains(medSearchText)
        }) // filteredMedicines ここまで
        // 検索キーワードを商品名または一般名に含むデータを表示
        return filteredMedicines
    } // items ここまで
} // MedicineListViewModel ここまで
