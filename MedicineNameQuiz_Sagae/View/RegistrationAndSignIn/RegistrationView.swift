//
//  RegistrationView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.presentationMode) var presentation
    @Binding var userName: String
    
    var body: some View {
        VStack {
            Text("ユーザー登録画面")
            Button {
                userName = "sagae"
                print("ユーザー名を登録しました")
                presentation.wrappedValue.dismiss()
            } label: {
                Text("決定")
            } // Button ここまで
        } // VStack ここまで
    } // body ここまで
} // RegistrationView ここまで

#Preview {
    RegistrationView(userName: .constant("sagae"))
}
