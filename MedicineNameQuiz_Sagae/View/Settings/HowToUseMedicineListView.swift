//
//  HowToUseMedicineListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct HowToUseMedicineListView: View {
    // 項目のタイトル
    let title: String

    var body: some View {
        // 奥から手前にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
            // セーフエリア外にも背景を表示
                .ignoresSafeArea()
            Text("HowToUseMedicineListView")
        } // ZStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle(title, displayMode: .inline)
        // ナビゲーションバーの背景を青色に変更
        .toolbarBackground(.navigationBarBlue, for: .navigationBar)
        // ナビゲーションバーの背景を表示
        .toolbarBackground(.visible, for: .navigationBar)
        // ナビゲーションバーのタイトルの色を白にする
        .toolbarColorScheme(.dark)
    } // bodyここまで
} // HowToUseMedicineListView ここまで

#Preview {
    HowToUseMedicineListView(title: "アプリの使い方-薬リスト-")
}
