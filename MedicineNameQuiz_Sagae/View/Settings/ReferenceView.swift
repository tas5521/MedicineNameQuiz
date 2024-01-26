//
//  ReferenceView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct ReferenceView: View {
    // 項目のタイトル
    let title: String

    var body: some View {
        // 奥から手前にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
            // セーフエリア外にも背景を表示
                .ignoresSafeArea()
            // 垂直方向にレイアウト
            VStack {
                // 水平方向にレイアウト
                HStack {
                    // 垂直方向にレイアウト
                    VStack(alignment: .leading) {
                        Text("医薬品名の引用元\n厚生労働省ホームページ")
                        Text("https://www.mhlw.go.jp/index.html")
                    } // VStack ここまで
                    // フォントを.title3に変更
                        .font(.title3)
                    // 太字にする
                        .bold()
                    // 上下左右に余白を追加
                        .padding()
                    // スペースを追加
                    Spacer()
                } // HStack ここまで
                // スペースを追加
                Spacer()
            } // VStack ここまで
        } // ZStck ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle(title, displayMode: .inline)
        // ナビゲーションバーの背景を変更
        .navigationBarBackground()
    } // body ここまで
} // ReferenceView ここまで

#Preview {
    ReferenceView(title: "医薬品名の引用元")
}
