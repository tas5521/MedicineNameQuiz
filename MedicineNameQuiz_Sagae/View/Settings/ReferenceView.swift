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
            VStack(alignment: .leading) {
                // 出典元を記載
                Text("出典：「薬価基準収載品目リスト及び後発医薬品に関する情報について」（厚生労働省）")
                // リンクを追加
                Text(.init("\(ReferenceData.url)"))
                // 説明文
                Text("本アプリでは、薬価基準収載品目リストから、\n先発品の一部を抜粋して出題しています。")
                    .padding(.vertical)
                // 各品目のバージョン
                Text("-薬価基準収載品目リストのバージョン-")
                Text(" 内用薬: \(ReferenceData.oralDate)")
                Text(" 注射薬: \(ReferenceData.injectionDate)")
                Text(" 外用薬: \(ReferenceData.topicalDate)")
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
