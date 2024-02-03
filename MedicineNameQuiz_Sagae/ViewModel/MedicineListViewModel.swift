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
    // 内用薬、注射薬、外用薬のデータを格納する変数
    var medicineNameData: [MedicineItem] {
        medicineClassification.medicineNameData
    } // medicineNameData ここまで
    // 薬の検索に使う変数
    var searchMedicineNameText: String = ""
    // 検索された薬名データを格納する配列
    var searchedMedicineNameData: [MedicineItem] {
        // 検索キーワードが空だったら、全てのデータを表示
        if searchMedicineNameText.isEmpty {
            return medicineNameData
            // 検索キーワードが入力されていたら
        } else {
            // 検索キーワードを先発品名または一般名に含むデータを探す
            let filteredMedicineNameData = medicineNameData.filter( { medicineName in
                medicineName.originalName.contains(searchMedicineNameText) || medicineName.genericName.contains(searchMedicineNameText)
            }) // filteredMedicineNameData ここまで
            // 検索キーワードを先発品名または一般名に含むデータを表示
            return filteredMedicineNameData
        } // if ここまで
    } // searchedMedicineNameData ここまで
    
    // Core DataからフェッチしたデータをMedicineItem型に変換する
    func convertToMedicineItem(from fetchedCustomMedicineNameList: FetchedResults<CustomMedicineName>) -> [MedicineItem] {
        // カスタムが選択されている場合は、CoreDataからfetchしたデータをshownMedicineListに格納
        fetchedCustomMedicineNameList.compactMap( { customMedicineName in
            MedicineItem(medicineCategory: medicineClassification.rawValue,
                         originalName: customMedicineName.originalName ?? "",
                         genericName: customMedicineName.genericName ?? "")
        } ) // compactMap ここまで
    } // convertToMedicineItem ここまで
    
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
