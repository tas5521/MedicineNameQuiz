//
//  CreateQuestionListViewModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/02/23.
//

import Foundation

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
} // CreateQuestionListViewModel ここまで
