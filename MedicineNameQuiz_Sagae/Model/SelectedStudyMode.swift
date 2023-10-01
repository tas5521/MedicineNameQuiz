//
//  SelectedStudyMode.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

enum SelectedStudyMode {
    case actual
    case practice
    
    // 出題モードリスト
    static var modeList: [String] {
        ["本番", "練習"]
    }
    
    static func dicideMode(by selectedTab: Int) -> SelectedStudyMode {
        if selectedTab == 0 {
            return SelectedStudyMode.actual
        } else {
            return SelectedStudyMode.practice
        } // if ここまで
    } // dicideMode ここまで
} // SelectedStudyModeここまで
