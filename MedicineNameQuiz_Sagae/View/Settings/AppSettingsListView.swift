//
//  AppSettingsListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct AppSettingsListView: View {
    // ユーザー名を管理する変数
    @Binding var userName: String
    // サインインしているかどうかを管理する変数
    @Binding var isSignIn: Bool
    // 初回のユーザー名設定画面の表示を管理する変数
    @Binding var isFirstTimeUserNameSetting: Bool

    var body: some View {
        // 項目をリスト表示
        List {
            ForEach(AppSettingsListItem.allCases, id: \.self) { item in
                // 各項目ごとのタイトルを取得
                let title = item.rawValue
                // 項目ごとに異なる画面に遷移
                NavigationLink {
                    switch item {
                    case .howToUse:
                        // アプリの使い方画面
                        HowToUseView(title: title)
                    case .reference:
                        // 医薬品名の引用元画面
                        ReferenceView(title: title)
                    case .advertisement:
                        // 広告の表示について画面
                        AdvertisementView(title: title)
                    case .account:
                        // アカウント画面
                        AccountView(isSignIn: $isSignIn, userName: $userName, isFirstTimeUserNameSetting: $isFirstTimeUserNameSetting, title: title)
                    } // switch ここまで
                } label: {
                    // 項目ごとに異なるテキストを表示
                    Text(title)
                } // NavigationLink ここまで
            } // ForEach ここまで
        } // List ここまで
    } // body ここまで
} // AppSettingsListView ここまで

#Preview {
    AppSettingsListView(userName: .constant("sagae"), isSignIn: .constant(true), isFirstTimeUserNameSetting: .constant(false))
}
