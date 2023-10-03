//
//  AccountView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct AccountView: View {
    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // シートの表示を管理する変数
    @State private var isShowSheet = false
    // アカウント削除時の警告を表示
    @State private var isShowAlertForAccountDeletion = false
    // 既にサインインしている場合にポップアップを表示
    @State private var isShowAlertAlreadySignedInMessage = false
    // 既にサインアウトしている場合にポップアップを表示
    @State private var isShowAlertAlreadySignedOutMessage = false
    // ユーザー名設定画面の表示を管理する変数
    @State private var isShowUserNameSettingView = false
    // サインイン画面の表示を管理する変数
    @State var isShowSignInView: Bool = false
    // サインインしているかどうかを管理する変数
    @Binding var isSignIn: Bool
    // ユーザー名を管理する変数
    @Binding var userName: String
    // 初回のユーザー名設定画面の表示を管理する変数
    @Binding var isFirstUserNameSetting: Bool
    // ユーザー名設定ボタンが押されたかを管理する変数
    @State private var isTappedButtonToSetUserName: Bool = false
    // 項目のタイトル
    let title: String
    
    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // スペースを空ける
            Spacer()
            // サインイン状態を表示するテキスト
            textToShowSignedInStatus
            // 上下左右に余白を追加
                .padding()
            // サインインボタン
            signInButton
            // 上下左右に余白を追加
                .padding()
            // サインアウトボタン
            signOutButton
            // 上下左右に余白を追加
                .padding()
            // ユーザー名設定ボタン
            buttonToSetUserName
            // 上下左右に余白を追加
                .padding()
            // スペースを空ける
            Spacer()
            // アカウント削除ボタン
            buttonToDeleteAccount
            // 上下左右に余白を追加
                .padding()
        } // VStack ここまで
        // サインイン画面のシート
        .sheet(isPresented: $isShowSignInView) {
            // サインイン画面
            SignInView(isSignIn: $isSignIn, userName: $userName)
            // サインイン画面が消えた時に実行
                .onDisappear {
                    // サインインしているかチェック。サインインしていなければ、何もしない。
                    guard isSignIn else { return }
                    // ユーザー名設定を行なっていない場合、もしくは、ユーザー名を設定ボタンが押されていた場合
                    if isFirstUserNameSetting || isTappedButtonToSetUserName {
                        // ユーザー名設定画面を表示
                        isShowUserNameSettingView.toggle()
                        // ユーザー名設定ボタンが押されたかを管理する変数をfalseにする
                        isTappedButtonToSetUserName = false
                    } // if ここまで
                } // onDisappear ここまで
        } // sheet ここまで
        // ユーザー名設定画面のシート
        .sheet(isPresented: $isShowUserNameSettingView) {
            // ユーザー名設定画面を表示
            UserNameSetttingView(userName: $userName, fromAccountView: true)
            // ユーザー名設定画面が消えた時に実行
                .onDisappear {
                    // 初回のユーザー名設定画面の表示を管理する変数をfalseに指定
                    isFirstUserNameSetting = false
                } // onDisappear ここまで
        } // sheet ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle(title, displayMode: .inline)
        // ナビゲーションバーの左側にカスタムの戻るボタンを配置
        .placeCustomBackButton {
            // 画面を閉じる
            dismiss()
        } // placeCustomBackButtonここまで
    } // body ここまで
    
    // サインイン状態を表示するテキスト
    private var textToShowSignedInStatus: some View {
        Text("現在の状態: \(isSignIn ? "サインイン" : "サインアウト")")
            .bold()
    } // textToShowSignedInStatus
    
    // サインインボタン
    private var signInButton: some View {
        Button {
            // サインイン済みの場合
            if isSignIn {
                // サインイン済みであることを示すアラートを表示
                isShowAlertAlreadySignedInMessage.toggle()
                // サインインしていない場合
            } else {
                // サインイン画面を表示
                isShowSignInView.toggle()
            } // if ここまで
        } label: {
            // ラベル
            Text("サインイン")
        } // サインイン画面のシート
        // サインイン済みである時に表示するアラート
        .alert("サインイン済み", isPresented: $isShowAlertAlreadySignedInMessage) {
            // OKボタン
            Button {
                // 何もしない
            } label: {
                // ラベル
                Text("OK")
            } // Button ここまで
        } message: {
            // メッセージ
            Text("すでにサインインしています")
        } // alert ここまで
    } // signInButton ここまで
    
    // サインアウトボタン
    private var signOutButton: some View {
        Button {
            // サインインしていない場合
            if !isSignIn {
                // サインインしていないを示すアラートを表示
                isShowAlertAlreadySignedOutMessage.toggle()
                // サインインしている場合
            } else {
                // サインアウトする
                isSignIn = false
                // デバッグエリアにメッセージを表示
                print("サインアウトしました")
            } // if ここまで
        } label: {
            // ラベル
            Text("サインアウト")
        } // Button ここまで
        // サインアウト済みである時に表示するアラート
        .alert("サインアウト済み", isPresented: $isShowAlertAlreadySignedOutMessage) {
            // OKボタン
            Button {
                // 何もしない
            } label: {
                // ラベル
                Text("OK")
            } // Button ここまで
        } message: {
            // メッセージ
            Text("すでにサインアウトしています")
        } // alert ここまで
    } // signOutButton ここまで
    
    // ユーザー名設定ボタン
    private var buttonToSetUserName: some View {
        Button {
            // ユーザー名設定ボタンがタップされたことを記録
            isTappedButtonToSetUserName = true
            // サインインしていない場合
            if !isSignIn {
                // サインイン画面を表示
                isShowSignInView.toggle()
                // サインインしている場合
            } else {
                // ユーザー名設定画面を表示
                isShowUserNameSettingView.toggle()
            } // if ここまで
        } label: {
            // ラベル
            Text("ユーザー名を設定")
        } // Button ここまで
    } // buttonToSetUserName ここまで
    
    // アカウント削除ボタン
    private var buttonToDeleteAccount: some View {
        Button {
            // アカウント削除のアラートを表示
            isShowAlertForAccountDeletion.toggle()
        } label: {
            // ラベル
            Text("アカウント削除")
        } // Button ここまで
        // アカウント削除のアラート
        .alert("アカウント削除", isPresented: $isShowAlertForAccountDeletion) {
            // 削除ボタン
            Button(role: .destructive) {
                // アカウント削除の処理
            } label: {
                // ラベル
                Text("削除")
            } // Button ここまで
            // やめるボタン
            Button(role: .cancel) {
                // 何もしない
            } label: {
                // ラベル
                Text("やめる")
            } // Button ここまで
        } message: {
            // メッセージ
            Text("データは失われます\n本当によろしいですか？")
        } // alert ここまで
    } // buttonToDeleteAccount ここまで
} // AccountView ここまで

#Preview {
    AccountView(isSignIn: .constant(false), userName: .constant("sagae"),
                isFirstUserNameSetting: .constant(false), title: "アカウント")
}
