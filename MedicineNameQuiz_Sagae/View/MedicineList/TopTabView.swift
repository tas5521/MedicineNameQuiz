//
//  TopTabView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct TopTabView: View {
    // 選択されているタブの変数
    @Binding var selectTab: MedicineCategory

    var body: some View {
        // 水平方向にレイアウト
        HStack(spacing: 0) {
            // タブに表示するリストの名前の数だけ繰り返す
            ForEach(MedicineCategory.allCases, id: \.self) { tab in
                // タブになるボタンを配置
                Button {
                    // 選択されたタブの情報を保持
                    selectTab = tab
                } label: {
                    // 各タブに名前を表示
                    Text(tab.rawValue)
                        // 選択されているタブは白に、それ以外は黒にする
                        .foregroundStyle(selectTab == tab ? Color.white : Color.black)
                } // Button ここまで
                // 画面端まで
                .frame(maxWidth: .infinity)
                // 高さ48に指定
                .frame(height: 48)
                // 重ねる
                .overlay(
                    // 長方形を配置
                    Rectangle()
                        // 高さ3に指定
                        .frame(height: 3)
                        // 選択されているタブは白に、それ以外は黒にする
                        .foregroundStyle(selectTab == tab ? Color.white : Color.clear)
                    // 下に配置
                    , alignment: .bottom
                ) // overlay ここまで
            } // ForEach ここまで
        } // HStack ここまで
        // 高さを48ポイントに指定
        .frame(height: 48)
        // 背景色は青（タブバーの色）
        .background(.tabBlue)
    } // body ここまで
} // TopTabView

#Preview {
    TopTabView(selectTab: .constant(.custom))
}
