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
    @State private var number: Int = 0

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
            Text("\(number + 1)/\(cardViewModel.medicineNames.count)")
                .font(.title)
            // スペースを空ける
            Spacer()
            // カードのViewを配置
            CardView(frontText: cardViewModel.medicineNames[number].front,
                     backText: cardViewModel.medicineNames[number].back)
            // スペースを空ける
            Spacer()
            // 水平方向にレイアウト
            HStack(spacing: 20) {
                // 正解ボタン
                Button {
                    // カードがめくられて裏になっていたら、表に戻す
                    if cardViewModel.isFlipped && number != cardViewModel.medicineNames.count - 1 {
                        // カードをめくる
                        cardViewModel.flipCard()
                    } // if ここまで
                    // カードが半分めくられるまで待つ
                    DispatchQueue.main.asyncAfter(deadline: .now() + cardViewModel.duration) {
                        // 次の問題へ
                        number += 1
                        // もし、最後の問題だったら
                        if number == cardViewModel.medicineNames.count {
                            number -= 1
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
                    // 背景色をオレンジに指定
                        .background(.buttonOrange)
                    // 角を丸くする
                        .clipShape(.buttonBorder)
                    // 文字の色を緑に指定
                        .foregroundStyle(.green)
                } // Button ここまで
                // 不正解ボタン
                Button {
                    if cardViewModel.isFlipped && number != cardViewModel.medicineNames.count - 1 {
                        cardViewModel.flipCard()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + cardViewModel.duration) {
                        number += 1
                        // もし、最後の問題だったら
                        if number == cardViewModel.medicineNames.count {
                            number -= 1
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
                    // 背景色をオレンジに指定
                        .background(.buttonOrange)
                    // 角を丸くする
                        .clipShape(.buttonBorder)
                    // 文字の色を赤に指定
                        .foregroundStyle(.red)
                } // Button ここまで
                // 一つ前の問題に戻るボタン
                Button {
                    if cardViewModel.isFlipped {
                        cardViewModel.flipCard()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + cardViewModel.duration) {
                        number -= 1
                        if number == -1 {
                            number = 0
                        } // if ここまで
                    } // DispatchQueue ここまで
                } label: {
                    Image(systemName: "arrowshape.backward.fill")
                        .frame(width: 80, height: 80)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.gray)
                        .background(.buttonOrange)
                        .clipShape(.buttonBorder)
                } // Button ここまで
            } // HStack ここまで
            // スペースを空ける
            Spacer()
        } // VStack ここまで
        // 問題を解く画面へ遷移
        .navigationDestination(isPresented: $isShowResultView) {
            ResultView(isStudying: $isStudying)
        } // navigationDestination ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("学習中", displayMode: .inline)
    } // body ここまで
} // StudyView ここまで

#Preview {
    StudyView(isStudying: .constant(true))
}
