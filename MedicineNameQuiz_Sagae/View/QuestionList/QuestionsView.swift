//
//  QuestionListRowView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct QuestionsView: View {
    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // リストの名前を保持する変数
    let listName: String
    // 問題を保持する変数
    let questions: [Question]
    
    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // リストの名前を表示
            Text(listName)
            // 太字にする
                .bold()
            // 薬の検索バー
            medicineSearchBar
            // 出題される薬の名前のリスト
            medicineList
        } // VStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("問題リスト", displayMode: .inline)
        // ナビゲーションバーの左側に戻るボタンを配置
        .navigationBarWithBackButton {
            // 戻るボタンの処理
            // 画面を閉じる
            dismiss()
        } // navigationBarWithBackButton ここまで
        // ナビゲーションバーの右側にカスタムの編集ボタンを配置
        .navigationBarWithNavigationLinkTrailing(label: "編集") {
            // 編集画面へ遷移
            EditQuestionListView()
        } // navigationBarWithNavigationLinkTrailing ここまで
    } // body ここまで

    // 薬の名前の検索バー
    private var medicineSearchBar: some View {
        // 薬の名前を検索するバー
        Text("検索バー")
    } // medicineSearchBar ここまで
    
    // 出題される薬の名前のリスト
    private var medicineList: some View {
        VStack(alignment: .leading) {
            // 総問題数を表示
            Text("総問題数: \(questions.count)")
            // 左に余白を追加
                .padding(.leading)
            // リスト表示
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
        } // VStack ここまで
        // 太字にする
            .bold()
    } // medicineList ここまで
} // QuestionListRowView ここまで

#Preview {
    QuestionsView(listName: "プレビュー薬局",
                        questions: [Question(originalName: "アムロジン", genericName: "アムロジピンべシル酸塩"),
                                    Question(originalName: "エバステル", genericName: "エバスチン"),
                                    Question(originalName: "オノン", genericName: "プランルカスト水和物")])
}
