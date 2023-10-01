//
//  HowToUseMedicineListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct HowToUseMedicineListView: View {
    @Environment(\.presentationMode) var presentation

    var body: some View {
        Text("HowToUseMedicineListView")
            .navigationBarTitle("アプリの使い方 -薬リスト-", displayMode: .inline)
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
    HowToUseMedicineListView()
}
