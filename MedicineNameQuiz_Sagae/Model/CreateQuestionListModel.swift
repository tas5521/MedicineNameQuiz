//
//  CreateQuestionListModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/02/23.
//

import SwiftUI

final class CreateQuestionListModel {
    // 薬データをフェッチ
    static func fetchListItems(from fetchedCustomMedicines: FetchedResults<CustomMedicine>) -> [MedicineListItem] {
        // CSVの薬データを取得
        let csvListItems = CSVLoader.loadCsvFile(resourceName: "MedicineNameList")
            // カンマ（,）で分割した配列を作成
            .map { $0.components(separatedBy: ",") }
            // MedicineListItem構造体にする
            .compactMap {
                MedicineListItem(category: MedicineCategory.getCategory(from: $0[1]),
                                 brandName: $0[2],
                                 genericName: $0[3],
                                 selected: false)
            }
        // カスタムの薬データを取得
        let customListItems = fetchedCustomMedicines
            // MedicineListItem構造体にする
            .compactMap {
                MedicineListItem(category: MedicineCategory.getCategory(from: $0.category ?? ""),
                                 brandName: $0.brandName ?? "",
                                 genericName: $0.genericName ?? "",
                                 selected: false)
            }
        // 薬のデータを返却
        return csvListItems + customListItems
    } // fetchListItems ここまで
} // CreateQuestionListModel ここまで
