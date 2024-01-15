//
//  TopTabView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct TopTabView: View {

    @Binding var selectTab: MedicineClassification

    var body: some View {
        // 水平方向にレイアウト
        HStack(spacing: 0) {
            // タブに表示するリストの名前の数だけ繰り返す
            ForEach(MedicineClassification.allCases, id: \.self) { tab in
                // タブになるボタンを配置
                Button {
                    // 選択されたタブの情報を保持
                    selectTab = tab
                } label: {
                    // 各タブに名前を表示
                    Text(tab.rawValue)
                    // 選択されているタブは白に、それ以外は黒にする
                        .foregroundColor(selectTab == tab ? Color.white : Color.black)
                } // Button ここまで
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .overlay(
                    Rectangle()
                        .frame(height: 3)
                        .foregroundColor(selectTab == tab ? Color.white : Color.clear), alignment: .bottom
                )
            } // ForEach ここまで
        } // HStack ここまで
        // 高さを48ポイントに指定
        .frame(height: 48)
        // 背景色は青（タブバーの色）
        .background(.tabBlue)
    } // body ここまで
} // TopTabView

#Preview {
    TopTabView(selectTab: .constant(.customMedicine))
}
