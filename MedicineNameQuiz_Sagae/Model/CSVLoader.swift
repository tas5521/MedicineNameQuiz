//
//  CSVLoader.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/02/23.
//

import Foundation

final class CSVLoader {
    // CSVファイルを読み込む関数を作成
    func loadCsvFile(resourceName: String) -> [String] {
        // 読み込み先に、ファイルが存在してるかチェック
        guard let path = Bundle.main.path(forResource: resourceName, ofType:"csv") else {
            // 存在しなければ、エラーメッセージを配列に格納して返却
            return ["csvファイルがないよ"]
        } // guard let ここまで
        do {
            // ファイルが存在していれば、データをString型で読み込み
            let csvString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            // 改行ごとにデータを分割して配列に格納
            return csvString.components(separatedBy: .newlines)
        } catch let error as NSError {
            // 何らかのエラーが発生した場合は、エラー内容を返却
            return ["エラー: \(error)"]
        } // do-try-catch ここまで
    } // loadCsvFile ここまで
} // CSVLoader ここまで
