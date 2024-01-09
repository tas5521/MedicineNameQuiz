//
//  QuestionsView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct QuestionsView: View {
    // 薬の名前の検索テキスト
    @State private var searchMedicineNameText: String = ""
    // リストの名前を保持する変数
    let listName: String
    // 問題を保持する変数
    let questions: [Question]
    
    var body: some View {
        // 奥から手前方向にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
            // セーフエリア外にも背景を表示
                .ignoresSafeArea()
            // 垂直方向にレイアウト
            VStack {
                // 薬の検索バー
                SearchBar(searchText: $searchMedicineNameText, placeholderText: "薬を検索できます")
                // 上下に余白を指定
                    .padding(.vertical)
                // 垂直方向にレイアウト
                VStack(alignment: .leading) {
                    // 総問題数を表示
                    Text("総問題数: \(questions.count)")
                    // 左に余白を追加
                        .padding([.top, .leading, .trailing])
                    // 出題される薬の名前のリスト
                    List {
                        ForEach(questions) { question in
                            // 垂直方向にレイアウト
                            VStack(alignment: .leading) {
                                // 先発品名を表示
                                Text(question.originalName)
                                // 文字の色を青に変更
                                    .foregroundStyle(Color.blue)
                                // 一般名を表示
                                Text(question.genericName)
                                // 文字の色を赤に変更
                                    .foregroundStyle(Color.red)
                            } // VStack ここまで
                        } // ForEach ここまで
                    } // List ここまで
                    // リストのスタイルを.groupedに変更
                    .listStyle(.grouped)
                    // リストの背景のグレーの部分を非表示にする
                    .scrollContentBackground(.hidden)
                } // VStack ここまで
                // 太字にする
                .bold()
            } // VStack ここまで
        } // ZStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle(listName, displayMode: .inline)
        // ナビゲーションバーの背景を変更
        .navigationBarBackground()
        // ナビゲーションバーの右側に編集ボタンを配置
        .toolbar {
            // ボタンの位置を指定
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    // 編集画面へ遷移
                    EditQuestionListView()
                } label: {
                    // ラベル
                    Text("編集")
                } // NavigationLink ここまで
            } // ToolbarItem ここまで
        } // toolbar ここまで
    } // body ここまで// 垂直方向にレイアウト// 垂直方向にレイアウト
} // QuestionsView ここまで

#Preview {
    QuestionsView(listName: "プレビュー薬局",
                  questions: [Question(originalName: "アムロジン", genericName: "アムロジピンべシル酸塩"),
                              Question(originalName: "エバステル", genericName: "エバスチン"),
                              Question(originalName: "オノン", genericName: "プランルカスト水和物")])
}
