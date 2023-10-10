//
//  QuestionListRowView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct QuestionListRowView: View {
    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // リストの名前を保持する変数
    let listName: String
    // 問題を保持する変数
    let questions: [Question]
    
    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // リストの名前
            nameOfList
            // 薬の名前の検索バー
            medicineNameSearchBar
            // 出題される薬の名前のリスト
            askedMedicineList
        } // VStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("問題リスト", displayMode: .inline)
        // ナビゲーションバーの左側にカスタムの戻るボタンを配置
        .backButton {
            // 戻るボタンの処理
            // 画面を閉じる
            dismiss()
        } // placeCustomBackButton ここまで
        // ナビゲーションバーの右側にカスタムの編集ボタンを配置
        .navigationLinkTrailing(label: "編集") {
            // 編集画面へ遷移
            EditQuestionListView()
        } // placeCustomNavigationLinkTrailing ここまで
    } // body ここまで
    
    // リストの名前
    private var nameOfList: some View {
        // リストの名前を表示
        Text(listName)
        // 太字にする
            .bold()
    } // nameOfList ここまで
    
    // 薬の名前の検索バー
    private var medicineNameSearchBar: some View {
        // 薬の名前を検索するバー
        Text("検索バー")
    } // nameOfList ここまで
    
    // 出題される薬の名前のリスト
    private var askedMedicineList: some View {
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
    } // ListOfMedicineNameAsked ここまで
} // QuestionListRowView ここまで

#Preview {
    QuestionListRowView(listName: "プレビュー薬局",
                        questions: [Question(originalName: "アムロジン", genericName: "アムロジピンべシル酸塩"),
                                    Question(originalName: "エバステル", genericName: "エバスチン"),
                                    Question(originalName: "オノン", genericName: "プランルカスト水和物")])
}
