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
    // 本文
    private var mainText: String {
        // 読み込み先に、ファイルが存在してるかチェック
        guard let path = Bundle.main.path(forResource: "HowToUseStudy", ofType: "txt") else {
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
            // 垂直方向にレイアウト
            VStack {
                // 水平方向にレイアウト
                HStack {
                    Text(mainText)
                        // 上下左右に余白を追加
                        .padding()
                    // スペースを追加
                    Spacer()
                } // HStack ここまで
                // スペースを追加
                Spacer()
            } // VStack ここまで
        } // ZStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle(title, displayMode: .inline)
        // ナビゲーションバーの背景を変更
        .navigationBarBackground()
    } // bodyここまで
} // HowToUseStudyView ここまで

#Preview {
    HowToUseStudyView(title: "アプリの使い方-学習-")
}
