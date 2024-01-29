//
//  AddMedicineViewModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/01/29.
//

import SwiftUI
import CoreData

final class AddMedicineViewModel {
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    private let context: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    
    // ユーザー独自の薬名を追加するメソッド
    func addUserOriginalMedicineName(originalName: String, genericName: String) {
        // 新しいユーザー独自の薬名をCore Dataに保存
        let newCustomMedicineName = CustomMedicineName(context: context)
        newCustomMedicineName.originalName = originalName
        newCustomMedicineName.genericName = genericName
        do {
            try context.save()
        } catch {
            // 何らかのエラーが発生した場合は、エラー内容をデバッグエリアに表示
            print("エラー: \(error)")
        } // do-try-catch ここまで
    } // addUserOriginalMedicineName ここまで
} // AddMedicineViewModel ここまで
