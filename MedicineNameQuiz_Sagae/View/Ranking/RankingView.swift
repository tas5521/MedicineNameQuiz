//
//  RankingView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

// 本アプリの第1回目のリリース目標として、ランキング機能なしで学習のみできるアプリを作成することとなりました。
// そのため、第一段階のアプリ作成の間は、ランキング機能に関連するコードをコメントアウトします。

// RankingView全体をコメントアウト
/*
import SwiftUI

struct RankingView: View {
    // ユーザー名を管理する変数
    @Binding var userName: String
    // サインインしているかどうかを管理する変数
    @Binding var isSignIn: Bool
    // 初回のユーザー名設定画面の表示を管理する変数
    @Binding var isFirstTimeUserNameSetting: Bool
    // ランキングに挑戦中であるかを管理する変数
    @State private var isChallenging: Bool = false

    // View Presentation States
    // ユーザー名設定画面の表示を管理する変数
    @State private var isShowUserNameSettingView: Bool = false
    // サインイン画面の表示を管理する変数
    @State private var isShowSignInView: Bool = false

    var body: some View {
        // 水平方向にレイアウト
        VStack {
            // 出題モード選択Picker
            Text("出題モード")
            // 区分選択Picker
            Text("区分")
            // ランキングに挑戦するボタン
            challengeRankingButton
            // ランキングを表示するためのリスト
            Text("ランキング")
        } // VStack ここまで
        // 問題を解く画面へ遷移
        .navigationDestination(isPresented: $isChallenging) {
            ChallengeRankingView(isChallenging: $isChallenging)
        } // navigationDestination ここまで
    } // body ここまで
    
    // ランキングに挑戦するボタン
    private var challengeRankingButton: some View {
        Button {
            // サインインしている場合
            if isSignIn {
                // ランキングに挑戦開始
                isChallenging.toggle()
                // サインインしていない場合
            } else {
                // サインイン画面を表示
                isShowSignInView.toggle()
            } // if ここまで
        } label: {
            Text("ランキングに挑戦する")
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
    } // challengeRankingButton ここまで
} // RankingView ここまで

#Preview {
    RankingView(userName: .constant("sagae"), 
                isSignIn: .constant(false),
                isFirstTimeUserNameSetting: .constant(false))
}
*/
