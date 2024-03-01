//
//  ChallengeRankingView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/11/14.
//

// 本アプリの第1回目のリリース目標として、ランキング機能なしで学習のみできるアプリを作成することとなりました。
// そのため、第一段階のアプリ作成の間は、ランキング機能に関連するコードをコメントアウトします。

// ChallengeRankingView全体をコメントアウト
/*
 import SwiftUI

 struct ChallengeRankingView: View {
 // ランキングに挑戦中であるかを管理する変数
 @Binding var isChallenging: Bool
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
 .navigationBarTitle("挑戦中", displayMode: .inline)
 } // body ここまで

 // 選択肢
 private var choices: some View {
 VStack {
 // 選択肢を作成
 ForEach(dummyQuestion.1, id: \.self) { item in
 NavigationLink {
 RankingResultView(isChallenging: $isChallenging)
 } label: {
 Text(item)
 .foregroundColor(Color.blue)
 } // NavigationLinkここまで
 .padding()
 } // ForEach ここまで
 // パスボタン
 NavigationLink {
 RankingResultView(isChallenging: $isChallenging)
 } label: {
 Text("パス")
 .foregroundColor(Color.blue)
 } // NavigationLinkここまで
 } // VStack ここまで
 } // choicesここまで
 } // ChallengeRankingView ここまで

 #Preview {
 ChallengeRankingView(isChallenging: .constant(true))
 }
 */
