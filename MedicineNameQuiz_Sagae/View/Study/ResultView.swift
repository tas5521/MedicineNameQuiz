//
//  ResultView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct ResultView: View {
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) private var context
    // 学習中であるかを管理する変数
    @Binding var isStudying: Bool
    // 学習結果の配列
    let questions: [StudyItem]
    // 問題リストの名前を保持する変数
    @State private var listName: String = ""

    // View Presentation State
    // 不正解の問題をリストに保存するためのポップアップの表示を管理する変数
    @State private var isShowPopUp = false

    var body: some View {
        // 手前から奥にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
                // セーフエリア外にも背景を表示
                .ignoresSafeArea()
            // 垂直方向にレイアウト
            VStack {
                // 垂直方向にレイアウト
                VStack(alignment: .leading) {
                    // 学習結果を表示
                    // 水平方向にレイアウト
                    HStack(spacing: 20) {
                        // 正解の数を表示
                        countResult(of: .correct)
                        // 不正解の数を表示
                        countResult(of: .incorrect)
                    } // HStack ここまで
                    // 上と左に30ポイント余白をつける
                    .padding([.leading, .top], 30)
                    // 下に10ポイント余白をつける
                    .padding(.bottom, 15)
                    // 文字の大きさを1.5倍にする
                    .scaleEffect(1.5)
                    // 結果のリスト
                    resultList
                } // VStack ここまで
                // 不正解の問題をリストに保存するボタン
                saveMistakesButton
                    // 上下左右に余白を追加
                    .padding()
            } // VStack ここまで
            .bold()
        } // ZStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("学習結果", displayMode: .inline)
        // ナビゲーションバーの背景を変更
        .navigationBarBackground()
        // ナビゲーションバーの右側に終了ボタンを配置
        .toolbar {
            // ボタンの位置を指定
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // 保存処理
                    // // ResultViewとStudyViewを閉じる
                    isStudying = false
                } label: {
                    // ラベル
                    Text("終了")
                } // Button ここまで
            } // ToolbarItem ここまで
        } // toolbar ここまで
    } // body ここまで

    // 解答結果のカウント
    private func countResult(of result: StudyResult) -> some View {
        HStack {
            // まるかばつのImageを配置
            Image(systemName: result.rawValue)
                // 正解なら緑、不正解なら赤にする
                .foregroundStyle(result == .correct ? Color.buttonGreen : Color.buttonRed)
            // 正解または不正解の数をカウント
            let resultCount = questions.filter { $0.studyResult == result }.count
            // 正解または不正解の数を表示
            Text(":  \(resultCount)")
        } // HStack ここまで
    } // countResult ここまで

    // 結果のリスト
    private var resultList: some View {
        // リストを作成
        List {
            // 繰り返し
            ForEach(questions) { question in
                // 水平方向にレイアウト
                HStack {
                    // 垂直方向にレイアウト
                    VStack(alignment: .leading) {
                        // 商品名を表示
                        Text(question.brandName)
                            .foregroundStyle(Color.blue)
                        // 一般名を表示
                        Text(question.genericName)
                            .foregroundStyle(Color.red)
                    } // VStack ここまで
                    // スペースを空ける
                    Spacer()
                    // 学習結果（正解か不正解か）を取得
                    let studyResult = question.studyResult
                    // まる、または、ばつのImage
                    Image(systemName: studyResult.rawValue)
                        // 幅を15に指定
                        .frame(width: 15)
                        // 正解なら緑、不正解なら赤にする
                        .foregroundStyle(studyResult == .correct ? Color.buttonGreen : Color.buttonRed)
                } // HStack ここまで
            } // ForEach ここまで
        } // List ここまで
        // リストのスタイルを.groupedに変更
        .listStyle(.grouped)
        // リストの背景のグレーの部分を非表示にする
        .scrollContentBackground(.hidden)
    } // resultList ここまで

    // 不正解の問題をリストに保存するボタン
    private var saveMistakesButton: some View {
        // 全ての問題に正解したかどうか
        let isAllCorrect = questions.filter { $0.studyResult == .incorrect }.count == 0
        return Button {
            // 警告を表示
            isShowPopUp.toggle()
        } label: {
            Text("不正解の問題をリストに保存する")
                // 太字にする
                .bold()
                // 文字の色を白に指定
                .foregroundStyle(Color.white)
                // 幅150高さ50に指定
                .frame(width: 300, height: 60)
                // 背景色をオレンジに指定
                .background(isAllCorrect ? Color.disabledButtonGray : Color.buttonOrange)
                // 角を丸くする
                .clipShape(.buttonBorder)
        } // Button ここまで
        .disabled(isAllCorrect == true)
        // 間違えた問題をリストに保存するためのポップアップを表示
        .alert("不正解の問題をリストに保存", isPresented: $isShowPopUp) {
            // 問題リストの名前を入力するテキストフィールド
            TextField("問題リストの名前", text: $listName)
            // 保存ボタン
            Button {
                // 問題リストの作成処理
                saveIncorrectQuestions()
            } label: {
                Text("保存")
            } // Button ここまで
            // やめるボタン
            Button(role: .cancel) {
                // 何もしない
            } label: {
                Text("やめる")
            } // Button ここまで
        } message: {
            Text("リストに名前をつけてください")
        } // alert ここまで
    } // saveMistakesButton ここまで

    // 間違えた問題をCore Dataに保存するメソッド
    func saveIncorrectQuestions() {
        // 間違えた問題でフィルター
        let incorrectQuestions = questions.filter { $0.studyResult == .incorrect }
        // 問題リストのインスタンスを生成
        let questionList = QuestionList(context: context)
        // リスト名を保持
        if listName.isEmpty {
            questionList.listName = "不正解の問題"
        } else {
            questionList.listName = listName
        } // if ここまで
        // 作成した日付を保持
        questionList.createdDate = Date()
        // questionSetにデータを格納
        for studyItem in incorrectQuestions {
            // 問題のインスタンスを生成
            let question = Question(context: context)
            // カテゴリ、商品名、一般名を保持
            question.category = studyItem.category.rawValue
            question.brandName = studyItem.brandName
            question.genericName = studyItem.genericName
            // 作成した問題を問題リストに追加
            questionList.addToQuestions(question)
        } // for ここまで
        // 問題数を保持
        questionList.numberOfQuestions = Int16(questionList.questions?.count ?? 0)
        do {
            // 問題リストをCore Dataに保存
            try context.save()
        } catch {
            // 何らかのエラーが発生した場合は、エラー内容をデバッグエリアに表示
            print("エラー: \(error)")
        } // do-try-catch ここまで
    } // saveQuestionList ここまで
} // ResultView ここまで

#Preview {
    // ダミーの問題
    let dummyQuestions: [StudyItem] = [
        StudyItem(category: .oral,
                  brandName: "ダミーの商品名",
                  genericName: "ダミーの一般名",
                  studyResult: .incorrect)
    ] // dummyStudyItem ここまで
    return ResultView(isStudying: .constant(true), questions: dummyQuestions)
}
