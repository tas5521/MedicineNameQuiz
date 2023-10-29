//
//  HowToUseView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct HowToUseView: View {
    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // 項目のタイトル
    let title: String
    // 遷移先の種類
    private let tabList: [HowToUse] = [.study, .questionList, .ranking, .medicineList]
    
    var body: some View {
        // リスト表示
        List {
            ForEach(tabList, id: \.self) { item in
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
                    case .ranking:
                        HowToUseRankingView(title: titleWithSubtitle)
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
