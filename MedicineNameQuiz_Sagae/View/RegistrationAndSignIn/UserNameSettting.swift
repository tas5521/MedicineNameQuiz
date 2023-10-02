//
//  UserNameSetttingView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct UserNameSetttingView: View {
    @Environment(\.presentationMode) var presentation
    @Binding var userName: String
    var fromAccountView: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Text("ユーザー名の設定")
            Text("アプリ内で使用するユーザー名を入力してください")
            TextField("ユーザー名", text: $userName)
                .textFieldStyle(.roundedBorder)
                .padding()
            if !fromAccountView {
                Text("ユーザー名は「その他」画面の「アカウント」からも変更できます")
            }
            Spacer()
            Button {
                print("ユーザー名を登録しました: \(userName)")
                presentation.wrappedValue.dismiss()
            } label: {
                Text("決定")
            } // Button ここまで
            Spacer()
        } // VStack ここまで
    } // body ここまで
} // RegistrationView ここまで

#Preview {
    UserNameSetttingView(userName: .constant(""), fromAccountView: false)
}
