//
//  RankingView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct RankingView: View {
    var body: some View {
        // 水平方向にレイアウト
        VStack {
            // 出題モード選択Picker
            Text("出題モード")
            // 区分選択Picker
            Text("区分")
            // ランキングを表示するためのリスト
            Text("ランキング")
        } // VStack ここまで
    } // body ここまで
} // RankingView ここまで

#Preview {
    RankingView()
}
