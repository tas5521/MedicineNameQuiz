//
//  AnswerButtonType.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/11/28.
//

import SwiftUI

enum AnswerButtonType {
    case correct
    case incorrect
    case back

    // SFSymbolの名前
    var systemName: String {
        switch self {
        case .correct:
            "circle"
        case .incorrect:
            "multiply"
        case .back:
            "arrowshape.backward.fill"
        } // switchここまで
    } // systemName ここまで

    // ボタンの色
    var buttonColor: Color {
        switch self {
        case .correct:
            .buttonGreen
        case .incorrect:
            .buttonRed
        case .back:
            .gray
        } // switchここまで
    } // buttonColor ここまで
} // AnswerButtonType ここまで
