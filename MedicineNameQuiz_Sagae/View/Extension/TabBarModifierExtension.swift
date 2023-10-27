//
//  ViewExtension.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/02.
//

import SwiftUI

// Viewを拡張し、オリジナルのTabBarModifierを作成
extension View {
    // ナビゲーションバーにオリジナルのボタンを指定するためのModifier
    private func navigationBarWithOriginalButton(place: ToolbarItemPlacement, button: () -> some View) -> some View {
        self
        // デフォルトのバックボタンを隠す
            .navigationBarBackButtonHidden(true)
            .toolbar {
                // ボタンの位置を指定
                ToolbarItem(placement: place) {
                    button()
                    // 色を指定
                        .foregroundColor(Color.black)
                } // ToolbarItem ここまで
            } // toolbarここまで
    } // navigationBarWithOriginalButton ここまで
    
    // ナビゲーションバーの左に戻るボタンを配置するModifier
    func navigationBarWithBackButton(action: @escaping () -> ()) -> some View {
        self
            .navigationBarWithOriginalButton(place: .navigationBarLeading) {
                Button {
                    // 渡されたアクションを呼び出す
                    action()
                } label: {
                    // ラベル
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("戻る")
                    } // HStack ここまで
                } // Button ここまで
            } // navigationBarWithOriginalButton ここまで
    } // navigationBarWithBackButton ここまで
    
    // ナビゲーションバーの右にボタンを配置するModifier
    func navigationBarWithButtonTrailing(label: String, action: @escaping () -> ()) -> some View {
        self
            .navigationBarWithOriginalButton(place: .navigationBarTrailing) {
                Button {
                    // 渡されたアクションを呼び出す
                    action()
                } label: {
                    // ラベル
                    Text(label)
                } // Button ここまで
            } // navigationBarWithOriginalButton ここまで
    } // navigationBarWithButtonTrailing ここまで
    
    // ナビゲーションバーの右にナビゲーションリンクを配置するModifier
    func navigationBarWithNavigationLinkTrailing(label: String, destination: () -> some View) -> some View {
        self
            .navigationBarWithOriginalButton(place: .navigationBarTrailing) {
                NavigationLink {
                    // 遷移先
                    destination()
                } label: {
                    // ラベル
                    Text(label)
                } // Button ここまで
            } // navigationBarWithOriginalButton ここまで
    } // navigationBarWithNavigationLinkTrailing ここまで
} // View拡張ここまで
