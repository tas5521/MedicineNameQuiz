//
//  HowToUseRankingView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct HowToUseRankingView: View {
    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // タイトル
    let title: String

    var body: some View {
        Text("HowToUseRankingView")
        // ナビゲーションバータイトルを指定
        .navigationBarTitle(title, displayMode: .inline)
        // ナビゲーションバーの左側にカスタムの戻るボタンを配置
        .placeCustomBackButton {
            // 戻るボタンの処理
            // 画面を閉じる
            dismiss()
        } // placeCustomBackButton ここまで
    } // bodyここまで
} // HowToUseRankingView ここまで

#Preview {
    HowToUseRankingView(title: "アプリの使い方-ランキング-")
}
