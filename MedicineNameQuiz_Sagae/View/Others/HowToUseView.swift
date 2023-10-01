//
//  HowToUseView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct HowToUseView: View {
    @Environment(\.presentationMode) var presentation
    private let tabList: [HowToUse] = [.study, .questionList, .ranking, .medicineList]
    
    var body: some View {
        List {
            ForEach(tabList, id: \.self) { item in
                NavigationLink {
                    switch item {
                    case .study:
                        HowToUseStudyView()
                    case .questionList:
                        HowToUseQuestionListView()
                    case .ranking:
                        HowToUseRankingView()
                    case .medicineList:
                        HowToUseMedicineListView()
                    } // switch ここまで
                } label: {
                    Text(item.rawValue)
                } // NavigationLink ここまで
            } // ForEach ここまで
        } // List ここまで
        .navigationBarTitle("アプリの使い方", displayMode: .inline)
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
} // HowToUseView ここまで

#Preview {
    HowToUseView()
}
