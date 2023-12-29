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
        NavigationStack {
            // 奥から手前方向にレイアウト
            ZStack {
                // 背景を水色にする
                Color.backgroundSkyBlue
                // セーフエリア外にも背景を表示
                    .ignoresSafeArea()
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
                    .searchable(text: $searchMedicineNameText, prompt: "薬を検索できます")
                    // リストのスタイルを.groupedに変更
                    .listStyle(.grouped)
                    // リストの背景のグレーの部分を非表示にする
                    .scrollContentBackground(.hidden)
                } // VStack ここまで
                // 太字にする
                .bold()
            } // ZStack ここまで
            // ナビゲーションバータイトルを指定
            .navigationBarTitle(listName, displayMode: .inline)
            // ナビゲーションバーの背景を青色に変更
            .toolbarBackground(.navigationBarBlue, for: .navigationBar)
            // ナビゲーションバーの背景を表示
            .toolbarBackground(.visible, for: .navigationBar)
            // ナビゲーションバーのタイトルの色を白にする
            .toolbarColorScheme(.dark)
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
        } // NavigationStack ここまで
    } // body ここまで
} // QuestionsView ここまで

#Preview {
    QuestionsView(listName: "プレビュー薬局",
                  questions: [Question(originalName: "アムロジン", genericName: "アムロジピンべシル酸塩"),
                              Question(originalName: "エバステル", genericName: "エバスチン"),
                              Question(originalName: "オノン", genericName: "プランルカスト水和物")])
}
