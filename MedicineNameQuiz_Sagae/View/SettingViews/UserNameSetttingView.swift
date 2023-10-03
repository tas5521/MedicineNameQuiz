//
//  UserNameSetttingView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct UserNameSetttingView: View {
    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // ユーザー名を管理する変数
    @Binding var userName: String
    // アカウント画面から開いているかどうかを指定するための変数
    var fromAccountView: Bool
    
    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // スペースを空ける
            Spacer()
            // ユーザー名の設定というテキスト
            titleOfView
            // 上下左右に余白を追加
                .padding()
            // メッセージ
            message
            // 上下左右に余白を追加
                .padding()
            //ユーザー名を入力するためのテキストフィールド
            textFieldToInputUserName
            // 上下左右に余白を追加
                .padding()
            // アカウント画面外から開かれた場合に表示するメッセージ
            // このViewがアカウント画面以外から開かれている場合
            if !fromAccountView {
                // 次のメッセージを表示
                messageOpenedFromOtherThanAccountView
                // 上下左右に余白を追加
                    .padding()
            } // if ここまで
            // スペースを空ける
            Spacer()
            // 決定ボタン
            decisionButton
            // スペースを空ける
            Spacer()
        } // VStack ここまで
    } // body ここまで
    
    // ユーザー名の設定というテキスト
    private var titleOfView: some View {
        Text("ユーザー名の設定")
    } // titleOfView
    
    // メッセージ
    private var message: some View {
        Text("アプリ内で使用するユーザー名を入力してください")
    } // message ここまで
    
    // ユーザー名を入力するためのテキストフィールド
    private var textFieldToInputUserName: some View {
        TextField("ユーザー名", text: $userName)
        // 縁をつける
            .textFieldStyle(.roundedBorder)
    } // textFieldToInputUserName ここまで
    
    private var messageOpenedFromOtherThanAccountView: some View {
        Text("ユーザー名は「その他」の「アカウント」からでも変更できます")
    } // messageOpenedFromOtherThanAccountView ここまで
    
    // 決定ボタン
    private var decisionButton: some View {
        Button {
            // デバッグエリアにメッセージを表示
            print("ユーザー名を登録しました: \(userName)")
            // 画面を閉じる
            dismiss()
        } label: {
            // ラベル
            Text("決定")
        } // Button ここまで
    } // decisionButton ここまで
} // RegistrationView ここまで


#Preview {
    UserNameSetttingView(userName: .constant(""), fromAccountView: false)
}
