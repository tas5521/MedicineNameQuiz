//
//  QuestionListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct QuestionListView: View {
    // リスト名検索テキスト
    @State private var listNameText: String = ""
    
    // ダミーのリスト
    private var dummyList: [QuestionListItem] = [
        QuestionListItem(listName: "さがえ薬局リスト",
                         date: Date(),
                         questions: [MedicineItem(medicineCategory: .internalMedicine,
                                                  originalName: "アムロジン",
                                                  genericName: "アムロジピンべシル酸塩"),
                                     MedicineItem(medicineCategory: .internalMedicine,
                                                  originalName: "エバステル",
                                                  genericName: "エバスチン"),
                                     MedicineItem(medicineCategory: .internalMedicine,
                                                  originalName: "オノン",
                                                  genericName: "プランルカスト水和物")]
                        ),
        QuestionListItem(listName: "ながつ薬局リスト",
                         date: Date(),
                         questions: [MedicineItem(medicineCategory: .internalMedicine,
                                                  originalName: "ガスター",
                                                  genericName: "ファモチジン"),
                                     MedicineItem(medicineCategory: .internalMedicine,
                                                      originalName: "キプレス",
                                                      genericName: "モンテルカストナトリウム"),
                                     MedicineItem(medicineCategory: .internalMedicine,
                                                      originalName: "クラビット",
                                                      genericName: "レボフロキサシン水和物")]
                        ),
        QuestionListItem(listName: "こばやし薬局リスト",
                         date: Date(),
                         questions: [MedicineItem(medicineCategory: .internalMedicine,
                                                  originalName: "インフリー",
                                                  genericName: "インドメタシン　ファルネシル"),
                                     MedicineItem(medicineCategory: .internalMedicine,
                                                  originalName: "ウリトス",
                                                  genericName: "イミダフェナシン"),
                                     MedicineItem(medicineCategory: .internalMedicine,
                                                  originalName: "ケフラール",
                                                  genericName: "セファクロル")]
                        )
    ] // dummyList ここまで
    
    var body: some View {
        NavigationStack {
            // 手前から奥にレイアウト
            ZStack {
                // 背景を水色にする
                Color.backgroundSkyBlue
                // セーフエリア外にも背景を表示
                    .ignoresSafeArea()
                // 垂直方向にレイアウト
                VStack {
                    // 問題リストの検索バー
                    SearchBar(searchText: $listNameText, placeholderText: "リストを検索できます")
                    // 上下に余白を指定
                        .padding(.vertical)
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
            // ナビゲーションバーの設定
            // ナビゲーションバーのタイトルを設定
            .navigationBarTitle("問題リスト", displayMode: .inline)
            // ナビゲーションバーの背景を変更
            .navigationBarBackground()
        } // NavigationStack ここまで
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
        // リストの背景のグレーの部分を非表示にする
        .scrollContentBackground(.hidden)
    } // questionList ここまで
    
    // リスト追加ボタン
    private var addListButton: some View {
        NavigationLink {
            // 問題リスト作成画面へ遷移
            CreateQuestionListView(questionListMode: .create)
        } label: {
            Image(systemName: "plus.circle.fill")
            // リサイズする
                .resizable()
            // アスペクト比を保ったまま枠いっぱいに表示
                .scaledToFit()
            // 幅高さ65に指定
                .frame(width: 65, height: 65)
            // ボタンの色をオレンジに指定
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
