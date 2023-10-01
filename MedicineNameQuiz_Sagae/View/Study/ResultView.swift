//
//  ResultView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct ResultView: View {
    @Binding var isStartStudy: Bool
    @State private var isShowAlert = false
    @State private var questionListName: String = ""
    
    var body: some View {
        Text("結果表示画面")
        Button {
            isShowAlert.toggle()
        } label: {
            Text("間違えた問題をリストに保存する")
                .foregroundColor(Color.blue)
        }
        .alert("間違えた問題をリストに保存", isPresented: $isShowAlert) {
            TextField("問題リストの名前", text: $questionListName)
            Button {
                // 問題リストの作成処理
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
        .navigationBarTitle("学習", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // ResultViewを閉じてStudyingViewも閉じる
                    isStartStudy = false
                } label: {
                    Text("終了")
                }
                .tint(.blue)
            }
        }
    }
}

#Preview {
    ResultView(isStartStudy: .constant(true))
}
