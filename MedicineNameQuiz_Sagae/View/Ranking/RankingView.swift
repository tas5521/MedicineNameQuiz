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
            modePicker
            // 区分選択Picker
            classificationPicker
            // ランキングを表示するためのリスト
            rankingList
        } // VStack ここまで
    } // body ここまで

    // 出題モード選択Picker
    private var modePicker: some View {
        Text("出題モード")
    } // modePicker ここまで
    
    // 区分選択Picker
    private var classificationPicker: some View {
        Text("区分")
    } // classificationPicker ここまで
    
    // ランキングを表示するためのリスト
    private var rankingList: some View {
        Text("ランキング")
    } // rankingList ここまで
} // RankingView ここまで

#Preview {
    RankingView()
}
