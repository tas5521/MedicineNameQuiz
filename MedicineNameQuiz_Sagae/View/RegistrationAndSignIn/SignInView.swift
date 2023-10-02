//
//  SignInView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentation
    @Binding var isSignIn: Bool
    // ユーザー名
    @Binding var userName: String
    
    var body: some View {
        VStack {
            Text("サインイン")
                .padding()

            // FirebaseAuthでのログインを実装予定
            Button {
                isSignIn = true
                if userName == "" {
                    userName = "sagae"
                }
                print("サインインしました: \(userName)")
                presentation.wrappedValue.dismiss()
            } label: {
                Text("Sign in with Apple")
            } // Buttonここまで
            .padding()

            Button {
                isSignIn = true
                if userName == "" {
                    userName = "sagae"
                }
                print("サインインしました: \(userName)")
                presentation.wrappedValue.dismiss()
            } label: {
                Text("Sign in with Google")
            } // Buttonここまで
            .padding()
        } // VStack ここまで
    } // body ここまで
} // SignInView ここまで

#Preview {
    SignInView(isSignIn: .constant(true), userName: .constant(""))
}
