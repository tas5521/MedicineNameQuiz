//
//  ReferenceView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct ReferenceView: View {
    // 項目のタイトル
    let title: String

    var body: some View {
        Text("Reference")
        // ナビゲーションバータイトルを指定
        .navigationBarTitle(title, displayMode: .inline)
    } // body ここまで
} // ReferenceView ここまで

#Preview {
    ReferenceView(title: "医薬品名の引用元")
}
