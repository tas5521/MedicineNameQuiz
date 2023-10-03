//
//  SignInView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct SignInView: View {
    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // サインインしているかどうかを管理する変数
    @Binding var isSignIn: Bool
    // ユーザー名を管理する変数
    @Binding var userName: String
    
    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // サインインと表示するテキスト
            signInText
            // 上下左右に余白を追加
                .padding()
            // 下の二つのサインインボタンは、FirebaseAuthで実装予定
            appleSingInButton
            // 上下左右に余白を追加
                .padding()
            googleSignInButton
            // 上下左右に余白を追加
                .padding()
        } // VStack ここまで
    } // body ここまで
    
    // サインインと表示するテキスト
    var signInText: some View {
        Text("サインイン")
        // フォントを.titleに指定
            .font(.title)
        // 太字にする
            .bold()
    } // signInText
    
    // Appleサインインボタン
    var appleSingInButton: some View {
        Button {
            // サインインする
            isSignIn = true
            // ユーザーネームが空白だったら、デフォルトで名前をつける
            if userName.isEmpty {
                userName = "sagae"
            } // if ここまで
            // デバッグエリアにメッセージを表示
            print("サインインしました: \(userName)")
            // 画面を閉じる
            dismiss()
        } label: {
            // ラベル
            Text("Sign in with Apple")
        } // Buttonここまで
    } // appleSingInButton ここまで
    
    // Googleサインインボタン
    private var googleSignInButton: some View {
        Button {
            // サインインする
            isSignIn = true
            // ユーザーネームが空白だったら、デフォルトで名前をつける
            if userName.isEmpty {
                userName = "sagae"
            } // if ここまで
            // デバッグエリアにメッセージを表示
            print("サインインしました: \(userName)")
            // 画面を閉じる
            dismiss()
        } label: {
            // ラベル
            Text("Sign in with Google")
        } // Buttonここまで
    } // googleSignInButton ここまで
} // SignInView ここまで

#Preview {
    SignInView(isSignIn: .constant(true), userName: .constant(""))
}
