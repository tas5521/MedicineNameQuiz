//
//  SelectedClassification.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import Foundation

enum SelectedClassification: String {
    case internalMedicine
    case injectionMedicine
    case externalMedicine
    case customMedicine
    
    // 薬の区分のリスト
    static var classificationList: [String] {
        ["内用薬", "注射薬", "外用薬", "カスタム"]
    } // classificationList ここまで
    
    static func classify(by selectedTab: Int) -> SelectedClassification {
        switch selectedTab {
        case 0 :
                .internalMedicine
        case 1 :
                .injectionMedicine
        case 2 :
                .externalMedicine
        default:
                .customMedicine
        } // switchここまで
    } // classify ここまで
} // SelectedClassificationここまで
