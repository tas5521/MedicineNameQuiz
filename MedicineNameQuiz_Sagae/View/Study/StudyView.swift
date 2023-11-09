//
//  StudyView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct StudyView: View {
    // 学習中であるかを管理する変数
    @Binding var isStudying: Bool
    // 選択されている学習モード
    let studyMode: StudyMode
    // ダミーの問題
    private let dummyQuestion: (String, [String]) = ("アムロジン", ["アムロジピンベシル酸塩", "イミダフェナシン", "エバスチン", "プランルカスト水和物"])
    
    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // 垂直方向にレイアウト
            VStack(alignment: .leading) {
                // 水平方向にレイアウト
                HStack {
                    // スコアタイム
                    Text("時間")
                        .padding()
                    Spacer()
                    // これまでの解答結果
                    Text("まるばつパス")
                        .padding()
                } // HStack ここまで
                // 制限時間
                Text("制限時間")
                    .padding()
                // 問題文
                Text("一般名を答えてください\nQ1. \(dummyQuestion.0)")
                    .padding()
            } // VStackここまで
            // 選択肢を配置
            choices
            Spacer()
        } // VStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("学習中", displayMode: .inline)
    } // body ここまで

    // 選択肢
    private var choices: some View {
        VStack {
            // 選択肢を作成
            ForEach(dummyQuestion.1, id: \.self) { item in
                NavigationLink {
                    ResultView(isStudying: $isStudying, studyMode: studyMode)
                } label: {
                    Text(item)
                        .foregroundColor(Color.blue)
                } // NavigationLinkここまで
                .padding()
            } // ForEach ここまで
            // パスボタン
            NavigationLink {
                ResultView(isStudying: $isStudying, studyMode: studyMode)
            } label: {
                Text("パス")
                    .foregroundColor(Color.blue)
            } // NavigationLinkここまで
        } // VStack ここまで
    } // choicesここまで
} // StudyView ここまで

#Preview {
    StudyView(isStudying: .constant(true), studyMode: .actual)
}
