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
    // 薬リストの出典元のURL
    private let url: String = "https://www.mhlw.go.jp/topics/2024/04/tp20240401-01.html"
    // 薬リストの出典元の日にち（バージョン）
    private let oralDate: String = "令和6年7月1日"
    private let injectionDate: String = "令和6年6月14日"
    private let topicalDate: String = "令和6年6月14日"

    var body: some View {
        // 奥から手前にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
                // セーフエリア外にも背景を表示
                .ignoresSafeArea()
            // 垂直方向にレイアウト
            VStack(alignment: .leading) {
                // 出典元を記載
                Text("出典：「薬価基準収載品目リスト及び後発医薬品に関する情報について」（厚生労働省）")
                // リンクを追加
                Text(.init("\(url)"))
                // 説明文
                Text("本アプリでは、薬価基準収載品目リストから、\n先発品の一部を抜粋して出題しています。")
                    .padding(.top)
                Text("出題される薬名は、元の品目リストの記載から一部加工されています。")
                    .padding(.bottom)
                // 各品目のバージョン
                Text("-薬価基準収載品目リストのバージョン-")
                Text(" 内用薬: \(oralDate)")
                Text(" 注射薬: \(injectionDate)")
                Text(" 外用薬: \(topicalDate)")
                // スペースを空ける
                Spacer()
            } // VStack ここまで
            // 上下左右に余白を追加
            .padding()
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
