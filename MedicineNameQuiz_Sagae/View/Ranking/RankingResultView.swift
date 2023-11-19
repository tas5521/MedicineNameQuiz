//
//  RankingResultView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/11/14.
//

// 本アプリの第1回目のリリース目標として、ランキング機能なしで学習のみできるアプリを作成することとなりました。
// そのため、第一段階のアプリ作成の間は、ランキング機能に関連するコードをコメントアウトします。

// RankingResultView全体をコメントアウト
/*
import SwiftUI

struct RankingResultView: View {
    // ランキングに挑戦中であるかを管理する変数
    @Binding var isChallenging: Bool
    // 問題リストの名前を保持する変数
    @State private var questionListName: String = ""
    
    // View Presentation State
    // 間違えた問題をリストに保存するためのポップアップの表示を管理する変数
    @State private var isShowPopUp = false
    
    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // 学習結果を表示
            Text("結果表示")
            // 上下左右に余白を追加
                .padding()
            
            // 間違えた問題をリストに保存するボタン
            saveMistakesButton
            // 上下左右に余白を追加
                .padding()
        } // VStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("結果", displayMode: .inline)
        // 戻るボタンを隠す
        /*
         本アプリでは、「RankingViewで出題モードを選択し、ランキングに挑戦ボタンをタップ → ChallengeRankingViewで問題を解く → RankingResultViewで解答結果を集計し、表示する → 終了ボタンを押し、RankingViewに戻る」を一連の流れとするため、RankingResultViewからChallengeRankingViewに戻ることは想定していません。
         また、RankingResult画面を終了した際は、RankingView（二つ前の画面）に一度に戻ることを想定しており、通常の戻るボタンを使用して、ChallengeRankingViewを経由して戻ることは避けたいと考えています。
         そのため、通常の戻るボタンを隠し、独自の終了ボタンを配置しています。
         */
        .navigationBarBackButtonHidden(true)
        // ナビゲーションバーの右側に終了ボタンを配置
        .toolbar {
            // ボタンの位置を指定
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // 保存処理
                    // RankingResultViewとChallengeRankingViewを閉じる
                    isChallenging = false
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
} // RankingResultView ここまで

#Preview {
    RankingResultView(isChallenging: .constant(true))
}
*/
