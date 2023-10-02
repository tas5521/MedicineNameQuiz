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
    // 初回のユーザー名設定画面の表示を管理する変数
    @State private var isFirst: Bool = true
    // signInしているかどうかの引数
    @State var isSignIn: Bool = false
    // ユーザー名
    @State var userName: String = ""
    // サインイン画面の表示を管理する変数
    @State var isShowSignInView: Bool = false
    // ユーザー名設定画面の表示を管理する変数
    @State var isShowUserNameSetttingView: Bool = false
    // 友達追加画面への遷移を管理する変数
    @State var isShowFriendAdditionView: Bool = false
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                StudyView(isSignIn: $isSignIn, isFirst: $isFirst, userName: $userName)
                    .tabItem {
                        Label("学習", systemImage: "book.fill")
                    }
                    .tag(SelectedTab.study)
                
                QuestionListView()
                    .tabItem {
                        Label("問題リスト", systemImage: "square.and.pencil")
                    }
                    .tag(SelectedTab.questionList)
                
                RankingView()
                    .tabItem {
                        Label("ランキング", systemImage: "crown.fill")
                    }
                    .tag(SelectedTab.ranking)
                MedicineListView()
                    .tabItem {
                        Label("薬リスト", systemImage: "list.bullet.rectangle.portrait.fill")
                    }
                    .tag(SelectedTab.medicineList)
                OthersView(isSignIn: $isSignIn, userName: $userName, isFirst: $isFirst)
                    .tabItem {
                        Label("その他", systemImage: "gearshape.fill")
                    }
                    .tag(SelectedTab.others)
            } // TabView ここまで
            .navigationBarTitle(selection.rawValue, displayMode: .inline)
            // ツールバー設定
            .toolbar {
                if selection == .ranking {
                    // カスタムの戻るボタンを左に配置
                    ToolbarItem(placement: .topBarTrailing) {
                        // 友達追加ボタン
                        Button {
                            if !isSignIn {
                                isShowSignInView.toggle()
                            } else {
                                isShowFriendAdditionView.toggle()
                            } // if ここまで
                        } label: {
                            // 水平方向に配置
                            HStack {
                                Image(systemName: "person.fill.badge.plus")
                            } // HStack ここまで
                        } // Button ここまで
                        .foregroundColor(Color.blue)
                        .sheet(isPresented: $isShowSignInView) {
                            // サインイン画面を表示
                            SignInView(isSignIn: $isSignIn, userName: $userName)
                                .onDisappear {
                                    guard isSignIn else { return }
                                    if isFirst {
                                        isShowUserNameSetttingView.toggle()
                                    } else {
                                        isShowFriendAdditionView.toggle()
                                    }
                                }
                        } // sheet ここまで
                        .sheet(isPresented: $isShowUserNameSetttingView) {
                            // ユーザー名設定画面を表示
                            UserNameSetttingView(userName: $userName, fromAccountView: false)
                                .onDisappear {
                                    isFirst = false
                                    isShowFriendAdditionView.toggle()
                                } // onDisappear ここまで
                        } // sheet ここまで
                        Spacer()
                    } // 友達追加ボタン ここまで
                } // if ここまで
            } // toolbarここまで
            .navigationDestination(isPresented: $isShowFriendAdditionView) {
                FriendAdditionView(userName: $userName)
            } // navigationDestination ここまで
        } // NavigationStack ここまで
    } // body ここまで
} // TabSwitchView

#Preview {
    TabSwitchView()
}
