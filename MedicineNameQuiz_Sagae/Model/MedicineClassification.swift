//
//  SelectedClassification.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import Foundation
import CoreData

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
            // 全ての薬データのCSVLineを取得
            let medicineDataCSVLines = self.loadCsvFile(resourceName: "MedicineNameList")
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

    // CSVファイルを読み込む関数を作成
    private func loadCsvFile(resourceName: String) -> [String] {
        // 読み込んだCSVのデータを格納する配列を宣言
        var csvLines: [String] = []

        // 読み込み先に、ファイルが存在してるかチェック
        guard let path = Bundle.main.path(forResource: resourceName, ofType:"csv") else {
            // 存在しなければ、エラーメッセージを配列に格納して返却
            return ["csvファイルがないよ"]
        } // guard let ここまで
        do {
            // ファイルが存在していれば、データをString型で読み込み
            let csvString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            // 改行ごとにデータを分割して配列に格納
            csvLines = csvString.components(separatedBy: .newlines)
        } catch let error as NSError {
            // 何らかのエラーが発生した場合は、エラー内容を返却
            return ["エラー: \(error)"]
        } // do-try-catch ここまで
        // 読み込んだCSVを返却
        return csvLines
    } // loadCsvFile ここまで
} // MedicineClassificationここまで
