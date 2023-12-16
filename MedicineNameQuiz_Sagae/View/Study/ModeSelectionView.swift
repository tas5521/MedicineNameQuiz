//
//  ModeSelectionView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct ModeSelectionView: View {
    // 学習中であるかを管理する変数
    @State private var isStudying: Bool = false

    var body: some View {
        // 手前から奥にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
            // 垂直方向にレイアウト
            VStack {
                Spacer()
                // 垂直方向にレイアウト
                VStack(alignment: .leading) {
                    Text("問題リスト選択")
                    // 太字にする
                        .bold()
                    Text("モード選択")
                    // 太字にする
                        .bold()
                } // VStack ここまで
                Spacer()
                // スタートボタンを配置
                Button {
                    // 学習開始
                    isStudying.toggle()
                } label: {
                    Text("スタート")
                } // Button ここまで
                Spacer()
            } // VStack ここまで
            // 問題を解く画面へ遷移
            .navigationDestination(isPresented: $isStudying) {
                StudyView(isStudying: $isStudying)
            } // navigationDestination ここまで
        } // ZStack ここまで
    } // body ここまで
} // ModeSelectionView ここまで

#Preview {
    ModeSelectionView()
}
