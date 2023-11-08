//
//  TopTabView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct TopTabView: View {
    // タブに表示する名前のリスト
    let tabNameList: [String]
    // 選択されているタブの変数
    @Binding var tabIndex: Int
    
    var body: some View {
        // 水平方向にレイアウト
        HStack(spacing: 0) {
            // タブに表示するリストの名前の数だけ繰り返す
            ForEach(0 ..< tabNameList.count, id: \.self) { row in
                // タブになるボタンを配置
                Button {
                    // 選択されたタブの情報を保持
                    tabIndex = row
                } label: {
                    // 垂直方向にレイアウト
                    VStack(spacing: 0) {
                        // 水平方向にレイアウト
                        HStack {
                            // 各タブに名前を表示
                            Text(tabNameList[row])
                            // 選択されているタブは白に、それ以外は黒にする
                                .foregroundColor(tabIndex == row ? Color.white : Color.black)
                        }
                        // 幅は画面の横幅 / タブの個数
                        .frame(width: UIScreen.main.bounds.width / CGFloat(tabNameList.count), height: 42)
                        // 選択されているタブの下に白いバーを配置
                        Rectangle()
                        // 選択されているタブでは白く塗りつぶす、それ以外は透明
                            .fill(tabIndex == row ? Color.white : Color.clear)
                        // 高さは6ポイント
                            .frame(height: 6)
                    } // VStack ここまで
                } // Button ここまで
            } // ForEach ここまで
        } // HStack ここまで
        // 高さを48ポイントに指定
        .frame(height: 48)
        // 背景色は青（タブバーの色）
        .background(.tabBlue)
    } // body ここまで
} // TopTabView

#Preview {
    TopTabView(tabNameList: ["本番", "練習"], tabIndex: .constant(0))
}
