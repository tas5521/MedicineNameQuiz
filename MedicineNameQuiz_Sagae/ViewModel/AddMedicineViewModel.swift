//
//  AddMedicineViewModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/01/29.
//

import SwiftUI
import CoreData

final class AddMedicineViewModel {
    // カスタムの薬名を追加するメソッド
    func addCustomMedicineName(originalName: String, genericName: String) {
        // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
        let viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
        // 新しいカスタムの薬名データのインスタンスを生成
        let newCustomMedicineName = CustomMedicineName(context: viewContext)
        // 薬のカテゴリを保持
        newCustomMedicineName.medicineCategory = "カスタム"
        // 先発品名を保持
        newCustomMedicineName.originalName = originalName
        // 一般名を保持
        newCustomMedicineName.genericName = genericName
        do {
            // カスタムの薬名をCore Dataに保存
            try viewContext.save()
        } catch {
            // 何らかのエラーが発生した場合は、エラー内容をデバッグエリアに表示
            print("エラー: \(error)")
        } // do-try-catch ここまで
    } // addCustomMedicineName ここまで
} // AddMedicineViewModel ここまで
