//
//  MedicineListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct MedicineListView: View {
    // タブの選択項目を保持する変数
    @State private var selectedTab: Int = 0
    private var selectedClassification: SelectedClassification {
        SelectedClassification.classify(by: selectedTab)
    } // selectedClassification ここまで
    @State private var isShowSheet: Bool = false

    var body: some View {
        ZStack {
            VStack {
                TopTabView(tabNameList: SelectedClassification.classificationList, selectedTab: $selectedTab)
                Text("検索バー")
                Spacer()
                Text("薬リスト")
                Spacer()
            } // VStack ここまで
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    if selectedClassification == .customMedicine {
                        Button {
                            isShowSheet.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 65, height: 65)
                                .foregroundStyle(Color.customOrange)
                                .background(Color.white)
                                .clipShape(Circle())
                        } // Button ここまで
                        .padding()
                        .sheet(isPresented: $isShowSheet) {
                            AddMedicineView()
                        }  // sheet ここまで
                    } // if ここまで
                } // HStack ここまで
            } // VStack ここまで
        } // ZStack ここまで
    } // body ここまで
} // MedicineListView ここまで

#Preview {
    MedicineListView()
}
