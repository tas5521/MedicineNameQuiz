//
//  IntroductionView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/05/11.
//

import SwiftUI

struct IntroductionView: View {
    // Introductionの本文
    private var introductionText: String {
        // 読み込み先に、ファイルが存在してるかチェック
        guard let path = Bundle.main.path(forResource: "Introduction", ofType: "txt") else {
            // 存在しなければ、エラーメッセージを返却
            return "ファイルがありません"
        } // guard let ここまで
        do {
            // ファイルが存在していれば、データをString型で読み込み
            return try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            // 何らかのエラーが発生した場合は、エラー内容を返却
            return "エラー: \(error)"
        } // do-try-catch ここまで
    } // mainText ここまで

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
                    // 導入文
                    Text(introductionText)
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
                    // テキストを表示
                    Text("まずは問題リストを作成しましょう！")
                        .font(.title2)
                    Text("※問題リストは後で編集できます")
                    // スペースを空ける
                    Spacer()
                    // 画面遷移
                    NavigationLink {
                        // 問題リスト作成画面へ遷移
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
                    } // NavigationLink ここまで
                    // スペースを空ける
                    Spacer()
                } // VStack ここまで
                // 太字にする
                .bold()
                // 上下左右に余白を追加
                .padding()
            } // ZStack ここまで
            // ナビゲーションバーのタイトルを設定
            .navigationBarTitle("はじめに", displayMode: .inline)
            // ナビゲーションバーの背景を変更
            .navigationBarBackground()
        } // NavigationStack ここまで
    } // body ここまで
} // InitialViewここまで
#Preview {
    IntroductionView()
}
