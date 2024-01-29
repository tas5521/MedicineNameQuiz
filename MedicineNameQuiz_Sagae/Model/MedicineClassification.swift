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
    
    // 薬のデータ
    var medicineNameData: [MedicineNameItem] {
        // 全ての薬データのCSVLineを取得
        let medicineDataCSVLines = self.loadCsvFile(resourceName: "MedicineNameList")
        // カンマ（,）で分割した配列を作成
        let medicineDataArray = medicineDataCSVLines.map( { line in line.components(separatedBy: ",")} )
        // 選択された区分により、データをフィルターする
        let filteredMedicineDataArray = medicineDataArray.filter( { medicineData in medicineData[1] == self.rawValue} )
        // 薬の名前の要素を格納する空の配列を作成
        var medicineNameItems: [MedicineNameItem] = []
        // 先発品名と一般名を取得する
        for medicineData in filteredMedicineDataArray {
            // 配列の第2要素が先発品名、第3要素が一般名
            let originalName = medicineData[2]
            let genericName = medicineData[3]
            // 薬の先発品名と一般名の組み合わせの要素を作成
            let medicineNameItem = MedicineNameItem(originalName: originalName, genericName: genericName)
            // 薬の名前の要素の配列に格納
            medicineNameItems.append(medicineNameItem)
        } // for ここまで
        // 薬の名前の要素の配列を返却
        return medicineNameItems
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
