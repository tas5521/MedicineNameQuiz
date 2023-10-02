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
    @State private var isShowUserNameSettingView = false
    @State var isShowSignInView: Bool = false
    @State var isShowUserNameSetttingView: Bool = false
    
    // signInしているかどうかの引数
    @Binding var isSignIn: Bool
    // ユーザー名
    @Binding var userName: String
    // 初回のユーザー名設定画面の表示を管理する変数
    @Binding var isFirst: Bool

    var body: some View {
        VStack {
            Spacer()
            Text("現在の状態: \(isSignIn ? "サインイン" : "サインアウト")")
                .bold()
                .padding()
            Button {
                if isSignIn {
                    isShowAlertAlreadySignedInMessage.toggle()
                } else {
                    isShowSignInView.toggle()
                } // if ここまで
            } label: {
                Text("サインイン")
                    .padding()
            }
            
            .sheet(isPresented: $isShowSignInView) {
                // サインイン画面を表示
                SignInView(isSignIn: $isSignIn, userName: $userName)
                    .onDisappear {
                        if isSignIn && isFirst == true {
                            isShowUserNameSetttingView.toggle()
                        }
                    }
            } // sheet ここまで
            .sheet(isPresented: $isShowUserNameSetttingView) {
                // ユーザー名設定画面を表示
                UserNameSetttingView(userName: $userName, fromAccountView: false)
                    .onDisappear {
                        isFirst = false
                    } // onDisappear ここまで
            } // sheet ここまで
            
            
            
            .sheet(isPresented: $isShowSheet) {
                // ユーザー登録画面を表示
                UserNameSetttingView(userName: $userName, fromAccountView: false)
                    .onDisappear {
                        if isSignIn == false && !userName.isEmpty {
                            isShowSignInView.toggle()
                        } // if ここまで
                    } // onDisappear ここまで
            } // sheet ここまで
            .sheet(isPresented: $isShowSignInView) {
                // ユーザー登録画面を表示
                SignInView(isSignIn: $isSignIn, userName: $userName)
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
                if !isSignIn {
                    isShowSignInView.toggle()
                } else {
                    isShowUserNameSettingView.toggle()
                } // if ここまで
            } label: {
                Text("ユーザー名を設定")
                    .padding()
            }
            .sheet(isPresented: $isShowUserNameSettingView) {
                UserNameSetttingView(userName: $userName, fromAccountView: true)
            } // sheet ここまで
            
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
    AccountView(isSignIn: .constant(true), userName: .constant("sagae"), isFirst: .constant(false))
}
