//
//  CreateQuestionListViewModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/02/23.
//

import SwiftUI

@Observable
final class CreateQuestionListViewModel {
    // 問題リストの名前を保持する変数
    var listName: String = ""
    // 選択されているタブを管理する変数
    var medicineClassification: MedicineCategory = .oral
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
    
    // CreateQuestionListModelのインスタンスを生成
    private let createQuestionListModel = CreateQuestionListModel()

    // 薬データをフェッチ
    func fetchMedicineListItems(fetchedCustomMedicines: FetchedResults<CustomMedicine>) {
        // 薬データを取得
        let medicineListItems = createQuestionListModel.fetchMedicineListItems(fetchedCustomMedicines: fetchedCustomMedicines)
        // 薬データを配列に格納
        internalMedicineList = medicineListItems.filter({ medicineData in
            medicineData.category == .oral
        }) // internalMedicineList ここまで
        injectionMedicineList = medicineListItems.filter({ medicineData in
            medicineData.category == .injection
        }) // injectionMedicineList ここまで
        externalMedicineList = medicineListItems.filter({ medicineData in
            medicineData.category == .topical
        }) // externalMedicineList ここまで
        customMedicineList = medicineListItems.filter({ medicineData in
            medicineData.category == .customMedicine
        }) // customMedicineList ここまで
    } // fetchMedicineListItems ここまで
} // CreateQuestionListViewModel ここまで
