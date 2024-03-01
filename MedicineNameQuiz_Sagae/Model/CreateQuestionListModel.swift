//
//  CreateQuestionListModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/02/23.
//

import SwiftUI

final class CreateQuestionListModel {
    // 内用薬、注射薬、外用薬のデータをこの配列に格納
    private var listItems: [MedicineListItem] = []
    
    // 薬データをフェッチ
    func fetchMedicineListItems(fetchedCustomMedicines: FetchedResults<CustomMedicine>) -> [MedicineListItem] {
        // 内用薬、注射薬、外用薬のデータを取得していなければ、取得する
        if listItems.isEmpty {
            // 薬のデータを配列に格納
            listItems = CSVLoader.loadCsvFile(resourceName: "MedicineNameList")
            // カンマ（,）で分割した配列を作成
                .map({ line in
                    line.components(separatedBy: ",")
                })
            // MedicineListItem構造体にする
                .compactMap({ array in
                    MedicineListItem(category: MedicineCategory.getCategory(from: array[1]),
                                     brandName: array[2],
                                     genericName: array[3],
                                     selected: false)
                })
        } // if ここまで
        // カスタムの薬データをフェッチ
        let customMedicineDataArray = fetchedCustomMedicines
        // MedicineListItem構造体にする
            .compactMap({ customMedicine in
                MedicineListItem(category: MedicineCategory.getCategory(from: customMedicine.category ?? ""),
                                 brandName: customMedicine.brandName ?? "",
                                 genericName: customMedicine.genericName ?? "",
                                 selected: false)
            })
        return listItems + customMedicineDataArray
    } // fetchMedicineListItems ここまで
} // CreateQuestionListModel ここまで
