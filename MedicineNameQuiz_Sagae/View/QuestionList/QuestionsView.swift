//
//  QuestionsView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct QuestionsView: View {
    let answerPercentage: String
    // QuestionsViewModelのインスタンスを格納する変数
    @State private var viewModel: QuestionsViewModel

    // イニシャライザ
    init(answerPercentage: String, questionList: QuestionList) {
        self.answerPercentage = answerPercentage
        _viewModel = State(initialValue: QuestionsViewModel(questionList: questionList))
    } // init ここまで

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
                SearchBar(searchText: $viewModel.medSearchText, placeholderText: "薬を検索できます")
                    // 上下に余白を指定
                    .padding(.vertical)
                // 垂直方向にレイアウト
                VStack(alignment: .leading) {
                    // 問題数を表示
                    HStack {
                        Text("問題数: \(viewModel.questionList.numberOfQuestions)")
                        Spacer()
                        if viewModel.questionList.numberOfQuestions != 0 {
                            Text("正答率: \(answerPercentage)")
                        } // if ここまで
                    } // HStack ここまで
                    // 余白を追加
                    .padding()

                    // 出題される薬の名前のリスト
                    List {
                        ForEach(viewModel.searchedQuestions) { question in
                            // 水平方向にレイアウト
                            HStack {
                                // 垂直方向にレイアウト
                                VStack(alignment: .leading) {
                                    // 商品名を表示
                                    Text(question.brandName)
                                        // 文字の色を青に変更
                                        .foregroundStyle(Color.blue)
                                    // 一般名を表示
                                    Text(question.genericName)
                                        // 文字の色を赤に変更
                                        .foregroundStyle(Color.red)
                                } // VStack ここまで
                                // スペースを空ける
                                Spacer()
                                // 学習結果（正解か不正解か）を取得
                                let studyResult = question.studyResult
                                if studyResult != .unanswered {
                                    // まる、または、ばつのImage
                                    Image(systemName: studyResult.rawValue)
                                        // 幅を15に指定
                                        .frame(width: 15)
                                        // 正解なら緑、不正解なら赤にする
                                        .foregroundStyle(studyResult == .correct ? Color.buttonGreen : Color.buttonRed)
                                } // if ここまで
                            } // HStack ここまで
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
        .navigationBarTitle(viewModel.questionList.listName ?? "", displayMode: .inline)
        // ナビゲーションバーの背景を変更
        .navigationBarBackground()
        // ナビゲーションバーの右側に編集ボタンを配置
        .toolbar {
            // ボタンの位置を指定
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    // 問題リスト編集画面へ遷移
                    CreateQuestionListView(questionListMode: .edit, questionList: viewModel.questionList)
                } label: {
                    // ラベル
                    Text("編集")
                } // NavigationLink ここまで
            } // ToolbarItem ここまで
        } // toolbar ここまで
    } // body ここまで
} // QuestionsView ここまで

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let questionList = QuestionList(context: context)
    return QuestionsView(answerPercentage: "0.0", questionList: questionList)
}
