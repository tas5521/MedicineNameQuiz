//
//  AdvertisementView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct AdvertisementView: View {
    // 項目のタイトル
    let title: String

    var body: some View {
        Text("Advertisement")
        // ナビゲーションバータイトルを指定
        .navigationBarTitle(title, displayMode: .inline)
    } // body ここまで
} // AdvertisementView ここまで

#Preview {
    AdvertisementView(title: "広告の表示について")
}
