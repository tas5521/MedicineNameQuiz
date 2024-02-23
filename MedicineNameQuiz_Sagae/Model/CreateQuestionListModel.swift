//
//  CreateQuestionListModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/02/23.
//

import SwiftUI

final class CreateQuestionListModel {
    // 内用薬、注射薬、外用薬のデータをこの配列に格納
    private var medicineDataArray: [MedicineListItem] = []
    
    // 薬データをフェッチ
    func fetchMedicineListItems(fetchedCustomMedicines: FetchedResults<CustomMedicine>) -> [MedicineListItem] {
        // 内用薬、注射薬、外用薬のデータを取得していなければ、取得する
        if medicineDataArray.isEmpty {
            // CSV読み込みのクラスのインスタンスを生成
            let csvLoader = CSVLoader()
            // 全ての薬データのCSVLineを取得
            let medicineDataCSVLines = csvLoader.loadCsvFile(resourceName: "MedicineNameList")
            // 薬のデータを配列に格納
            medicineDataArray = medicineDataCSVLines
            // カンマ（,）で分割した配列を作成
                .map({ line in
                    line.components(separatedBy: ",")
                })
            // MedicineListItem構造体にする
                .compactMap({ array in
                    MedicineListItem(medicineCategory: array[1],
                                     originalName: array[2],
                                     genericName: array[3],
                                     selected: false)
                })
        } // if ここまで
        // カスタムの薬データをフェッチ
        let customMedicineDataArray = fetchedCustomMedicines
        // MedicineListItem構造体にする
            .compactMap({ customMedicine in
                MedicineListItem(medicineCategory: customMedicine.medicineCategory ?? "",
                                 originalName: customMedicine.originalName ?? "",
                                 genericName: customMedicine.genericName ?? "",
                                 selected: false)
            })
        return medicineDataArray + customMedicineDataArray
    } // fetchMedicineListItems ここまで
} // CreateQuestionListModel ここまで
