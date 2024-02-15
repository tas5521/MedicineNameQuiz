//
//  File.swift
//  MedicineNameQuiz_Sagae
//
//  Created by Yoshinori Kobayashi on 2024/01/31.
//

import Foundation

class SharedCSVData: ObservableObject {
    @Published var medicineData: [MedicineNameItem] = []

    init() {
        // 全ての薬データのCSVLineを取得
        let medicineDataCSVLines = self.loadCsvFile(resourceName: "MedicineNameList")

        // カンマ（,）で分割した配列を作成
        let medicineDataArray = medicineDataCSVLines.map( { line in line.components(separatedBy: ",")} )
        // 先発品名と一般名を取得する
        for medicine in medicineDataArray {
            // 配列の第2要素が先発品名、第3要素が一般名
            let originalName = medicine[2]
            let genericName = medicine[3]
            // 薬の先発品名と一般名の組み合わせの要素を作成
            let medicineNameItem = MedicineNameItem(originalName: originalName, genericName: genericName)
            // 薬の名前の要素の配列に格納
            medicineData.append(medicineNameItem)
        } // for ここまで

    }

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
}
