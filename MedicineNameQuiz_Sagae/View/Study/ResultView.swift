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
    // 問題リストの名前を保持する変数
    @State private var listName: String = ""

    var body: some View {
        // 手前から奥にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
                // セーフエリア外にも背景を表示
                .ignoresSafeArea()
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
        HStack {
            // まるかばつのImageを配置
            Image(systemName: result.rawValue)
                // 正解なら緑、不正解なら赤にする
                .foregroundStyle(result == .correct ? Color.buttonGreen : Color.buttonRed)
            // 正解または不正解の数をカウント
            var resultCount: Int {
                switch studyMode {
                case .brandToGeneric:
                    return questions.filter { $0.brandToGenericResult == result }.count
                case .genericToBrand:
                    return questions.filter { $0.genericToBrandResult == result }.count
                } // switch ここまで
            } // resultCount ここまで
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
    return ResultView(isStudying: .constant(true), questions: dummyQuestions, studyMode: .brandToGeneric)
}
