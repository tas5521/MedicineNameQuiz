//
//  AnswerButton.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/11/28.
//

import SwiftUI

// 解答ボタン
struct AnswerButton: View {
    // このボタンで行う処理
    let action: (() -> Void)?
    // SFSymbolの名前
    let systemName: String
    // ボタンの色
    let color: Color
    
    var body: some View {
        Button {
            // このボタンで行う処理
            action?()
        } label: {
            // ラベル
            Image(systemName: systemName)
            // 幅高さ80に指定
                .frame(width: 80, height: 80)
            // フォントを.titleに指定
                .font(.title)
            // 太字にする
                .bold()
            // 背景色を指定
                .background(color)
            // 角を丸くする
                .clipShape(.buttonBorder)
            // 文字の色を白に指定
                .foregroundStyle(.white)
        } // Button ここまで
    } // body ここまで
} // AnswerButton ここまで

#Preview {
    AnswerButton(action: { print("Correct") }, systemName: "circle", color: .buttonGreen)
}
