//
//  ViewExtension.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/02.
//

import SwiftUI

extension View {
    // 本アプリでよく使うカスタムのナビゲーションバーモディファイアの大元
    private func customNavigationBarModifier(place: ToolbarItemPlacement, button: () -> some View) -> some View {
        self
        // デフォルトのバックボタンを隠す
            .navigationBarBackButtonHidden(true)
            .toolbar {
                // カスタムのボタンの位置を指定
                ToolbarItem(placement: place) {
                    // カスタムのボタン
                    button()
                    // 色を指定
                        .foregroundColor(Color.black)
                } // ToolbarItem ここまで
            } // toolbarここまで
    } // customNavigationBarModifier
    
    // ナビゲーションバーの左に戻るボタンを配置するModifier
    func placeCustomBackButton(action: @escaping () -> ()) -> some View {
        self
            .customNavigationBarModifier(place: .navigationBarLeading) {
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
            } // customNavigationBarModifier ここまで
    } // placeCustomBackButton ここまで
    
    // ナビゲーションバーの右にボタンを配置するModifier
    func placeCustomButtonTrailing(label: String, action: @escaping () -> ()) -> some View {
        self
            .customNavigationBarModifier(place: .navigationBarTrailing) {
                Button {
                    // 渡されたアクションを呼び出す
                    action()
                } label: {
                    // ラベル
                    Text(label)
                } // Button ここまで
            } // customNavigationBarModifier ここまで
    } // placeCustomButtonTrailing ここまで
    
    // ナビゲーションバーの右にナビゲーションリンクを配置するModifier
    func placeCustomNavigationLinkTrailing(label: String, transitionTo: () -> some View) -> some View {
        self
            .customNavigationBarModifier(place: .navigationBarTrailing) {
                NavigationLink {
                    // 遷移先
                    transitionTo()
                } label: {
                    // ラベル
                    Text(label)
                } // Button ここまで
            } // customNavigationBarModifier ここまで
    } // placeCustomNavigationLinkTrailing ここまで
} // View拡張ここまで


