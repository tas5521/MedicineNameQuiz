//
//  UserNameSettingView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct UserNameSettingView: View {
    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // ユーザー名を管理する変数
    @Binding var userName: String
    // アカウント画面から開いているかどうかを指定するための変数
    let isCalledFromAccountView: Bool

    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // スペースを空ける
            Spacer()
            // ユーザー名の設定というテキスト
            Text("ユーザー名の設定")
            // 上下左右に余白を追加
                .padding()
            // アプリ内で使用するユーザー名の入力をユーザーに促すためのテキスト
            Text("アプリ内で使用するユーザー名を入力してください")
            // 上下左右に余白を追加
                .padding()
            //ユーザー名を入力するためのテキストフィールド
            TextField("ユーザー名", text: $userName)
            // 縁をつける
                .textFieldStyle(.roundedBorder)
            // 上下左右に余白を追加
                .padding()
            // アカウント画面外から開かれた場合に表示するメッセージ
            // このViewがアカウント画面以外から開かれている場合
            if !isCalledFromAccountView {
                // ユーザー名が変更できることをユーザーに伝えるためのテキスト
                Text("ユーザー名は「その他」の「アカウント」からでも変更できます")
                    // 上下左右に余白を追加
                    .padding()
            } // if ここまで
            // スペースを空ける
            Spacer()
            // 決定ボタン
            Button {
                // デバッグエリアにメッセージを表示
                print("ユーザー名を登録しました: \(userName)")
                // 画面を閉じる
                dismiss()
            } label: {
                // ラベル
                Text("決定")
            } // Button ここまで
            // スペースを空ける
            Spacer()
        } // VStack ここまで
    } // body ここまで
} // UserNameSettingView ここまで

#Preview {
    UserNameSettingView(userName: .constant(""), isCalledFromAccountView: false)
}
