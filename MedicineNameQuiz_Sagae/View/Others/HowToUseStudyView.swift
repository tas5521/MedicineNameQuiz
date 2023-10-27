//
//  HowToUseStudyView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct HowToUseStudyView: View {
    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // 項目のタイトル
    let title: String

    var body: some View {
        Text("HowToUseStudyView")
        // ナビゲーションバータイトルを指定
        .navigationBarTitle(title, displayMode: .inline)
        // ナビゲーションバーの左側に戻るボタンを配置
        .navigationBarWithBackButton {
            // 戻るボタンの処理
            // 画面を閉じる
            dismiss()
        } // navigationBarWithBackButton ここまで
    } // bodyここまで
} // HowToUseStudyView ここまで

#Preview {
    HowToUseStudyView(title: "アプリの使い方-学習-")
}
