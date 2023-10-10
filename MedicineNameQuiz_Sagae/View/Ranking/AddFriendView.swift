//
//  AddFriendViewView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct AddFriendView: View {
    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // 警告の表示を管理する変数
    @State private var isShowAlert: Bool = false
    // シートの表示を管理する変数
    @State private var isShowSheet: Bool = false
    // 友達のユーザーIDを格納する変数
    @State private var userID: String = ""
    // ユーザー名を管理する変数
    @Binding var userName: String

    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // 垂直方向にレイアウト
            VStack(alignment: .leading) {
                // ユーザー名
                userNameText
                // 上下左右に余白を追加
                    .padding()
                // 　自分のユーザーID
                myUserIDText
                // 左に余白を追加
                    .padding(.leading)
                // 水平方向にレイアウト
                HStack {
                    labalSayingFriendList
                    // 左に余白を追加
                        .padding(.leading)
                    // スペースを空ける
                    Spacer()
                    // ユーザーID入力ボタン
                    buttonToInputUserID
                    // QRコードボタン
                    qrCodeButton
                } // HStack ここまで
                .padding(.top)
            } // VStack ここまで
            .padding()
            Spacer()
            // 友達リスト
            firendList
            Spacer()
        } // VStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("友達追加", displayMode: .inline)
        // ナビゲーションバーの左側にカスタムの戻るボタンを配置
        .placeCustomBackButton {
            // 戻るボタンの処理
            // 画面を閉じる
            dismiss()
        } // placeCustomBackButton ここまで
    } // body ここまで
    
    // ユーザー名のテキスト
    private var userNameText: some View {
        // 自分のユーザー名を表示
        Text("\(userName)")
        // フォントを.titleに変更
            .font(.title)
        // 太字にする
            .bold()
    } // userNameText ここまで

    // 自分のユーザーIDのテキスト
    private var myUserIDText: some View {
        // 自分のユーザーID
        Text("ユーザーID: qawsedrftgyhujikolp1234")
        // 太字にする
            .bold()
    } // myUserIDText ここまで
    
    // 友達リストのラベル
    private var labalSayingFriendList: some View {
        Text("友達リスト")
        // 太字にする
            .bold()
    } // labalSayingFriendList
    
    // ID入力ボタン
    private var buttonToInputUserID: some View {
        Button {
            // テキストボックス付きアラートを表示
            isShowAlert.toggle()
        } label: {
            //ラベル
            // 垂直方向にレイアウト
            VStack {
                Image(systemName: "person.text.rectangle.fill")
                Text("IDを入力")
                // 太字にする
                    .bold()
                // 0.5倍にスケーリング
                    .scaleEffect(0.5)
            } // VStack ここまで
        } // Button ここまで
        // 友達になるユーザーIDを入力
        .alert("ユーザーIDを入力", isPresented: $isShowAlert) {
            // 友達のユーザーIDを入力するテキストフィールド
            TextField("ユーザーID", text: $userID)
            // 追加ボタン
            Button {
                // 友達追加処理
            } label: {
                // ラベル
                Text("追加")
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
            Text("友達になるユーザーのIDを入力してください")
        } // alert ここまで
    } // buttonToInputUserID ここまで
    
    // QRコードボタン
    private var qrCodeButton: some View {
        Button {
            // シートを表示
            isShowSheet.toggle()
        } label: {
            // ラベル
            // 垂直方向にレイアウト
            VStack {
                Image(systemName: "qrcode")
                // 太字にする
                    .bold()
                Text("QRコード")
                // 太字にする
                    .bold()
                // 0.5倍にスケーリング
                    .scaleEffect(0.5)
            } // VStack ここまで
        } // Button ここまで
        // QRコードビューのシート
        .sheet(isPresented: $isShowSheet) {
            QRCodeView()
        } // sheetここまで
    } // qrCodeButton ここまで

    // 友達リスト
    private var firendList: some View {
        Text("友達リスト")
    } // firendList ここまで
} // FriendAdditionView ここまで

#Preview {
    AddFriendView(userName: .constant("sagae"))
}
