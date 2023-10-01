//
//  FriendAdditionView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct FriendAdditionView: View {
    @Environment(\.presentationMode) var presentation
    @State private var isShowAlert: Bool = false
    @State private var isShowSheet: Bool = false
    @State private var userID: String = ""

    var body: some View {
        VStack {
            // 垂直方向にレイアウト
            VStack(alignment: .leading) {
                Text("自分のユーザー名")
                    .font(.title)
                    .bold()
                Text("ユーザーID: qawsedrftgyhujikolp1234")
                    .bold()
                // 水平方向にレイアウト
                HStack {
                    Text("友達リスト")
                    Spacer()
                    // ユーザーID入力ボタン
                    Button {
                        // テキストボックス付きアラートを表示
                        isShowAlert.toggle()
                    } label: {
                        VStack {
                            Image(systemName: "person.text.rectangle.fill")
                            Text("IDを入力")
                                .bold()
                                .scaleEffect(0.5)
                        } // VStack ここまで
                    } // Button ここまで
                    .alert("ユーザーIDを入力", isPresented: $isShowAlert) {
                        TextField("ユーザーID", text: $userID)
                        Button {
                            // 友達追加処理
                        } label: {
                            Text("追加する")
                        }
                        Button(role: .cancel) {
                            // 何もしない
                        } label: {
                            Text("やめる")
                        }
                    } message: {
                        Text("友達のユーザーIDを入力してください")
                    } // alert ここまで
                    // QRコードボタン
                    Button {
                        isShowSheet.toggle()
                    } label: {
                        VStack {
                            Image(systemName: "qrcode")
                                .bold()
                            Text("QRコード")
                                .bold()
                                .scaleEffect(0.5)
                        } // VStack ここまで
                    } // Button ここまで
                    .sheet(isPresented: $isShowSheet) {
                        QRCodeView()
                    } // sheetここまで
                } // HStack ここまで
                .padding(.top)
            } // VStack ここまで
            .padding()
            Spacer()
            Text("リスト")
            Spacer()
        } // VStack ここまで
        .navigationBarTitle("友達追加", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentation.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("戻る")
                    }
                }
                .foregroundColor(Color.blue)
            }
        }
    } // body ここまで
} // FriendAdditionView ここまで

#Preview {
    FriendAdditionView()
}
