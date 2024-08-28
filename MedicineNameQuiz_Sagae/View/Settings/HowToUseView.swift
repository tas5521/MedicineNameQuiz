//
//  HowToUseView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct HowToUseView: View {
    // 項目のタイトル
    let title: String

    var body: some View {
        // 奥から手前にレイアウト
        ZStack {
            // 背景を水色に変更
            Color.backgroundSkyBlue
                // セーフエリアにも背景を表示
                .ignoresSafeArea()
            // リスト表示
            List {
                ForEach(HowToUse.allCases, id: \.self) { listItem in
                    // 各項目ごとのタイトル（サブ）を取得
                    let subtitle = listItem.rawValue
                    // 遷移先のビューに渡すタイトルを作成
                    let titleWithSubtitle = "\(title)-\(subtitle)-"
                    // 画面遷移
                    NavigationLink {
                        switch listItem {
                        case .study:
                            HowToUseStudyView(title: titleWithSubtitle)
                        case .questionList:
                            HowToUseQuestionListView(title: titleWithSubtitle)
                        case .medicineList:
                            HowToUseMedicineListView(title: titleWithSubtitle)
                        } // switch ここまで
                    } label: {
                        // 項目ごとに異なるテキストを表示
                        Text(subtitle)
                    } // NavigationLink ここまで
                } // ForEach ここまで
            } // List ここまで
            // リストの背景のグレーの部分を非表示にする
            .scrollContentBackground(.hidden)
            // スクロールできなくする
            .scrollDisabled(true)
        } // ZStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle(title, displayMode: .inline)
        // ナビゲーションバーの背景を変更
        .navigationBarBackground()
    } // body ここまで
} // HowToUseView ここまで

#Preview {
    HowToUseView(title: "アプリの使い方")
}
