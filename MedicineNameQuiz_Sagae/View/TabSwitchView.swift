//
//  TabSwitchView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct TabSwitchView: View {
    // タブの選択項目を保持する変数
    @State private var selection: SelectedTab = .study
    // 友達追加画面への遷移を管理する変数
    @State private var isShowAddFriendView: Bool = false
    // ユーザー名を管理する変数
    @State private var userName: String = ""
    // サインインしているかどうかを管理する変数
    @State private var isSignIn: Bool = false
    // 初回のユーザー名設定画面の表示を管理する変数
    @State private var isFirstUserNameSetting: Bool = true
    // サインイン画面の表示を管理する変数
    @State private var isShowSignInView: Bool = false
    // ユーザー名設定画面の表示を管理する変数
    @State private var isShowUserNameSetttingView: Bool = false

    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                // 学習画面のViewを配置
                studyView
                // 問題リスト画面のViewを配置
                questionListView
                // ランキング画面のViewを配置
                rankingView
                // 薬リスト画面のViewを配置
                medicineListView
                // その他画面のViewを配置
                othersView
            } // TabView ここまで
            // ナビゲーションバーのタイトルを設定
            .navigationBarTitle(selection.rawValue, displayMode: .inline)
            // ツールバー設定
            .toolbar {
                // ランキングのタブでは、右に友達追加ボタンを配置する
                if selection == .ranking {
                    // 友達追加ボタンを右に配置
                    ToolbarItem(placement: .topBarTrailing) {
                        addFriendButton
                    } // ToolbarItem ここまで
                } // if ここまで
            } // toolbarここまで
            // 友達追加画面へ遷移
            .navigationDestination(isPresented: $isShowAddFriendView) {
                AddFriendViewView(userName: $userName)
            } // navigationDestination ここまで
        } // NavigationStack ここまで
    } // body ここまで

    // 学習画面
    private var studyView: some View {
        StudyView(isSignIn: $isSignIn, 
                  isFirstUserNameSetting: $isFirstUserNameSetting,
                  userName: $userName)
            .tabItem {
                Label("学習", systemImage: "book.fill")
            } // tabItem ここまで
            .tag(SelectedTab.study)
    } // studyView ここまで

    // 問題リスト画面
    private var questionListView: some View {
        QuestionListView()
            .tabItem {
                Label("問題リスト", systemImage: "square.and.pencil")
            } // tabItem ここまで
            .tag(SelectedTab.questionList)
    } // questionListView ここまで
    
    // ランキング画面
    private var rankingView: some View {
        RankingView()
            .tabItem {
                Label("ランキング", systemImage: "crown.fill")
            } // tabItem ここまで
            .tag(SelectedTab.ranking)
    } // rankingView ここまで
    
    // 薬リスト画面
    private var medicineListView: some View {
        MedicineListView()
            .tabItem {
                Label("薬リスト", systemImage: "list.bullet.rectangle.portrait.fill")
            } // tabItem ここまで
            .tag(SelectedTab.medicineList)
    } // medicineListView ここまで
    
    // その他画面
    private var othersView: some View {
        OthersView(isSignIn: $isSignIn, 
                   userName: $userName,
                   isFirstUserNameSetting: $isFirstUserNameSetting)
            .tabItem {
                Label("その他", systemImage: "gearshape.fill")
            } // tabItem ここまで
            .tag(SelectedTab.others)
    } // othersView ここまで
    
    // 友達追加ボタン
    private var addFriendButton: some View {
        // 友達追加ボタン
        Button {
            // サインインしていない場合
            if !isSignIn {
                // サインイン画面を表示
                isShowSignInView.toggle()
                // サインインしている場合
            } else {
                // 友達追加画面を表示
                isShowAddFriendView.toggle()
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
                    if isFirstUserNameSetting {
                        // ユーザー名設定画面を表示
                        isShowUserNameSetttingView.toggle()
                        // 初回のユーザー名設定でない場合
                    } else {
                        // 友達追加画面を表示
                        isShowAddFriendView.toggle()
                    } // if ここまで
                } // onDisappear ここまで
        } // sheet ここまで
        // ユーザー名設定画面のシート
        .sheet(isPresented: $isShowUserNameSetttingView) {
            // ユーザー名設定画面を表示
            UserNameSetttingView(userName: $userName, fromAccountView: false)
            // ユーザー名設定画面が閉じた時に実行
                .onDisappear {
                    // 初回のユーザー名設定画面の表示を管理する変数をfalseにする
                    isFirstUserNameSetting = false
                    // 友達追加画面を表示
                    isShowAddFriendView.toggle()
                } // onDisappear ここまで
        } // sheet ここまで
    } // addFriendButtonここまで
} // TabSwitchView

#Preview {
    TabSwitchView()
}
