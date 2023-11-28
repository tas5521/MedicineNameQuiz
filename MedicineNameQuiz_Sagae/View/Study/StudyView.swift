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
    // 問題番号を管理する変数
    @State private var questionNumber: Int = 0

    // View Presentation State
    // 結果画面の表示を管理する変数
    @State private var isShowResultView: Bool = false

    // CardViewModelのインスタンス
    private let cardViewModel: CardViewModel = CardViewModel.shared

    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // スペースを空ける
            Spacer()
            // 問題番号
            Text("\(questionNumber + 1)/\(cardViewModel.medicineNames.count)")
            // フォントを.titleに変更
                .font(.title)
            // スペースを空ける
            Spacer()
            // カードのViewを配置
            CardView(frontText: cardViewModel.medicineNames[questionNumber].front,
                     backText: cardViewModel.medicineNames[questionNumber].back)
            // スペースを空ける
            Spacer()
            // 水平方向にレイアウト
            HStack(spacing: 20) {
                // 正解ボタン
                Button {
                    // カードがめくられていたら、元に戻す（ただし、最後の問題だったら、フリップしない）
                    if cardViewModel.isFlipped && questionNumber != cardViewModel.medicineNames.count - 1 {
                        // カードをめくる
                        cardViewModel.flipCard()
                    } // if ここまで
                    // カードが半分めくられるまで待つ
                    DispatchQueue.main.asyncAfter(deadline: .now() + cardViewModel.duration) {
                        // 次の問題へ
                        questionNumber += 1
                        // もし、最後の問題だったら
                        if questionNumber == cardViewModel.medicineNames.count {
                            // クラッシュしないよう、numberを1減らす
                            questionNumber -= 1
                            // 結果画面を表示
                            isShowResultView.toggle()
                        } // if ここまで
                    } // DispatchQueue ここまで
                } label: {
                    // ラベル
                    Image(systemName: "circle")
                    // 幅高さ80に指定
                        .frame(width: 80, height: 80)
                    // フォントを.titleに指定
                        .font(.title)
                    // 太字にする
                        .bold()
                    // 背景色を緑に指定
                        .background(.buttonGreen)
                    // 角を丸くする
                        .clipShape(.buttonBorder)
                    // 文字の色を白に指定
                        .foregroundStyle(.white)
                } // Button ここまで
                // 不正解ボタン
                Button {
                    // カードがめくられていたら、元に戻す（ただし、最後の問題だったら、フリップしない）
                    if cardViewModel.isFlipped && questionNumber != cardViewModel.medicineNames.count - 1 {
                        // カードをめくる
                        cardViewModel.flipCard()
                    } // if ここまで
                    // カードが半分めくられるまで待つ
                    DispatchQueue.main.asyncAfter(deadline: .now() + cardViewModel.duration) {
                        // 次の問題へ
                        questionNumber += 1
                        // もし、最後の問題だったら
                        if questionNumber == cardViewModel.medicineNames.count {
                            // クラッシュしないよう、numberを1減らす
                            questionNumber -= 1
                            // 結果画面を表示
                            isShowResultView.toggle()
                        } // if ここまで
                    } // DispatchQueue ここまで
                } label: {
                    Image(systemName: "multiply")
                    // 幅高さ80に指定
                        .frame(width: 80, height: 80)
                    // フォントを.titleに指定
                        .font(.title)
                    // 太字にする
                        .bold()
                    // 背景色を赤に指定
                        .background(.buttonRed)
                    // 角を丸くする
                        .clipShape(.buttonBorder)
                    // 文字の色を白に指定
                        .foregroundStyle(.white)
                } // Button ここまで
                // 一つ前の問題に戻るボタン
                Button {
                    // カードがめくられていたら、元に戻す
                    if cardViewModel.isFlipped {
                        // カードをめくる
                        cardViewModel.flipCard()
                    } // if ここまで
                    // カードが半分めくられるまで待つ
                    DispatchQueue.main.asyncAfter(deadline: .now() + cardViewModel.duration) {
                        // 一つ前の問題に戻る
                        questionNumber -= 1
                        // 問題番号が0未満の時
                        if questionNumber < 0 {
                            // クラッシュを避けるため、問題番号を0にする
                            questionNumber = 0
                        } // if ここまで
                    } // DispatchQueue ここまで
                } label: {
                    Image(systemName: "arrowshape.backward.fill")
                    // 幅高さ80に指定
                        .frame(width: 80, height: 80)
                    // フォントを.titleに指定
                        .font(.title)
                    // 太字にする
                        .bold()
                    // 背景色をオレンジに指定
                        .background(.gray)
                    // 角を丸くする
                        .clipShape(.buttonBorder)
                    // 文字の色をグレーに指定
                        .foregroundStyle(.white)
                } // Button ここまで
            } // HStack ここまで
            // スペースを空ける
            Spacer()
        } // VStack ここまで
        // 学習終了時に、必ず、カードを元の面に戻す
        .onDisappear {
            // カードがめくられていたら、元に戻す
            if cardViewModel.isFlipped {
                // カードをめくる
                cardViewModel.flipCard()
            } // if ここまで
        } // onDisappear ここまで
        // 問題を解く画面へ遷移
        .navigationDestination(isPresented: $isShowResultView) {
            // 結果画面を表示
            ResultView(isStudying: $isStudying)
        } // navigationDestination ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("学習中", displayMode: .inline)
    } // body ここまで
} // StudyView ここまで

#Preview {
    StudyView(isStudying: .constant(true))
}
