//
//  MainTabView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

// 本アプリの第1回目のリリース目標として、ランキング機能なしで学習のみできるアプリを作成することとなりました。
// そのため、第一段階のアプリ作成の間は、ランキング機能に関連するコードをコメントアウトします。

import SwiftUI

struct MainTabView: View {
    // タブの選択項目を保持する変数
    @State private var tabSelection: TabSelection = .study

    // サインインやユーザー名など、ランキング機能に関連するプロパティをコメントアウト
    /*
     // ユーザー名を管理する変数
     @State private var userName: String = ""
     // サインインしているかどうかを管理する変数
     @State private var isSignIn: Bool = false
     // 初回のユーザー名設定画面の表示を管理する変数
     @State private var isFirstTimeUserNameSetting: Bool = true

     // View Presentation States
     // 友達追加画面への遷移を管理する変数
     @State private var isShowAddFriendView: Bool = false
     // サインイン画面の表示を管理する変数
     @State private var isShowSignInView: Bool = false
     // ユーザー名設定画面の表示を管理する変数
     @State private var isShowUserNameSettingView: Bool = false
     */
    // 問題リストをフェッチ
    @FetchRequest(entity: QuestionList.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \QuestionList.createdDate, ascending: false)],
                  predicate: nil,
                  animation: nil
    ) private var fetchedLists: FetchedResults<QuestionList>

    var body: some View {
        // タブを配置
        TabView(selection: $tabSelection) {
            // タブの項目をグループにまとめる
            Group {
                Group {
                    // 問題リストがない場合
                    if fetchedLists.isEmpty {
                        // 導入画面のViewを配置
                        IntroductionView()
                        // 問題リストがある場合
                    } else {
                        // 学習画面のViewを配置
                        ModeSelectionView()
                    } // if ここまで
                } // Group ここまで
                .tabItem {
                    Label(TabSelection.study.rawValue, systemImage: "book.fill")
                } // tabItem ここまで
                .tag(TabSelection.study)

                // 問題リスト画面のViewを配置
                QuestionListView()
                    .tabItem {
                        Label(TabSelection.questionList.rawValue, systemImage: "square.and.pencil")
                    } // tabItem ここまで
                    .tag(TabSelection.questionList)

                // ランキング画面のタブを隠す
                /*
                 // ランキング画面のViewを配置
                 RankingView(userName: $userName,
                 isSignIn: $isSignIn,
                 isFirstTimeUserNameSetting: $isFirstTimeUserNameSetting)
                 .tabItem {
                 Label(TabSelection.ranking.rawValue, systemImage: "crown.fill")
                 } // tabItem ここまで
                 .tag(TabSelection.ranking)
                 */

                // 薬リスト画面のViewを配置
                MedicineListView()
                    .tabItem {
                        Label(TabSelection.medicineList.rawValue, systemImage: "list.bullet.rectangle.portrait.fill")
                    } // tabItem ここまで
                    .tag(TabSelection.medicineList)

                // 設定画面のViewを配置
                SettingsListView(
                    // サインインやユーザー名など、ランキング機能に関連するプロパティをコメントアウト
                    /*
                     userName: $userName,
                     isSignIn: $isSignIn,
                     isFirstTimeUserNameSetting: $isFirstTimeUserNameSetting
                     */
                )
                .tabItem {
                    Label(TabSelection.settings.rawValue, systemImage: "gearshape.fill")
                } // tabItem ここまで
                .tag(TabSelection.settings)
            } // Group ここまで
            // タブの背景を青色に変更
            .toolbarBackground(.tabBlue, for: .tabBar)
            // タブの背景を表示
            .toolbarBackground(.visible, for: .tabBar)
            // タブ外観をダークに設定
            .toolbarColorScheme(.dark, for: .tabBar)
        }  // TabView ここまで
        // 友達追加ボタンは、ランキング機能に関連するので、コメントアウト
        /*
         // ツールバー設定
         .toolbar {
         // ランキングのタブでは、右に友達追加ボタンを配置する
         if tabSelection == .ranking {
         // 友達追加ボタンを右に配置
         ToolbarItem(placement: .topBarTrailing) {
         addFriendButton
         } // ToolbarItem ここまで
         } // if ここまで
         } // toolbar ここまで
         // 友達追加画面へ遷移
         .navigationDestination(isPresented: $isShowAddFriendView) {
         AddFriendView(userName: $userName)
         } // navigationDestination ここまで
         */
    } // body ここまで

    // 友達追加ボタンは、ランキング機能に関連するので、コメントアウト
    /*
     // 友達追加ボタン
     private var addFriendButton: some View {
     // 友達追加ボタン
     Button {
     // サインインしている場合
     if isSignIn {
     // 友達追加画面を表示
     isShowAddFriendView.toggle()
     // サインインしていない場合
     } else {
     // サインイン画面を表示
     isShowSignInView.toggle()
     } // if ここまで
     } label: {
     // 水平方向に配置
     HStack {
     Image(systemName: "person.fill.badge.plus")
     } // HStack ここまで
     } // Button ここまで
     // 色を青に指定
     .foregroundColor(Color.blue)
     // サインイン画面のシート
     .sheet(isPresented: $isShowSignInView) {
     // サインイン画面を表示
     SignInView(isSignIn: $isSignIn, userName: $userName)
     // サインイン画面が閉じた時に実行
     .onDisappear {
     // サインインしていなかったら何もしない
     guard isSignIn else { return }
     // 初回のユーザー名設定の場合
     if isFirstTimeUserNameSetting {
     // ユーザー名設定画面を表示
     isShowUserNameSettingView.toggle()
     // 初回のユーザー名設定でない場合
     } else {
     // 友達追加画面を表示
     isShowAddFriendView.toggle()
     } // if ここまで
     } // onDisappear ここまで
     } // sheet ここまで
     // ユーザー名設定画面のシート
     .sheet(isPresented: $isShowUserNameSettingView) {
     // ユーザー名設定画面を表示
     UserNameSettingView(userName: $userName, isCalledFromAccountView: false)
     // ユーザー名設定画面が閉じた時に実行
     .onDisappear {
     // 初回のユーザー名設定画面の表示を管理する変数をfalseにする
     isFirstTimeUserNameSetting = false
     // 友達追加画面を表示
     isShowAddFriendView.toggle()
     } // onDisappear ここまで
     } // sheet ここまで
     } // addFriendButton ここまで
     */
} // MainTabView ここまで

#Preview {
    MainTabView()
}
