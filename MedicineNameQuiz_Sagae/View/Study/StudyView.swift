//
//  StudyView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct StudyView: View {
    // タブの選択項目を保持する変数
    @State private var selectedTabIndex: Int = 0
    // 選択されている学習モードを保持する変数
    private var selectedMode: SelectedMode {
        SelectedMode.dicideMode(by: selectedTabIndex)
    } // selectedModeここまで
    // サインインしているかどうかを管理する変数
    @Binding var isSignIn: Bool
    // ユーザー名を管理する変数
    @Binding var userName: String
    // 初回のユーザー名設定画面の表示を管理する変数
    @Binding var isFirstTimeUserNameSetting: Bool
    // ユーザー名設定画面の表示を管理する変数
    @State var isShowUserNameSetttingView: Bool = false
    // サインイン画面の表示を管理する変数
    @State var isShowSignInView: Bool = false
    // 学習の開始を管理する変数
    @State private var isStartStudy: Bool = false

    
    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // タブを上に配置
            tabView
            Spacer()
            // 選択された学習モードにより画面を分けて表示
            switch selectedMode {
                // 本番モードの場合
            case .actual:
                // 本番モードのViewを配置
                actualView
                // 練習モードの場合
            case .practice:
                // 練習モードのViewを配置
                practiceView
            } // switch ここまで
            Spacer()
            // スタートボタンを配置
            startButton
            Spacer()
        } // VStack ここまで
        // 学習中の画面へ遷移
        .navigationDestination(isPresented: $isStartStudy) {
            StudyingView(isStartStudy: $isStartStudy, selectedMode: selectedMode)
        } // navigationDestination ここまで
    } // body ここまで
    
    // 上部につけるタブ
    private var tabView: some View {
        TopTabView(tabNameList: SelectedMode.modeList, selectedTab: $selectedTabIndex)
    } // topTabView ここまで
    
    // 本番モードの画面
    private var actualView: some View {
        // 垂直方向にレイアウト
        VStack(alignment: .leading) {
            Text("モード選択")
            // 太字にする
                .bold()
            Text("区分")
            // 太字にする
                .bold()
        } // VStack ここまで
    } // actualView ここまで
    
    // 　練習モードの画面
    private var practiceView: some View {
        // 垂直方向にレイアウト
        VStack(alignment: .leading) {
            Text("制限時間")
            // 太字にする
                .bold()
            Text("記録の表示")
            // 太字にする
                .bold()
            Text("問題リスト選択")
            // 太字にする
                .bold()
        } // VStack ここまで
    } // practiceView ここまで
    
    // スタートボタン
    private var startButton: some View {
        Button {
            // 選択された学習モードにより異なる処理をする
            switch selectedMode {
                // 本番モードの場合
            case .actual:
                //
                if !isSignIn {
                    isShowSignInView.toggle()
                } else {
                    isStartStudy.toggle()
                }
            case .practice:
                isStartStudy.toggle()
            } // switch ここまで
        } label: {
            Text("スタート")
        } // Button ここまで
        // サインイン画面のシート
        .sheet(isPresented: $isShowSignInView) {
            // サインイン画面を表示
            SignInView(isSignIn: $isSignIn, userName: $userName)
            // サインイン画面が閉じた時、実行
                .onDisappear {
                    // サインインしていているかチェック。サインインしていなかったら、何もしない
                    guard isSignIn else { return }
                    // 初回のユーザー名設定の場合
                    if isFirstTimeUserNameSetting {
                        // ユーザー名設定画面を表示
                        isShowUserNameSetttingView.toggle()
                    } // if ここまで
                } // onDisappear ここまで
        } // sheet ここまで
        // ユーザー名設定画面のシート
        .sheet(isPresented: $isShowUserNameSetttingView) {
            // ユーザー名設定画面を表示
            UserNameSetttingView(userName: $userName, fromAccountView: false)
            // ユーザー名設定画面が閉じた時、実行
                .onDisappear {
                    // 初回のユーザー名設定画面の表示を管理する変数をfalseにする
                    isFirstTimeUserNameSetting = false
                } // onDisappear ここまで
        } // sheet ここまで
    } // startButton ここまで
} // StudyView ここまで

#Preview {
    StudyView(isSignIn: .constant(false), userName: .constant(""), isFirstTimeUserNameSetting: .constant(true))
}
