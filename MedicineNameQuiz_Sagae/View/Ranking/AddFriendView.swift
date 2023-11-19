//
//  AddFriendViewView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

// 本アプリの第1回目のリリース目標として、ランキング機能なしで学習のみできるアプリを作成することとなりました。
// そのため、第一段階のアプリ作成の間は、ランキング機能に関連するコードをコメントアウトします。

// ランキング機能が無ければ友達追加は行わないので、AddFriendView全体をコメントアウト
/*
import SwiftUI

struct AddFriendView: View {
    // ユーザー名を管理する変数
    @Binding var userName: String
    // 友達のユーザーIDを格納する変数
    @State private var userID: String = ""
    
    // View Presentation States
    // 友達になるユーザーIDを入力するためのポップアップの表示を管理する変数
    @State private var isShowPopUp: Bool = false
    // QRCodeViewの表示を管理する変数
    @State private var isShowQRCodeView: Bool = false

    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // 垂直方向にレイアウト
            VStack(alignment: .leading) {
                // 自分のユーザー名を表示
                Text(userName)
                // フォントを.titleに変更
                    .font(.title)
                // 太字にする
                    .bold()
                // 上下左右に余白を追加
                    .padding()
                // 自分のユーザーID
                Text("ユーザーID: qawsedrftgyhujikolp1234")
                // 太字にする
                    .bold()
                // 左に余白を追加
                    .padding(.leading)
                // 水平方向にレイアウト
                HStack {
                    Text("友達リスト")
                    // 太字にする
                        .bold()
                    // 左に余白を追加
                        .padding(.leading)
                    // スペースを空ける
                    Spacer()
                    // ユーザーID入力ボタン
                    inputIDButton
                    // QRコードボタン
                    qrCodeButton
                } // HStack ここまで
                .padding(.top)
            } // VStack ここまで
            .padding()
            Spacer()
            // 友達リスト
            Text("友達リスト")
            Spacer()
        } // VStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("友達追加", displayMode: .inline)
    } // body ここまで

    // ID入力ボタン
    private var inputIDButton: some View {
        Button {
            // テキストボックス付きアラートを表示
            isShowPopUp.toggle()
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
        .alert("ユーザーIDを入力", isPresented: $isShowPopUp) {
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
    } // inputIDButton ここまで
    
    // QRコードボタン
    private var qrCodeButton: some View {
        Button {
            // シートを表示
            isShowQRCodeView.toggle()
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
        .sheet(isPresented: $isShowQRCodeView) {
            QRCodeView()
        } // sheetここまで
    } // qrCodeButton ここまで
} // AddFriendView ここまで

#Preview {
    AddFriendView(userName: .constant("sagae"))
}
*/
