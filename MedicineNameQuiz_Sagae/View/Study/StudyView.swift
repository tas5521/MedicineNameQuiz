//
//  StudyView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct StudyView: View {
    // サインインしているかどうかを管理する変数
    @Binding var isSignIn: Bool
    // ユーザー名を管理する変数
    @Binding var userName: String
    // 初回のユーザー名設定画面の表示を管理する変数
    @Binding var isFirstTimeUserNameSetting: Bool
    // 学習中であるかを管理する変数
    @State private var isStudying: Bool = false
    // タブの選択項目番号を保持する変数
    @State private var tabIndex: Int = 0
    
    // View Presentation States
    // ユーザー名設定画面の表示を管理する変数
    @State var isShowUserNameSetttingView: Bool = false
    // サインイン画面の表示を管理する変数
    @State private var isShowSignInView: Bool = false
    
    // 選択されている学習モードを保持する変数
    private var studyMode: StudyMode {
        StudyMode.dicideMode(by: tabIndex)
    } // studyModeここまで

    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // 学習モード選択タブを上に配置
            studyModeTab
            Spacer()
            // 選択された学習モードにより画面を分けて表示
            switch studyMode {
                // 本番モードの場合
            case .actual:
                // 本番モードのViewを配置
                actualModeView
                // 練習モードの場合
            case .practice:
                // 練習モードのViewを配置
                practiceModeView
            } // switch ここまで
            Spacer()
            // スタートボタンを配置
            startButton
            Spacer()
        } // VStack ここまで
        // 問題を解く画面へ遷移
        .navigationDestination(isPresented: $isStudying) {
            QuestionView(isStudying: $isStudying, studyMode: studyMode)
        } // navigationDestination ここまで
    } // body ここまで

    // 学習モード選択タブ
    private var studyModeTab: some View {
        TopTabView(tabNameList: StudyMode.modeList, tabIndex: $tabIndex)
    } // studyModeTab ここまで

    // 本番モードの画面
    private var actualModeView: some View {
        // 垂直方向にレイアウト
        VStack(alignment: .leading) {
            Text("モード選択")
            Text("区分")
        } // VStack ここまで
        // 太字にする
        .bold()
    } // actualModeView ここまで

    // 　練習モードの画面
    private var practiceModeView: some View {
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
    } // practiceModeView ここまで

    // スタートボタン
    private var startButton: some View {
        Button {
            // 選択された学習モードにより異なる処理をする
            switch studyMode {
                // 本番モードの場合
            case .actual:
                // サインインしていない場合
                if !isSignIn {
                    // サインイン画面を表示
                    isShowSignInView.toggle()
                    // サインインしている場合
                } else {
                    // 学習開始
                    isStudying.toggle()
                } // if ここまで
                // 練習モードの場合
            case .practice:
                // 学習開始
                isStudying.toggle()
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
            UserNameSetttingView(userName: $userName, isCalledFromAccountView: false)
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
