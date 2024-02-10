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
    // 薬の検索に使う変数
    var searchMedicineNameText: String = ""
    // Viewに表示する薬名を格納する配列
    var medicineItems: [MedicineItem] {
        let medicineNameData: [MedicineItem] = medicineClassification.medicineNameData
        // 検索条件がなければ、検索せずに全てのデータを返す
        guard searchMedicineNameText.isEmpty == false else {
            return medicineNameData
        } // guard ここまで
        // 検索キーワードを先発品名または一般名に含むデータを探す
        let filteredMedicines = medicineNameData.filter( { medicineName in
            medicineName.originalName.contains(searchMedicineNameText) || medicineName.genericName.contains(searchMedicineNameText)
        }) // filteredMedicines ここまで
        // 検索キーワードを先発品名または一般名に含むデータを表示
        return filteredMedicines
    } // medicineItems ここまで

    // カスタムの薬リストに検索をかけるメソッド
    func searchCustomMedicine(fetchedCustomMedicines: FetchedResults<CustomMedicineName>) {
        // 検索キーワードが空の場合
        if searchMedicineNameText.isEmpty {
            // 検索条件を無し（nil）にする
            fetchedCustomMedicines.nsPredicate = nil
        } else {
            // 検索キーワードがある場合
            // originalNameに検索キーワードを含むか調べる条件を指定
            let originalNamePredicate: NSPredicate = NSPredicate(format: "originalName contains %@", searchMedicineNameText)
            // genericNameに検索キーワードを含むか調べる条件を指定
            let genericNamePredicate: NSPredicate = NSPredicate(format: "genericName contains %@", searchMedicineNameText)
            // 指定した条件を適用し、検索をかける
            fetchedCustomMedicines.nsPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [originalNamePredicate, genericNamePredicate])
        } // if ここまで
    } // searchCustomMedicine ここまで

    // Core Dataから指定したカスタムの薬名のデータを削除するメソッド
    func deleteCustomMedicineData(index: IndexSet, fetchedCustomMedicines: FetchedResults<CustomMedicineName>) {
        // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
        let context: NSManagedObjectContext = PersistenceController.shared.container.viewContext
        if let unwrappedFirstIndex = index.first {
            // CoreDataから該当するindexのメモを削除
            context.delete(fetchedCustomMedicines[unwrappedFirstIndex])
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
    } // deleteCustomMedicineData ここまで
} // MedicineListViewModel ここまで
