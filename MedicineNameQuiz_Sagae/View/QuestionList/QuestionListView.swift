//
//  QuestionListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct QuestionListView: View {
    // ダミーのリスト
    private var dummyList: [QuestionListItem] = [
        QuestionListItem(listName: "さがえ薬局リスト",
                         date: Date(),
                         questions: [Question(originalName: "アムロジン", genericName: "アムロジピンべシル酸塩"),
                                    Question(originalName: "エバステル", genericName: "エバスチン"),
                                    Question(originalName: "オノン", genericName: "プランルカスト水和物")]
                        ),
        QuestionListItem(listName: "ながつ薬局リスト",
                         date: Date(),
                         questions: [Question(originalName: "ガスター", genericName: "ファモチジン"),
                                     Question(originalName: "キプレス", genericName: "モンテルカストナトリウム"),
                                     Question(originalName: "クラビット", genericName: "レボフロキサシン水和物")]
                        ),
        QuestionListItem(listName: "こばやし薬局リスト",
                         date: Date(),
                         questions: [Question(originalName: "インフリー", genericName: "インドメタシン　ファルネシル"),
                                     Question(originalName: "ウリトス", genericName: "イミダフェナシン"),
                                     Question(originalName: "ケフラール", genericName: "セファクロル")]
                        )
    ] // dummyList ここまで
    
    var body: some View {
        // 奥から手前方向にレイアウト
        ZStack {
            // 垂直方向にレイアウト
            VStack {
                // 問題リストの検索バー
                Text("問題リスト検索バー")
                // 問題リスト
                questionList
            } // VStack ここまで
            // 垂直方向にレイアウト
            VStack {
                // スペースを空ける
                Spacer()
                // 水平方向にレイアウト
                HStack {
                    // スペースを空ける
                    Spacer()
                    // リスト追加ボタン
                    addListButton
                        .padding()
                } // HStack ここまで
            } // VStack ここまで
        } // ZStack ここまで
    } // body ここまで

    // 問題リスト
    private var questionList: some View {
        List {
            ForEach(dummyList) { item in
                // 各行に対応した画面へ遷移
                NavigationLink {
                    QuestionsView(listName: item.listName, questions: item.questions)
                } label: {
                    // 垂直方向にレイアウト
                    VStack(alignment: .leading) {
                        // リストの名前
                        Text(item.listName)
                        // 水平方向にレイアウト
                        HStack {
                            // リスト作成日時
                            Text("\(item.date.formatted(date: .long, time: .omitted))")
                            // スペースを空ける
                            Spacer()
                            // 問題数を表示
                            Text("問題数: \(item.questions.count)")
                        } // HStack ここまで
                    } // VStack ここまで
                    // 太字にする
                    .bold()
                } // NavigationLink ここまで
            } // ForEach ここまで
        } // List ここまで
        // リストのスタイルを.groupedに変更
        .listStyle(.grouped)
    } // questionList ここまで

    // リスト追加ボタン
    private var addListButton: some View {
        NavigationLink {
            // 問題リスト作成画面へ遷移
            CreateQuestionListView()
        } label: {
            Image(systemName: "plus.circle.fill")
            // リサイズする
                .resizable()
            // アスペクト比を保ったまま枠いっぱいに表示
                .scaledToFit()
            // 幅高さ65に指定
                .frame(width: 65, height: 65)
            // 色をカスタムのボタンの色に指定
                .foregroundStyle(.buttonOrange)
            // 背景を白に指定
                .background(Color.white)
            // 丸くクリッピング
                .clipShape(Circle())
        } // Button ここまで
    } // addListButton ここまで
} // QuestionListView ここまで

#Preview {
    QuestionListView()
}
