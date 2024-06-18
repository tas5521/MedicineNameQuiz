//
//  PromptToCreateQuestionListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/06/15.
//

import SwiftUI

struct PromptToCreateQuestionListView: View {
    var body: some View {
        NavigationStack {
            // 手前から奥にレイアウト
            ZStack {
                // 背景を水色にする
                Color.backgroundSkyBlue
                    // セーフエリア外にも背景を表示
                    .ignoresSafeArea()
                // 垂直方向にレイアウト
                VStack {
                    // スペースを空ける
                    Spacer()
                    // テキストを表示
                    Text("まずは問題リストを作成しましょう！\n※問題リストは後で編集できます")
                        // 文字を中央に寄せる
                        .multilineTextAlignment(.center)
                        // 上下左右に余白を追加
                        .padding()
                        // 背景を白にする
                        .background(Color.white)
                        // 角を丸くする
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    // スペースを空ける
                    Spacer()
                    // 問題リスト画面に移動するボタン
                    NavigationLink {
                        // 問題リスト作成画面に移動
                        CreateQuestionListView(questionListMode: .create)
                    } label: {
                        Text("問題リストを作成する")
                            // 文字色を白に指定
                            .foregroundStyle(Color.white)
                            // 最大幅.infinityに指定
                            .frame(maxWidth: .infinity)
                            // 高さ60に指定
                            .frame(height: 60)
                            // 背景色をオレンジに指定
                            .background(Color.buttonOrange)
                            // 角を丸くする
                            .clipShape(.buttonBorder)
                    } // Button ここまで
                    // スペースを空ける
                    Spacer()
                } // VStack ここまで
                // 太字にする
                .bold()
                // 上下左右に余白を追加
                .padding()
            } // ZStack ここまで
            // ナビゲーションバーのタイトルを設定
            .navigationBarTitle("問題リスト", displayMode: .inline)
            // ナビゲーションバーの背景を変更
            .navigationBarBackground()
        } // NavigationStack ここまで
    } // body ここまで
} // PromptToCreateQuestionListViewここまで

#Preview {
    PromptToCreateQuestionListView()
}
