//
//  StudyingView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct StudyingView: View {
    // 学習の開始を管理する変数
    @Binding var isStartStudy: Bool
    // 選択されている学習モード
    let selectedStudyMode: SelectedStudyMode
    // ダミーの問題
    let dummyQuestion: (String, [String]) = ("アムロジン", ["アムロジピンベシル酸塩", "イミダフェナシン", "エバスチン", "プランルカスト水和物"])
    
    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // 垂直方向にレイアウト
            VStack(alignment: .leading) {
                // 水平方向にレイアウト
                HStack {
                    // 経過時間
                    scoreTime
                        .padding()
                    Spacer()
                    // これまでの解答結果
                    resultsSoFar
                        .padding()
                } // HStack ここまで
                // 制限時間
                timeLimit
                    .padding()
                // 問題文
                examinationSentence
                    .padding()
            } // VStackここまで
            // 選択肢を配置
            choices
            Spacer()
        } // VStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("学習", displayMode: .inline)
        // ナビゲーションバーの右側にカスタムの終了ボタンを配置
        .placeCustomButtonTrailing(label: "終了") {
            // StudyingViewを閉じる
            isStartStudy = false
        } // placeCustomButtonTrailing
    } // body ここまで
    
    // スコアタイム
    private var scoreTime: some View {
        Text("時間")
    } // scoreTimerView ここまで
    
    // これまでの解答結果
    private var resultsSoFar: some View {
        Text("まるばつパス")
    } // resultsSoFarView ここまで
    
    // 制限時間
    private var timeLimit: some View {
        Text("制限時間")
    } // timeLimitView ここまで
    
    // 問題文
    private var examinationSentence: some View {
        Text("一般名を答えてください\nQ1. \(dummyQuestion.0)")
    } // examinationSentence ここまで
    
    // 選択肢
    private var choices: some View {
        VStack {
            // 選択肢を作成
            ForEach(dummyQuestion.1, id: \.self) { item in
                NavigationLink {
                    ResultView(isStartStudy: $isStartStudy, selectedStudyMode: selectedStudyMode)
                } label: {
                    Text(item)
                        .foregroundColor(Color.blue)
                } // NavigationLinkここまで
                .padding()
            } // ForEach ここまで
            // パスボタン
            NavigationLink {
                ResultView(isStartStudy: $isStartStudy, selectedStudyMode: selectedStudyMode)
            } label: {
                Text("パス")
                    .foregroundColor(Color.blue)
            } // NavigationLinkここまで
        } // VStack ここまで
    } // choicesここまで
} // StudyingView ここまで

#Preview {
    StudyingView(isStartStudy: .constant(true), selectedStudyMode: .actual)
}
