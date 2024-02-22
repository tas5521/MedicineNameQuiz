//
//  SelectedClassification.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import Foundation

enum MedicineClassification: String, CaseIterable {
    case internalMedicine = "内用薬"
    case injectionMedicine = "注射薬"
    case externalMedicine = "外用薬"
    case customMedicine = "カスタム"

    // 薬のデータをこの配列に格納
    static private var medicineDataArray: [MedicineItem] = []

    // 薬のデータ
    var medicineNameData: [MedicineItem] {
        // もし薬データを読み込んでいなかったら
        if MedicineClassification.medicineDataArray.isEmpty {
            let csvLoader = CSVLoader()
            // 全ての薬データのCSVLineを取得
            let medicineDataCSVLines = csvLoader.loadCsvFile(resourceName: "MedicineNameList")
            // 薬のデータを配列に格納
            MedicineClassification.medicineDataArray = medicineDataCSVLines
            // カンマ（,）で分割した配列を作成
                .map({ line in
                    line.components(separatedBy: ",")
                })
            // MedicineItem構造体にする
                .compactMap({ array in
                    MedicineItem(medicineCategory: array[1], originalName: array[2], genericName: array[3])
                })
        } // if ここまで
        // 選択された区分により、データをフィルターする
        let filteredMedicineDataArray = MedicineClassification.medicineDataArray.filter( { medicineData in
            medicineData.medicineCategory == self.rawValue
        })
        // 薬の名前の要素の配列を返却
        return filteredMedicineDataArray
    } // medicineNameData ここまで
} // MedicineClassificationここまで
