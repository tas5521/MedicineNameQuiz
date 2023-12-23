//
//  HowToUseQuestionListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct HowToUseQuestionListView: View {
    // 項目のタイトル
    let title: String

    var body: some View {
        // 奥から手前にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
            // セーフエリア外にも背景を表示
                .ignoresSafeArea()
            Text("HowToUseQuestionListView")
            // ナビゲーションバータイトルを指定
        } // ZStack ここまで
        .navigationBarTitle(title, displayMode: .inline)
    } // bodyここまで
} // HowToUseQuestionListView ここまで

#Preview {
    HowToUseQuestionListView(title: "アプリの使い方-問題リスト-")
}
