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
    // CSVをロードしたデータを1度だけ格納して記憶するためにstaticにしている
    static private var csvItems: [MedicineItem] = []

    // フィルターした薬のデータ
    var filteredItems: [MedicineItem] {
        // もし薬データを読み込んでいなかったら
        if MedicineCategory.csvItems.isEmpty {
            // 薬のデータを配列に格納
            MedicineCategory.csvItems = CSVLoader.loadCsvFile(resourceName: "MedicineNameList")
                // カンマ（,）で分割した配列を作成
                .map { $0.components(separatedBy: ",") }
                // MedicineItem構造体にする
                .compactMap {
                    MedicineItem(category: MedicineCategory.getCategory(from: $0[1]),
                                 brandName: $0[2],
                                 genericName: $0[3])
                }
        } // if ここまで
        // 選択された区分により、データをフィルターする
        let filteredItems = MedicineCategory.csvItems.filter({ medicineData in
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
