//
//  AppSettingsListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

// 本アプリの第1回目のリリース目標として、ランキング機能なしで学習のみできるアプリを作成することとなりました。
// そのため、第一段階のアプリ作成の間は、ランキング機能に関連するコードをコメントアウトします。

import SwiftUI

struct AppSettingsListView: View {
    // サインインやユーザー名など、ランキング機能に関連するプロパティをコメントアウト
    /*
     // ユーザー名を管理する変数
     @Binding var userName: String
     // サインインしているかどうかを管理する変数
     @Binding var isSignIn: Bool
     // 初回のユーザー名設定画面の表示を管理する変数
     @Binding var isFirstTimeUserNameSetting: Bool
     */
    
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
                    ForEach(AppSettingsListItem.allCases, id: \.self) { listItem in
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
                                // ランキング機能が無ければ、アカウントは管理しないので、アカウント画面を表示するコードはコメントアウト
                                /*
                                 case .account:
                                 // アカウント画面
                                 AccountView(isSignIn: $isSignIn,
                                 userName: $userName,
                                 isFirstTimeUserNameSetting: $isFirstTimeUserNameSetting,
                                 title: title)
                                 */
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
} // AppSettingsListView ここまで

#Preview {
    AppSettingsListView(
        // サインインやユーザー名など、ランキング機能に関連するプロパティをコメントアウト
        /*
         userName: .constant("sagae"), isSignIn: .constant(true), isFirstTimeUserNameSetting: .constant(false)
         */
    )
}
