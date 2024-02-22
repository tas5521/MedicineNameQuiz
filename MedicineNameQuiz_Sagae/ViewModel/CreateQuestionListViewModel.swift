//
//  CreateQuestionListViewModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/02/23.
//

import SwiftUI
import CoreData

@Observable
final class CreateQuestionListViewModel {
    // 問題リストの名前を保持する変数
    var listName: String = ""
    // 選択されているタブを管理する変数
    var medicineClassification: MedicineClassification = .internalMedicine
    // 薬の検索に使う変数
    var searchMedicineName: String = ""
    
    // 内用薬の配列
    var internalMedicineList: [MedicineListItem] = []
    // 注射薬の配列
    var injectionMedicineList: [MedicineListItem] = []
    // 外用薬の配列
    var externalMedicineList: [MedicineListItem] = []
    // カスタム薬の配列
    var customMedicineList: [MedicineListItem] = []
    
    // 薬のデータをこの配列に格納
    private var medicineDataArray: [MedicineListItem] = []
    
    // 薬データをフェッチ
    func fetchMedicineListItem(fetchedCustomMedicines: FetchedResults<CustomMedicine>) {
        // CSVデータを取得していなければ、取得する
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
        // 薬データを配列に格納
        internalMedicineList = medicineDataArray.filter({ medicineData in medicineData.medicineCategory == "内用薬" })
        injectionMedicineList = medicineDataArray.filter({ medicineData in medicineData.medicineCategory == "注射薬" })
        externalMedicineList = medicineDataArray.filter({ medicineData in medicineData.medicineCategory == "外用薬" })
        customMedicineList = fetchedCustomMedicines
        // MedicineListItem構造体にする
            .compactMap({ array in
                MedicineListItem(medicineCategory: array.medicineCategory ?? "",
                                 originalName: array.originalName ?? "",
                                 genericName: array.genericName ?? "",
                                 selected: false)
            })
    } // fetchMedicineListItem ここまで
} // CreateQuestionListViewModel ここまで
