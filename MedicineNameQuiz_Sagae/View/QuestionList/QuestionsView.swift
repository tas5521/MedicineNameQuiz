//
//  QuestionsView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct QuestionsView: View {
    // 商品名→一般名の正答率
    let brandToGenericAnswerPercentage: String
    // 一般名→商品名の正答率
    let genericToBrandAnswerPercentage: String
    // QuestionsViewModelのインスタンスを格納する変数
    @State private var viewModel: QuestionsViewModel

    // イニシャライザ
    init(brandToGenericAnswerPercentage: String, genericToBrandAnswerPercentage: String, questionList: QuestionList) {
        self.brandToGenericAnswerPercentage = brandToGenericAnswerPercentage
        self.genericToBrandAnswerPercentage = genericToBrandAnswerPercentage
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
                    HStack(alignment: .top) {
                        Text("問題数: \(viewModel.questionList.numberOfQuestions)")
                        Spacer()
                        VStack(alignment: .leading) {
                            // 商品名→一般名の正答率を表示
                            Text("商 → 般: \(brandToGenericAnswerPercentage)")
                            // 一般名→商品名の正答率を表示
                            Text("般 → 商: \(genericToBrandAnswerPercentage)")
                        } // VStack ここまで
                    } // HStack ここまで
                    // 余白を追加
                    .padding()

                    // 出題される薬の名前のリスト
                    List {
                        ForEach(viewModel.searchedQuestions) { question in
                            // 水平方向にレイアウト
                            HStack {
                                // 垂直方向にレイアウト
                                VStack(alignment: .leading, spacing: 5) {
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
                                // 垂直方向にレイアウト
                                VStack(alignment: .leading, spacing: 5) {
                                    // 商品名→一般名の学習結果を表示
                                    showStudyResult(studyMode: .brandToGeneric, question: question)
                                    // 一般名→商品名の学習結果を表示
                                    showStudyResult(studyMode: .genericToBrand, question: question)
                                } // VStack ここまで
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

    // 学習結果（正解か不正解か）を表示
    private func showStudyResult(studyMode: StudyMode, question: StudyItem) -> some View {
        // 学習結果（正解か不正解か）を取得
        HStack {
            switch studyMode {
            case .brandToGeneric:
                Text("商 → 般:")
                correctOrIncorrectImage(result: question.brandToGenericResult)
            case .genericToBrand:
                Text("般 → 商:")
                correctOrIncorrectImage(result: question.genericToBrandResult)
            } // switch ここまで
        } // HStack ここまで
    } // showStudyResult ここまで

    // まる、または、ばつのImage
    private func correctOrIncorrectImage(result: StudyResult) -> some View {
        // 画像の色
        var color: Color {
            switch result {
            case .correct:
                Color.buttonGreen
            case .incorrect:
                Color.buttonRed
            case .unanswered:
                Color.black
            } // switch ここまで
        } // color ここまで
        // まる、または、ばつのImage
        return Image(systemName: result.rawValue)
            // 幅を15に指定
            .frame(width: 15)
            // 正解なら緑、不正解なら赤にする
            .foregroundStyle(color)
    } // correctOrIncorrectImage ここまで
} // QuestionsView ここまで

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let questionList = QuestionList(context: context)
    return QuestionsView(brandToGenericAnswerPercentage: "0.0",
                         genericToBrandAnswerPercentage: "0.0",
                         questionList: questionList)
}
