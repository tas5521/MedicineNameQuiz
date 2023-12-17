//
//  ResultView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct ResultView: View {
    // 学習中であるかを管理する変数
    @Binding var isStudying: Bool
    // 問題リストの名前を保持する変数
    @State private var questionListName: String = ""
    
    // View Presentation State
    // 間違えた問題をリストに保存するためのポップアップの表示を管理する変数
    @State private var isShowPopUp = false
    
    // ダミーの解答結果
    private let dummyResult: [StudyResultListItem] = [
        StudyResultListItem(brandName: "アムロジン", genericName: "アムロジピンベシル酸塩", studyResult: .incorrect),
        StudyResultListItem(brandName: "インフリー", genericName: "インドメタシン　ファルネシル", studyResult: .correct),
        StudyResultListItem(brandName: "ウリトス", genericName: "イミダフェナシン", studyResult: .correct),
        StudyResultListItem(brandName: "エバステル", genericName: "エバスチン", studyResult: .incorrect),
        StudyResultListItem(brandName: "オノン", genericName: "プランルカスト水和物", studyResult: .correct)
    ]
    
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
                    HStack {
                        // 正解の数を表示
                        countResult(of: .correct)
                        // 不正解の数を表示
                        countResult(of: .incorrect)
                    } // HStack ここまで
                    // 上と左に30ポイント余白をつける
                    .padding([.leading,.top], 30)
                    // 下に10ポイント余白をつける
                    .padding(.bottom, 15)
                    // 文字の大きさを1.5倍にする
                    .scaleEffect(1.5)
                    // 結果のリスト
                    resultList
                } // VStack ここまで
                // 間違えた問題をリストに保存するボタン
                saveMistakesButton
                // 上下左右に余白を追加
                    .padding()
            } // VStack ここまで
            .bold()
        } // ZStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("学習結果", displayMode: .inline)
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
    @ViewBuilder
    private func countResult(of result: StudyResult) -> some View {
        // まるかばつのImageを配置
        Image(systemName: result.rawValue)
        // 正解なら緑、不正解なら赤にする
            .foregroundStyle(result == .correct ? Color.buttonGreen : Color.buttonRed)
        // 正解または不正解の数をカウント
        let resultCount = dummyResult.filter { $0.studyResult == result }.count
        // 正解または不正解の数を表示
        Text(":  \(resultCount)")
    } // countResult ここまで
    
    // 結果のリスト
    private var resultList: some View {
        // リストを作成
        List {
            // 繰り返し
            ForEach(dummyResult) { item in
                // 水平方向にレイアウト
                HStack {
                    // 垂直方向にレイアウト
                    VStack(alignment: .leading) {
                        // 先発品名を表示
                        Text(item.brandName)
                            .foregroundStyle(Color.blue)
                        // 一般名を表示
                        Text(item.genericName)
                            .foregroundStyle(Color.red)
                    } // VStack ここまで
                    // スペースを空ける
                    Spacer()
                    // 学習結果（正解か不正解か）を取得
                    let studyResult = item.studyResult
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

    // 間違えた問題をリストに保存するボタン
    private var saveMistakesButton: some View {
        Button {
            // 警告を表示
            isShowPopUp.toggle()
        } label: {
            Text("間違えた問題をリストに保存する")
            // 太字にする
                .bold()
            // 文字の色を白に指定
                .foregroundStyle(Color.white)
            // 幅150高さ50に指定
                .frame(width: 300, height: 60)
            // 背景色をオレンジに指定
                .background(Color.buttonOrange)
            // 角を丸くする
                .clipShape(.buttonBorder)
        } // Button ここまで
        // 間違えた問題をリストに保存するためのポップアップを表示
        .alert("間違えた問題をリストに保存", isPresented: $isShowPopUp) {
            // 問題リストの名前を入力するテキストフィールド
            TextField("問題リストの名前", text: $questionListName)
            // 保存ボタン
            Button {
                // 問題リストの作成処理
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
} // ResultView ここまで

#Preview {
    ResultView(isStudying: .constant(true))
}
