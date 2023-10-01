//
//  AccountView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.presentationMode) var presentation
    @State private var isShowSheet = false
    @State private var isShowAlert = false
    @State private var isShowAlertAlreadySignedInMessage = false
    @State private var isShowAlertAlreadySignedOutMessage = false
    @State private var isShowAlertWithTextField = false
    @State var isShowSignInView: Bool = false
    // signInしているかどうかの引数
    @Binding var isSignIn: Bool
    // ユーザー名
    @Binding var userName: String

    var body: some View {
        VStack {
            Spacer()
            Text("現在の状態: \(isSignIn ? "サインイン" : "サインアウト")")
                .bold()
                .padding()
            Button {
                if userName.isEmpty {
                    isShowSheet.toggle()
                } else if !isSignIn {
                    isShowSignInView.toggle()
                } else {
                    isShowAlertAlreadySignedInMessage.toggle()
                } // if ここまで
            } label: {
                Text("サインイン")
                    .padding()
            }
            .sheet(isPresented: $isShowSheet) {
                // ユーザー登録画面を表示
                RegistrationView(userName: $userName)
                    .onDisappear {
                        if isSignIn == false && !userName.isEmpty {
                            isShowSignInView.toggle()
                        } // if ここまで
                    } // onDisappear ここまで
            } // sheet ここまで
            .sheet(isPresented: $isShowSignInView) {
                // ユーザー登録画面を表示
                SignInView(isSignIn: $isSignIn)
            } // sheet ここまで
            .alert("サインイン済み", isPresented: $isShowAlertAlreadySignedInMessage) {
                Button {
                    // 何もしない
                } label: {
                    Text("OK")
                }
            } message: {
                Text("すでにサインインしています")
            } // alert ここまで
            
            Button {
                if isSignIn == false {
                    isShowAlertAlreadySignedOutMessage.toggle()
                } else {
                    // サインアウト
                    isSignIn = false
                    print("サインアウトしました")
                } // if ここまで
                // サインアウト
            } label: {
                Text("サインアウト")
                    .padding()
            }
            .alert("サインアウト済み", isPresented: $isShowAlertAlreadySignedOutMessage) {
                Button {
                    // 何もしない
                } label: {
                    Text("OK")
                }
            } message: {
                Text("すでにサインアウトしています")
            } // alert ここまで

            Button {
                isShowAlertWithTextField.toggle()
            } label: {
                Text("ユーザー名を設定")
                    .padding()
            }
            .alert("ユーザー名の設定", isPresented: $isShowAlertWithTextField) {
                TextField("ユーザー名", text: $userName)
                Button {
                    // ユーザー名設定処理
                } label: {
                    Text("決定")
                }
                Button(role: .cancel) {
                    // 何もしない
                } label: {
                    Text("やめる")
                }
            } message: {
                Text("ユーザー名を入力してください")
            } // alert ここまで
            
            Spacer()
            
            Button {
                isShowAlert.toggle()
            } label: {
                Text("アカウント削除")
                    .padding()
            }
            .alert("アカウント削除", isPresented: $isShowAlert) {
                Button(role: .destructive) {
                    // アカウント削除の処理
                } label: {
                    Text("削除")
                }
                Button(role: .cancel) {
                    // 何もしない
                } label: {
                    Text("やめる")
                }
            } message: {
                Text("データは失われます\n本当によろしいですか？")
            } // alert ここまで
        }
        .navigationBarTitle("アカウント", displayMode: .inline)
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
        } // toolbar ここまで
    } // body ここまで
} // AccountView

#Preview {
    AccountView(isSignIn: .constant(true), userName: .constant("sagae"))
}
