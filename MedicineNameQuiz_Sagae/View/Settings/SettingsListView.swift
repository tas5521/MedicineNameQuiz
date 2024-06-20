//
//  SettingsListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct SettingsListView: View {
    var body: some View {
        NavigationStack {
            // 奥から手前にレイアウト
            ZStack {
                // 背景を水色に変更
                Color.backgroundSkyBlue
                    // セーフエリア外にも背景を表示
                    .ignoresSafeArea()
                // 項目をリスト表示
                List {
                    ForEach(SettingsListItem.allCases, id: \.self) { listItem in
                        // 各項目ごとのタイトルを取得
                        let title = listItem.rawValue
                        // 項目ごとに異なる画面に遷移
                        NavigationLink {
                            switch listItem {
                            case .howToUse:
                                // アプリの使い方画面
                                HowToUseView(title: title)
                            case .reference:
                                // 医薬品名の引用元画面
                                ReferenceView(title: title)
                            case .advertisement:
                                // 広告の表示について画面
                                AdvertisementView(title: title)
                            } // switch ここまで
                        } label: {
                            // 項目ごとに異なるテキストを表示
                            Text(title)
                        } // NavigationLink ここまで
                    } // ForEach ここまで
                } // List ここまで
                // リストの背景のグレーの部分を非表示にする
                .scrollContentBackground(.hidden)
                // スクロールできなくする
                .scrollDisabled(true)
                // ナビゲーションバーのタイトルを設定
                .navigationBarTitle("設定", displayMode: .inline)
                // ナビゲーションバーの背景を変更
                .navigationBarBackground()
            } // ZStack ここまで
        } // NavigationStack ここまで
    } // body ここまで
} // SettingsListView ここまで

#Preview {
    SettingsListView()
}
