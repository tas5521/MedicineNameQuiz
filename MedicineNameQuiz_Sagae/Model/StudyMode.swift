//
//  StudyMode.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

enum StudyMode {
    case actual
    case practice
    
    // 出題モードリスト
    static var modeList: [String] {
        ["本番", "練習"]
    } // modeList ここまで
    
    static func dicideMode(by selectedTab: Int) -> StudyMode {
        if selectedTab == 0 {
            return StudyMode.actual
        } else {
            return StudyMode.practice
        } // if ここまで
    } // dicideMode ここまで
} // StudyModeここまで
