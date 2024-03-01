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
    var category: MedicineCategory = .oral
    // 薬の検索に使う変数
    var medSearchText: String = ""
    
    // 内用薬の配列
    var oralListItems: [MedicineListItem] = []
    // 注射薬の配列
    var injectionListItems: [MedicineListItem] = []
    // 外用薬の配列
    var topicalListItems: [MedicineListItem] = []
    // カスタム薬の配列
    var customListItems: [MedicineListItem] = []
    
    // CreateQuestionListModelのインスタンスを生成
    private let createQuestionListModel = CreateQuestionListModel()

    // 薬データをフェッチ
    func fetchListItems(fetchedCustomMedicines: FetchedResults<CustomMedicine>) {
        // 薬データを取得
        let medicineListItems = createQuestionListModel.fetchListItems(
            fetchedCustomMedicines: fetchedCustomMedicines
        )
        // 薬データを配列に格納
        oralListItems = medicineListItems.filter({ medicineData in
            medicineData.category == .oral
        }) // oralListItems ここまで
        injectionListItems = medicineListItems.filter({ medicineData in
            medicineData.category == .injection
        }) // injectionListItems ここまで
        topicalListItems = medicineListItems.filter({ medicineData in
            medicineData.category == .topical
        }) // topicalListItems ここまで
        customListItems = medicineListItems.filter({ medicineData in
            medicineData.category == .custom
        }) // customListItems ここまで
    } // fetchListItems ここまで
} // CreateQuestionListViewModel ここまで
