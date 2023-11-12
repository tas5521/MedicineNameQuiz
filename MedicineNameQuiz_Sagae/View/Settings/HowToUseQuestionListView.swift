//
//  HowToUseQuestionListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct HowToUseQuestionListView: View {
    // 項目のタイトル
    let title: String

    var body: some View {
        Text("HowToUseQuestionListView")
        // ナビゲーションバータイトルを指定
        .navigationBarTitle(title, displayMode: .inline)
    } // bodyここまで
} // HowToUseQuestionListView ここまで

#Preview {
    HowToUseQuestionListView(title: "アプリの使い方-問題リスト-")
}
