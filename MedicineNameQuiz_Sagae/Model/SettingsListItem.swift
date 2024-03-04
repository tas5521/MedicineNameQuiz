//
//  SettingsListItem.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

// 本アプリの第1回目のリリース目標として、ランキング機能なしで学習のみできるアプリを作成することとなりました。
// そのため、第一段階のアプリ作成の間は、ランキング機能に関連するコードをコメントアウトします。

import Foundation

enum SettingsListItem: String, CaseIterable {
    case howToUse = "アプリの使い方"
    case reference = "医薬品名の引用元"
    case advertisement = "広告の表示について"
    // ランキング機能が無ければ、AccountViewは使用しないので、コメントアウト
    // case account = "アカウント"
} // SettingsListItem ここまで
