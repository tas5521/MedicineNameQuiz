//
//  StudyMode.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

enum StudyMode: String {
    case actual = "本番"
    case practice = "練習"
    
    // すべてのケース
    static let allCases: [StudyMode] = [.actual, .practice]
} // StudyModeここまで
