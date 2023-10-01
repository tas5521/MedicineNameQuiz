//
//  OthersView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct OthersView: View {
    private let othersList: [Others] = [.howToUse, .reference, .advertisement, .account]
    // signInしているかどうかの引数
    @Binding var isSignIn: Bool
    // ユーザー名
    @Binding var userName: String
    
    var body: some View {
        List {
            ForEach(othersList, id: \.self) { item in
                NavigationLink {
                    switch item {
                    case .howToUse:
                        HowToUseView()
                    case .reference:
                        ReferenceView()
                    case .advertisement:
                        AdvertisementView()
                    case .account:
                        AccountView(isSignIn: $isSignIn, userName: $userName)
                    }
                } label: {
                    Text(item.rawValue)
                } // NavigationLink ここまで
            } // ForEach ここまで
        } // List ここまで
    } // body ここまで
} // OthersView ここまで

#Preview {
    OthersView(isSignIn: .constant(true), userName: .constant("sagae"))
}
