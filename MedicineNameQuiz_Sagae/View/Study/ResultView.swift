//
//  ResultView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct ResultView: View {
    // 学習の開始を管理する変数
    @Binding var isStartStudy: Bool
    // 警告の表示を管理する変数
    @State private var isShowAlert = false
    // 問題リストの名前を保持する変数
    @State private var questionListName: String = ""
    // 選択されている学習モード
    let selectedStudyMode: SelectedStudyMode

    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // 結果表示
            result
            // 上下左右に余白を追加
                .padding()
            // 間違えた問題をリストに保存するボタン
            buttonToSaveIncorrectQuestionsToList
            // 上下左右に余白を追加
                .padding()
            // 練習モードでは、学習結果を表示
            if selectedStudyMode == .practice {
                // 結果のリスト
                resultList
                // 上下左右に余白を追加
                    .padding()
            } // if ここまで
        } // VStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("学習", displayMode: .inline)
        // ナビゲーションバーの右側にカスタムの終了ボタンを配置
        .placeCustomButtonTrailing(label: "終了") {
            // ResultViewを閉じてStudyingViewも閉じる
            isStartStudy = false
        } // placeCustomButtonTrailing
    } // bodyここまで
    
    // 結果表示
    private var result: some View {
        Text("結果表示")
    } // result ここまで
    
    // 間違えた問題をリストに保存するボタン
    private var buttonToSaveIncorrectQuestionsToList: some View {
        Button {
            // 警告を表示
            isShowAlert.toggle()
        } label: {
            Text("間違えた問題をリストに保存する")
        } // Button ここまで
        // 間違えた問題をリストに保存するためのポップアップを表示
        .alert("間違えた問題をリストに保存", isPresented: $isShowAlert) {
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
    } // buttonToSaveIncorrectQuestionsToList ここまで
    
    // 結果のリスト
    private var resultList: some View {
        Text("結果のリスト")
    } // resultList
} // ResultView ここまで

#Preview {
    ResultView(isStartStudy: .constant(true), selectedStudyMode: .practice)
}
