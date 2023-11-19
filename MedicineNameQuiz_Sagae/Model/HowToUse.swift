//
//  HowToUse.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

// 本アプリの第1回目のリリース目標として、ランキング機能なしで学習のみできるアプリを作成することとなりました。
// そのため、第一段階のアプリ作成の間は、ランキング機能に関連するコードをコメントアウトします。

import Foundation

enum HowToUse: String, CaseIterable {
    case study = "学習"
    case questionList = "問題リスト"
    // ランキング機能に関連するコードをコメントアウト
    // case ranking = "ランキング"
    case medicineList = "薬リスト"
} // HowToUseここまで

