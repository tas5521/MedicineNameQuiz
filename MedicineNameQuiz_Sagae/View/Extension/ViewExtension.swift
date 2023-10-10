//
//  ViewExtension.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/02.
//

import SwiftUI

extension View {
    // デフォルトのバックボタンを隠すモディファイア
    private func hideDefaultBackButton(place: ToolbarItemPlacement, button: () -> some View) -> some View {
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
    } // hideDefaultBackButton
    
    // ナビゲーションバーの左に戻るボタンを配置するModifier
    func backButton(action: @escaping () -> ()) -> some View {
        self
            .hideDefaultBackButton(place: .navigationBarLeading) {
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
    } // backButton ここまで
    
    // ナビゲーションバーの右にボタンを配置するModifier
    func buttonTrailing(label: String, action: @escaping () -> ()) -> some View {
        self
            .hideDefaultBackButton(place: .navigationBarTrailing) {
                Button {
                    // 渡されたアクションを呼び出す
                    action()
                } label: {
                    // ラベル
                    Text(label)
                } // Button ここまで
            } // customNavigationBarModifier ここまで
    } // buttonTrailing ここまで
    
    // ナビゲーションバーの右にナビゲーションリンクを配置するModifier
    func navigationLinkTrailing(label: String, transitionTo: () -> some View) -> some View {
        self
            .hideDefaultBackButton(place: .navigationBarTrailing) {
                NavigationLink {
                    // 遷移先
                    transitionTo()
                } label: {
                    // ラベル
                    Text(label)
                } // Button ここまで
            } // customNavigationBarModifier ここまで
    } // navigationLinkTrailing ここまで
} // View拡張ここまで


