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
    // モード選択を管理する変数
    let studyMode: StudyMode
    // 出題設定を管理する変数
    let questionSelection: QuestionSelectionMode
    // 問題リストの名前
    let listName: String

    var body: some View {
        // 手前から奥にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
                // セーフエリア外にも背景を表示
                .ignoresSafeArea()
            // 学習結果を表示
            // 垂直方向にレイアウト
            VStack(alignment: .leading) {
                // 垂直方向にレイアウト
                VStack(alignment: .leading, spacing: 10) {
                    Text("問題リスト: \(listName)")
                    // 垂直方向にレイアウト
                    VStack(alignment: .leading) {
                        Text("出題設定")
                        Group {
                            Text(studyMode.rawValue)
                            Text(questionSelection.rawValue)
                        } // Group ここまで
                        // 左に余白を追加
                        .padding(.leading)
                    } // VStack ここまで
                    // 垂直方向にレイアウト
                    VStack(alignment: .leading) {
                        Text("学習結果")
                        // 水平方向にレイアウト
                        HStack(spacing: 20) {
                            // 正解の数を表示
                            countResult(of: .correct)
                            // 不正解の数を表示
                            countResult(of: .incorrect)
                        } // HStack ここまで
                    } // VStack ここまで
                    // 水平方向にレイアウト
                    HStack {
                        // 問題数を表示
                        Text("問題数:\(questions.count)")
                        // スペースを空ける
                        Spacer()
                        // 正答率を表示
                        Text("正答率:\(answerPercentage(questions: questions, studyMode: studyMode))")
                    } // HStack ここまで
                    // 上に余白を追加
                    .padding(.top)
                } // VStack ここまで
                // 上下左右に余白を追加
                .padding()
                // 結果のリスト
                resultList
            } // VStack ここまで
            // 太字にする
            .bold()
        } // ZStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("学習結果", displayMode: .inline)
        // ナビゲーションバーの背景を変更
        .navigationBarBackground()
        // ナビゲーションバーの右側に終了ボタンを配置
        .toolbar {
            // ボタンの位置を指定
            ToolbarItem(placement: .topBarTrailing) {
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
        // 正解または不正解の数をカウント
        let resultCount = questions.filter {
            switch studyMode {
            case .brandToGeneric:
                return $0.brandToGenericResult == result
            case .genericToBrand:
                return $0.genericToBrandResult == result
            } // switch ここまで
        }.count // resultCount ここまで
        
        return HStack {
            // まるかばつのImageを配置
            Image(systemName: result.rawValue)
                // 正解なら緑、不正解なら赤にする
                .foregroundStyle(result == .correct ? Color.buttonGreen : Color.buttonRed)
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
                // 問題側の薬名を取得
                var questionName: String {
                    switch studyMode {
                    case .brandToGeneric:
                        question.brandName
                    case .genericToBrand:
                        question.genericName
                    } // switch ここまで
                } // questionName ここまで
                // 解答側の薬名を取得
                var answerName: String {
                    switch studyMode {
                    case .brandToGeneric:
                        question.genericName
                    case .genericToBrand:
                        question.brandName
                    } // switch ここまで
                } // questionName ここまで
                // 水平方向にレイアウト
                HStack {
                    // 垂直方向にレイアウト
                    VStack(alignment: .leading) {
                        // 問題側の薬名を表示
                        Text(questionName)
                            .foregroundStyle(Color.black)
                        // 解答側の薬名を表示
                        Text(answerName)
                            .foregroundStyle(Color.red)
                    } // VStack ここまで
                    // スペースを空ける
                    Spacer()
                    // 学習結果（正解か不正解か）を取得
                    var studyResult: StudyResult {
                        switch studyMode {
                        case .brandToGeneric:
                            question.brandToGenericResult
                        case .genericToBrand:
                            question.genericToBrandResult
                        } // switch ここまで
                    } // studyResult ここまで
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

    // 正答率を計算するメソッド
    private func answerPercentage(questions: [StudyItem], studyMode: StudyMode) -> String {
        // 正解数を計算
        let correctCount = questions.filter({
            switch studyMode {
            // 商品名→一般名
            case .brandToGeneric:
                $0.brandToGenericResult == .correct
            // 一般名→商品名
            case .genericToBrand:
                $0.genericToBrandResult == .correct
            } // switch ここまで
        }).count
        // 正答率を計算して返却
        return String(format: "%.1f%%", Float(correctCount) / Float(questions.count) * 100)
    } // answerPercentage ここまで
} // ResultView ここまで

#Preview {
    // ダミーの問題
    let dummyQuestions: [StudyItem] = [
        StudyItem(category: .oral,
                  brandName: "ダミーの商品名",
                  genericName: "ダミーの一般名",
                  brandToGenericResult: .incorrect,
                  genericToBrandResult: .incorrect)
    ] // dummyStudyItem ここまで
    return ResultView(isStudying: .constant(true),
                      questions: dummyQuestions,
                      studyMode: .brandToGeneric,
                      questionSelection: .all,
                      listName: "ダミー薬局")
}
