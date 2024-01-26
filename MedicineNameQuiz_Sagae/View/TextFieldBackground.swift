//
//  TextFieldBackground.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/01/17.
//

import SwiftUI

struct TextFieldBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
        // 文字の左に余白を追加
            .padding(.leading, 6)
        // 背景色を指定
            .background(
                // 背景を角の丸い四角にする
                RoundedRectangle(cornerRadius: 8)
                // 背景色を変更
                    .fill(Color(red: 237/255, green: 237/255, blue: 237/255))
                // 高さを36に指定
                    .frame(height: 36))
    } // body ここまで
} // TextFieldBackground ここまで

extension View {
    func textFieldBackground() -> some View {
        modifier(TextFieldBackground())
    } // textFieldBackground ここまで
} // View拡張ここまで
