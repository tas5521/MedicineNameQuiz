//
//  ModeSelectionViewModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/03/22.
//

import Foundation

@Observable
final class ModeSelectionViewModel {
    // 問題を選択するために用いる番号
    var questionIndex: Int = 0
    // モード選択を管理する変数
    var modeSelection: StudyMode = .brandToGeneric
    // ダミーのリスト
    var dummyQuestionNameList: [String] = ["さがえ薬局リスト", "ながつ薬局リスト", "こばやし薬局リスト"]
} // ModeSelectionViewModel ここまで
