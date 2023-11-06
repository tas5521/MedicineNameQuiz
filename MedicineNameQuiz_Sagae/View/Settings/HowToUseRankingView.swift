//
//  HowToUseRankingView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct HowToUseRankingView: View {
    // 項目のタイトル
    let title: String

    var body: some View {
        Text("HowToUseRankingView")
        // ナビゲーションバータイトルを指定
        .navigationBarTitle(title, displayMode: .inline)
    } // bodyここまで
} // HowToUseRankingView ここまで

#Preview {
    HowToUseRankingView(title: "アプリの使い方-ランキング-")
}
