//
//  AccountView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

// 本アプリの第1回目のリリース目標として、ランキング機能なしで学習のみできるアプリを作成することとなりました。
// そのため、第一段階のアプリ作成の間は、ランキング機能に関連するコードをコメントアウトします。

// ランキング機能がなければ、アカウントに関する画面も不要なので、全てコメントアウト
/*
 import SwiftUI

 struct AccountView: View {
 // サインインしているかどうかを管理する変数
 @Binding var isSignIn: Bool
 // ユーザー名を管理する変数
 @Binding var userName: String
 // 初回のユーザー名設定画面の表示を管理する変数
 @Binding var isFirstTimeUserNameSetting: Bool
 // ユーザー名設定ボタンが押されたかを管理する変数
 @State private var isTappedUserNameSettingButton: Bool = false

 // View Presentation States
 // アカウント削除時の警告を表示
 @State private var isShowAccountDeletionAlert: Bool = false
 // 既にサインインしている場合にメッセージを表示
 @State private var isShowAlreadySignedIn: Bool = false
 // 既にサインアウトしている場合にポップアップを表示
 @State private var isShowAlreadySignedOut: Bool = false
 // ユーザー名設定画面の表示を管理する変数
 @State private var isShowUserNameSettingView: Bool = false
 // サインイン画面の表示を管理する変数
 @State private var isShowSignInView: Bool = false

 // 項目のタイトル
 let title: String

 var body: some View {
 // 垂直方向にレイアウト
 VStack {
 // スペースを空ける
 Spacer()
 // サインイン状態を表示するテキスト
 Text("現在の状態: \(isSignIn ? "サインイン" : "サインアウト")")
 // 太字にする
 .bold()
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
 Button {
 // ユーザー名設定ボタンがタップされたことを記録
 isTappedUserNameSettingButton = true
 // サインインしている場合
 if isSignIn {
 // ユーザー名設定画面を表示
 isShowUserNameSettingView.toggle()
 // サインインしていない場合
 } else {
 // サインイン画面を表示
 isShowSignInView.toggle()
 } // if ここまで
 } label: {
 // ラベル
 Text("ユーザー名を設定")
 } // Button ここまで
 // 上下左右に余白を追加
 .padding()

 // スペースを空ける
 Spacer()
 // アカウント削除ボタン
 deleteAccountButton
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
 if isFirstTimeUserNameSetting || isTappedUserNameSettingButton {
 // ユーザー名設定画面を表示
 isShowUserNameSettingView.toggle()
 // ユーザー名設定ボタンが押されたかを管理する変数をfalseにする
 isTappedUserNameSettingButton = false
 } // if ここまで
 } // onDisappear ここまで
 } // sheet ここまで
 // ユーザー名設定画面のシート
 .sheet(isPresented: $isShowUserNameSettingView) {
 // ユーザー名設定画面を表示
 UserNameSettingView(userName: $userName, isCalledFromAccountView: true)
 // ユーザー名設定画面が消えた時に実行
 .onDisappear {
 // 初回のユーザー名設定画面の表示を管理する変数をfalseに指定
 isFirstTimeUserNameSetting = false
 } // onDisappear ここまで
 } // sheet ここまで
 // ナビゲーションバータイトルを指定
 .navigationBarTitle(title, displayMode: .inline)
 } // body ここまで

 // サインインボタン
 private var signInButton: some View {
 Button {
 // サインイン済みの場合
 if isSignIn {
 // サインイン済みであることを示すアラートを表示
 isShowAlreadySignedIn.toggle()
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
 .alert("サインイン済み", isPresented: $isShowAlreadySignedIn) {
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
 // サインインしている場合
 if isSignIn {
 // サインアウトする
 isSignIn = false
 // デバッグエリアにメッセージを表示
 print("サインアウトしました")
 // サインインしていない場合
 } else {
 // サインアウトしていることを示すアラートを表示
 isShowAlreadySignedOut.toggle()
 } // if ここまで
 } label: {
 // ラベル
 Text("サインアウト")
 } // Button ここまで
 // サインアウト済みである時に表示するアラート
 .alert("サインアウト済み", isPresented: $isShowAlreadySignedOut) {
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

 // アカウント削除ボタン
 private var deleteAccountButton: some View {
 Button {
 // アカウント削除のアラートを表示
 isShowAccountDeletionAlert.toggle()
 } label: {
 // ラベル
 Text("アカウント削除")
 } // Button ここまで
 // アカウント削除のアラート
 .alert("アカウント削除", isPresented: $isShowAccountDeletionAlert) {
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
 } // deleteAccountButton ここまで
 } // AccountView ここまで

 #Preview {
 AccountView(isSignIn: .constant(false), userName: .constant("sagae"),
 isFirstTimeUserNameSetting: .constant(false), title: "アカウント")
 }
 */
