//
//  HowToUseStudyView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct HowToUseStudyView: View {
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
                    Text("アプリの使い方\n学習について")
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
            // ナビゲーションバータイトルを指定
        } // ZStack ここまで
        .navigationBarTitle(title, displayMode: .inline)
        // ナビゲーションバーの背景を青色に変更
        .toolbarBackground(.navigationBarBlue, for: .navigationBar)
        // ナビゲーションバーの背景を表示
        .toolbarBackground(.visible, for: .navigationBar)
        // ナビゲーションバーのタイトルの色を白にする
        .toolbarColorScheme(.dark)
    } // bodyここまで
} // HowToUseStudyView ここまで

#Preview {
    HowToUseStudyView(title: "アプリの使い方-学習-")
}
