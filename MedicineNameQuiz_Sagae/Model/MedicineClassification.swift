//
//  SelectedClassification.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import Foundation

enum MedicineCategory: String, CaseIterable {
    case oral = "内用薬"
    case injection = "注射薬"
    case topical = "外用薬"
    case customMedicine = "カスタム"

    // 薬のデータをこの配列に格納
    static private var medicineDataArray: [MedicineItem] = []

    // 薬のデータ
    var medicineNameData: [MedicineItem] {
        // もし薬データを読み込んでいなかったら
        if MedicineCategory.medicineDataArray.isEmpty {
            // 薬のデータを配列に格納
            MedicineCategory.medicineDataArray = CSVLoader.loadCsvFile(resourceName: "MedicineNameList")
            // カンマ（,）で分割した配列を作成
                .map({ line in
                    line.components(separatedBy: ",")
                })
            // MedicineItem構造体にする
                .compactMap({ array in
                    MedicineItem(category: MedicineCategory.getCategory(from: array[1]),
                                 brandName: array[2],
                                 genericName: array[3])
                })
        } // if ここまで
        // 選択された区分により、データをフィルターする
        let filteredMedicineDataArray = MedicineCategory.medicineDataArray.filter( { medicineData in
            medicineData.category == self
        })
        // 薬の名前の要素の配列を返却
        return filteredMedicineDataArray
    } // medicineNameData ここまで
    
    // 文字列（内用薬、注射薬、外用薬、カスタム）から列挙子に変換するメソッド
    static func getCategory(from categoryName: String) -> MedicineCategory {
        MedicineCategory(rawValue: categoryName) ?? .customMedicine
    } // getCategory ここまで
} // MedicineCategory ここまで
