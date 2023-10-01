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
    
    var body: some View {
        VStack {
            Text("サインイン")
                .padding()

            // FirebaseAuthでのログインを実装予定
            Button {
                isSignIn = true
                print("サインインしました")
                presentation.wrappedValue.dismiss()
            } label: {
                Text("Sign in with Apple")
            } // Buttonここまで
            .padding()

            Button {
                isSignIn = true
                print("サインインしました")
                presentation.wrappedValue.dismiss()
            } label: {
                Text("Sign in with Google")
            } // Buttonここまで
            .padding()
        } // VStack ここまで
    } // body ここまで
} // SignInView ここまで

#Preview {
    SignInView(isSignIn: .constant(true))
}
