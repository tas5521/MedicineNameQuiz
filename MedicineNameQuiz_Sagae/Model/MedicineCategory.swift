//
//  MedicineCategory.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import Foundation

enum MedicineCategory: String, CaseIterable {
    case oral = "内用薬"
    case injection = "注射薬"
    case topical = "外用薬"
    case custom = "カスタム"

    // 薬のデータをこの配列に格納
    static private var items: [MedicineItem] = []

    // 薬のデータ
    var medicineNameData: [MedicineItem] {
        // もし薬データを読み込んでいなかったら
        if MedicineCategory.items.isEmpty {
            // 薬のデータを配列に格納
            MedicineCategory.items = CSVLoader.loadCsvFile(resourceName: "MedicineNameList")
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
        let filteredItems = MedicineCategory.items.filter( { medicineData in
            medicineData.category == self
        })
        // 薬の名前の要素の配列を返却
        return filteredItems
    } // medicineNameData ここまで
    
    // 文字列（内用薬、注射薬、外用薬、カスタム）から列挙子に変換するメソッド
    static func getCategory(from categoryName: String) -> MedicineCategory {
        MedicineCategory(rawValue: categoryName) ?? .custom
    } // getCategory ここまで
} // MedicineCategory ここまで
