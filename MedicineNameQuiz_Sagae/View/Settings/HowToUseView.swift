//
//  HowToUseView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

// 本アプリの第1回目のリリース目標として、ランキング機能なしで学習のみできるアプリを作成することとなりました。
// そのため、第一段階のアプリ作成の間は、ランキング機能に関連するコードをコメントアウトします。

import SwiftUI

struct HowToUseView: View {
    // 項目のタイトル
    let title: String
    
    var body: some View {
        // リスト表示
        List {
            ForEach(HowToUse.allCases, id: \.self) { item in
                // 各項目ごとのタイトル（サブ）を取得
                let subtitle = item.rawValue
                // 遷移先のビューに渡すタイトルを作成
                let titleWithSubtitle = "\(title)-\(subtitle)-"
                // 画面遷移
                NavigationLink {
                    switch item {
                    case .study:
                        HowToUseStudyView(title: titleWithSubtitle)
                    case .questionList:
                        HowToUseQuestionListView(title: titleWithSubtitle)
                        // ランキング機能が無ければ、ランキングの使い方の説明も不要なので、コメントアウト
                        /*
                    case .ranking:
                        HowToUseRankingView(title: titleWithSubtitle)
                         */
                    case .medicineList:
                        HowToUseMedicineListView(title: titleWithSubtitle)
                    } // switch ここまで
                } label: {
                    // 項目ごとに異なるテキストを表示
                    Text(subtitle)
                } // NavigationLink ここまで
            } // ForEach ここまで
        } // List ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle(title, displayMode: .inline)
    } // body ここまで
} // HowToUseView ここまで

#Preview {
    HowToUseView(title: "アプリの使い方")
}
