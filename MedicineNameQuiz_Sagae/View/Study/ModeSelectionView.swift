//
//  ModeSelectionView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct ModeSelectionView: View {
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
    @State var isShowUserNameSettingView: Bool = false
    // サインイン画面の表示を管理する変数
    @State private var isShowSignInView: Bool = false
    
    // 選択されている学習モードを保持する変数
    private var studyMode: StudyMode {
        StudyMode.allCases[tabIndex]
    } // studyMode ここまで
    
    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // 学習モードの配列を取得
            let modeArray = StudyMode.allCases.map({mode in mode.rawValue})
            // 学習モード選択タブを上に配置
            TopTabView(tabNameList: modeArray, tabIndex: $tabIndex)
            Spacer()
            // 選択された学習モードにより画面を分けて表示
            switch studyMode {
                
                // 本番モードの場合
            case .actual:
                // 本番モードのViewを配置
                // 垂直方向にレイアウト
                VStack(alignment: .leading) {
                    Text("モード選択")
                    Text("区分")
                } // VStack ここまで
                // 太字にする
                .bold()
                
                // 練習モードの場合
            case .practice:
                // 練習モードのViewを配置
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
            } // switch ここまで
            Spacer()
            // スタートボタンを配置
            startButton
            Spacer()
        } // VStack ここまで
        // 問題を解く画面へ遷移
        .navigationDestination(isPresented: $isStudying) {
            StudyView(isStudying: $isStudying, studyMode: studyMode)
        } // navigationDestination ここまで
    } // body ここまで

    // スタートボタン
    private var startButton: some View {
        Button {
            // 選択された学習モードにより異なる処理をする
            switch studyMode {
                // 本番モードの場合
            case .actual:
                // サインインしている場合
                if isSignIn {
                    // 学習開始
                    isStudying.toggle()
                    // サインインしていない場合
                } else {
                    // サインイン画面を表示
                    isShowSignInView.toggle()
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
                        isShowUserNameSettingView.toggle()
                    } // if ここまで
                } // onDisappear ここまで
        } // sheet ここまで
        // ユーザー名設定画面のシート
        .sheet(isPresented: $isShowUserNameSettingView) {
            // ユーザー名設定画面を表示
            UserNameSettingView(userName: $userName, isCalledFromAccountView: false)
            // ユーザー名設定画面が閉じた時、実行
                .onDisappear {
                    // 初回のユーザー名設定画面の表示を管理する変数をfalseにする
                    isFirstTimeUserNameSetting = false
                } // onDisappear ここまで
        } // sheet ここまで
    } // startButton ここまで
} // ModeSelectionView ここまで

#Preview {
    ModeSelectionView(isSignIn: .constant(false), userName: .constant(""), isFirstTimeUserNameSetting: .constant(true))
}
