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
    // 本文
    private var mainText: String {
        // 読み込み先に、ファイルが存在してるかチェック
        guard let path = Bundle.main.path(forResource: "HowToUseQuestionList", ofType: "txt") else {
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
        // 奥から手前にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
                // セーフエリア外にも背景を表示
                .ignoresSafeArea()
            ScrollView {
                Text(mainText)
                    // 上下左右に余白を追加
                    .padding()
            } // ScrollView ここまで
        } // ZStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle(title, displayMode: .inline)
        // ナビゲーションバーの背景を変更
        .navigationBarBackground()
    } // bodyここまで
} // HowToUseQuestionListView ここまで

#Preview {
    HowToUseQuestionListView(title: "アプリの使い方-問題リスト-")
}
