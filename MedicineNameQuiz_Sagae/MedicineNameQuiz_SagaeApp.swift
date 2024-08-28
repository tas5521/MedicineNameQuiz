//
//  MedicineNameQuiz_SagaeApp.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/28.
//

import SwiftUI

// アプリのエントリーポイントに指定
@main
struct MedicineNameQuiz_SagaeApp: App {
    // AppDelegateを、本App構造体に統合
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    // PersistenceControllerのインスタンス（シングルトン）を取得
    private let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        } // WindowGroup ここまで
    } // bodyここまで
} // MedicineNameQuiz_SagaeApp ここまで
