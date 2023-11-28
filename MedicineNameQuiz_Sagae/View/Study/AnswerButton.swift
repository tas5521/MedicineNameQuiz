//
//  AnswerButton.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/11/28.
//

import SwiftUI

// 解答ボタン
struct AnswerButton: View {
    // ボタンの種類
    let answerButtonType: AnswerButtonType
    // このボタンで行う処理
    let action: (() -> Void)?

    var body: some View {
        Button {
            // このボタンで行う処理
            action?()
        } label: {
            // ラベル
            Image(systemName: answerButtonType.systemName)
            // 幅高さ80に指定
                .frame(width: 80, height: 80)
            // フォントを.titleに指定
                .font(.title)
            // 太字にする
                .bold()
            // 背景色を指定
                .background(answerButtonType.buttonColor)
            // 角を丸くする
                .clipShape(.buttonBorder)
            // 文字の色を白に指定
                .foregroundStyle(.white)
        } // Button ここまで
    } // body ここまで
} // AnswerButton ここまで

#Preview {
    AnswerButton(answerButtonType: .correct, action: { print("Correct") })
}
