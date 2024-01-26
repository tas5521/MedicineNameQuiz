//
//  NavigationBarBackground.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/01/06.
//

import SwiftUI

struct NavigationBarBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
        // ナビゲーションバーの背景を青色に変更
            .toolbarBackground(.navigationBarBlue, for: .navigationBar)
        // ナビゲーションバーの背景を表示
            .toolbarBackground(.visible, for: .navigationBar)
        // ナビゲーションバーのタイトルの色を白にする
            .toolbarColorScheme(.dark)
    } // body ここまで
} // NavigationBarBackground ここまで

extension View {
    func navigationBarBackground() -> some View {
        modifier(NavigationBarBackground())
    } // navigationBarBackground ここまで
} // View拡張ここまで
