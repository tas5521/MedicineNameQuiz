//
//  QuestionListRowView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct QuestionListRowView: View {
    @Environment(\.presentationMode) var presentation
    let listName: String
    let questions: [Question]
    
    var body: some View {
        VStack {
            Text(listName)
                .bold()
            Text("検索バー")
            VStack(alignment: .leading) {
                Text("総問題数: \(questions.count)")
                    .bold()
                    .padding(.leading)
                List {
                    ForEach(questions) { question in
                        VStack(alignment: .leading) {
                            Text(question.originalName)
                                .foregroundStyle(Color.blue)
                            Text(question.genericName)
                                .foregroundStyle(Color.red)
                        } // VStack ここまで
                        .bold()
                    } // ForEach ここまで
                } // List ここまで
                .listStyle(.grouped)
            } // VStack ここまで
        } // VStack ここまで
        // ナビゲーションバーにタイトルを表示
        .navigationBarTitle("問題リスト", displayMode: .inline)
        // デフォルトの戻るボタンを隠す
        .navigationBarBackButtonHidden(true)
        // ツールバー設定
        .toolbar {
            // カスタムの戻るボタンを左に配置
            ToolbarItem(placement: .navigationBarLeading) {
                // 戻るボタン
                Button {
                    // 前の画面に戻る
                    presentation.wrappedValue.dismiss()
                } label: {
                    // 水平方向に配置
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("戻る")
                    } // HStack ここまで
                } // Button ここまで
                .foregroundColor(Color.blue)
            } // 戻るボタン ここまで
            // 編集画面に遷移するボタンを右に配置
            ToolbarItem(placement: .navigationBarTrailing) {
                // 編集ボタン
                NavigationLink {
                    EditQuestionListView()
                } label: {
                    Text("編集")
                } // Button ここまで
                .foregroundColor(Color.blue)
            } // 編集ボタン ここまで
        } // toolbar ここまで
    } // body ここまで
} // QuestionListRowView ここまで

#Preview {
    QuestionListRowView(listName: "プレビュー薬局",
                        questions: [Question(originalName: "アムロジン", genericName: "アムロジピンべシル酸塩"),
                                    Question(originalName: "エバステル", genericName: "エバスチン"),
                                    Question(originalName: "オノン", genericName: "プランルカスト水和物")])
}
