//
//  MedicineListViewModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/01/29.
//

import SwiftUI
import CoreData

@Observable
final class MedicineListViewModel {
    // 選択されているタブを管理する変数
    var medicineClassification: MedicineClassification = .internalMedicine
    // 薬データを格納する変数
    var medicineNameData: [MedicineNameItem] {
        medicineClassification.medicineNameData
    } // medicineNameData ここまで
    // 検索された薬名データを格納する配列
    var searchedMedicineNameData: [MedicineNameItem] = []

    // 薬名を検索するメソッド
    func searchMedicineName(keyword: String) {
        // 検索キーワードが空だったら、全てのデータを表示
        if keyword.isEmpty {
            searchedMedicineNameData = medicineNameData
            // 検索キーワードが入力されていたら
        } else {
            // 検索キーワードを先発品名または一般名に含むデータを探す
            let filteredMedicineNameData = medicineNameData.filter( { medicineName in
                medicineName.originalName.contains(keyword) || medicineName.genericName.contains(keyword)
            }) // filteredMedicineNameData ここまで
            // 検索キーワードを先発品名または一般名に含むデータを表示
            searchedMedicineNameData = filteredMedicineNameData
        } // if ここまで
    } // searchMedicineName ここまで
    
    func deleteCustomMedicineName(index: IndexSet, fetchedCustomMedicineNameList: FetchedResults<CustomMedicineName>) {
        // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
        let context: NSManagedObjectContext = PersistenceController.shared.container.viewContext
        if let unwrappedFirstIndex = index.first {
            // CoreDataから該当するindexのメモを削除
            context.delete(fetchedCustomMedicineNameList[unwrappedFirstIndex])
            // エラーハンドリング
            do {
                // 生成したインスタンスをCoreDataに保持する
                try context.save()
            } catch {
                // このメソッドにより、クラッシュログを残して終了する
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            } // エラーハンドリングここまで
        } // if let ここまで
    } // deleteCustomMedicineName
} // MedicineListViewModel ここまで
