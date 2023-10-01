//
//  CreateQuestionListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct CreateQuestionListView: View {
    @Environment(\.presentationMode) var presentation
    @State private var isShowAlert = false
    @State private var questionListName: String = ""
    // タブの選択項目を保持する変数
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {
            TopTabView(tabNameList: SelectedClassification.classificationList, selectedTab: $selectedTab)
            Spacer()
            Text("CreateQuestionListView")
            Spacer()
        } // VStack ここまで
        .alert("リストに保存", isPresented: $isShowAlert) {
            TextField("リストの名前", text: $questionListName)
            Button {
                // 問題リストの作成処理
                presentation.wrappedValue.dismiss()
            } label: {
                Text("保存する")
            }
            Button(role: .cancel) {
                // 何もしない
            } label: {
                Text("やめる")
            }
        } message: {
            Text("リストに名前をつけてください")
        } // alert ここまで
        .navigationBarTitle("問題リスト", displayMode: .inline)
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
                .foregroundColor(Color.white)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isShowAlert.toggle()
                } label: {
                    Text("保存")
                }
                .foregroundColor(Color.white)
            }
        }
    } // body ここまで
} // CreateQuestionListView ここまで

#Preview {
    CreateQuestionListView()
}
