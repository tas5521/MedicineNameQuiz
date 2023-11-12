//
//  HowToUseStudyView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct HowToUseStudyView: View {
    // 項目のタイトル
    let title: String

    var body: some View {
        Text("HowToUseStudyView")
        // ナビゲーションバータイトルを指定
        .navigationBarTitle(title, displayMode: .inline)
    } // bodyここまで
} // HowToUseStudyView ここまで

#Preview {
    HowToUseStudyView(title: "アプリの使い方-学習-")
}
