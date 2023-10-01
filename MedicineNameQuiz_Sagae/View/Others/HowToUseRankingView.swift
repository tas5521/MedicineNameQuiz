//
//  HowToUseRankingView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct HowToUseRankingView: View {
    @Environment(\.presentationMode) var presentation

    var body: some View {
        Text("HowToUseRankingView")
            .navigationBarTitle("アプリの使い方 -ランキング-", displayMode: .inline)
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

    }
}

#Preview {
    HowToUseRankingView()
}
