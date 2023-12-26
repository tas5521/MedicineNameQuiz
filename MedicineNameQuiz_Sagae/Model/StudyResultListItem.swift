//
//  StudyResultListItem.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/12/17.
//

import Foundation

struct StudyResultListItem: Identifiable {
    var id: UUID = UUID()
    var brandName: String
    var genericName: String
    var studyResult: StudyResult
} // StudyResultListItem ここまで
