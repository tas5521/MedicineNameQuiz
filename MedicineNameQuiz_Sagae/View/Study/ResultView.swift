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
            VStack(alignment: .leading) {
                // 学習結果を表示
                // 水平方向にレイアウト
                HStack {
                    // 正解の数を表示
                    Image(systemName: StudyResult.correct.rawValue)
                        .foregroundStyle(Color.buttonGreen)
                        .bold()
                    let correctCount = dummyResult.filter { $0.studyResult == .correct }.count
                    Text(":  \(correctCount)")
                        .padding(.trailing)
                    // 不正解の数を表示
                    Image(systemName: StudyResult.incorrect.rawValue)
                        .foregroundStyle(Color.buttonRed)
                        .bold()
                    let incorrectCount = dummyResult.filter { $0.studyResult == .incorrect }.count
                    Text(":  \(incorrectCount)")
                } // HStack ここまで
                .padding(.leading, 30)
                .padding(.top, 30)
                .scaleEffect(1.5)
                
                // 結果のリスト
                List {
                    ForEach(dummyResult) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.brandName)
                                    .foregroundStyle(Color.blue)
                                    .bold()
                                Text(item.genericName)
                                    .foregroundStyle(Color.red)
                                    .bold()
                            } // VStack ここまで
                            Spacer()
                            let studyResult = item.studyResult
                            Image(systemName: studyResult.rawValue)
                                .frame(width: 15)
                                .foregroundStyle(studyResult == .correct ? Color.buttonGreen : Color.buttonRed)
                                .bold()
                        } // HStack ここまで
                    } // ForEach ここまで
                } // List ここまで
                // リストのスタイルを.groupedに変更
                .listStyle(.grouped)
                // リストの背景のグレーの部分を非表示にする
                .scrollContentBackground(.hidden)

                // 間違えた問題をリストに保存するボタン
                saveMistakesButton
                // 上下左右に余白を追加
                    .padding()
            } // VStack ここまで
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
                    // 色を指定
                        .foregroundColor(Color.black)
                } // Button ここまで
            } // ToolbarItem ここまで
        } // toolbar ここまで
    } // body ここまで
    
    // 間違えた問題をリストに保存するボタン
    var saveMistakesButton: some View {
        Button {
            // 警告を表示
            isShowPopUp.toggle()
        } label: {
            Text("間違えた問題をリストに保存する")
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
