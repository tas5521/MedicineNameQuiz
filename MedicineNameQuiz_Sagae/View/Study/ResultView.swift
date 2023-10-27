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
    // 間違えた問題をリストに保存するためのポップアップの表示を管理する変数
    @State private var isShowPopUp = false
    // 問題リストの名前を保持する変数
    @State private var questionListName: String = ""
    // 選択されている学習モード
    let studyMode: StudyMode

    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // 学習結果を表示
            results
            // 上下左右に余白を追加
                .padding()
            // 間違えた問題をリストに保存するボタン
            saveMistakesButton
            // 上下左右に余白を追加
                .padding()
            // 練習モードでは、学習結果を表示
            if studyMode == .practice {
                // 結果のリスト
                studyResultList
                // 上下左右に余白を追加
                    .padding()
            } // if ここまで
        } // VStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("学習", displayMode: .inline)
        // ナビゲーションバーの右側に終了ボタンを配置
        .navigationBarWithButtonTrailing(label: "終了") {
            // ResultViewとQuestionViewを閉じる
            isStudying = false
        } // navigationBarWithButtonTrailing ここまで
    } // body ここまで
    
    // 学習結果
    private var results: some View {
        Text("結果表示")
    } // results ここまで
    
    // 間違えた問題をリストに保存するボタン
    private var saveMistakesButton: some View {
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
    
    // 結果のリスト
    private var studyResultList: some View {
        Text("結果のリスト")
    } // studyResultList ここまで
} // ResultView ここまで

#Preview {
    ResultView(isStudying: .constant(true), studyMode: .practice)
}
