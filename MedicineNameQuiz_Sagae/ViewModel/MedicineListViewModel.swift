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
    // Viewに表示する薬名をfilterして格納する配列
    var searchedItems: [MedicineItem] {
        let categorizedItems: [MedicineItem] = category.filteredItems
        // 検索条件がなければ、検索せずに全てのデータを返す
        guard medSearchText.isEmpty == false else {
            return categorizedItems
        } // guard ここまで
        // 検索キーワードを商品名または一般名に含むデータを返却
        return categorizedItems.filter {
            $0.brandName.contains(medSearchText) || $0.genericName.contains(medSearchText)
        }
    } // searchedItems ここまで
} // MedicineListViewModel ここまで
