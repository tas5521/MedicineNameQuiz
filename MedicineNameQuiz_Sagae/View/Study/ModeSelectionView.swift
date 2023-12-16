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
    //
    @State private var questionSelectionIndex: Int = 0
    //
    @State private var modeSelection: StudyMode = .brandToGeneric
    
    // ダミーのリスト
    private var dummyQuestionNameList: [String] = ["さがえ薬局リスト", "ながつ薬局リスト", "こばやし薬局リスト"]
    
    var body: some View {
        // 手前から奥にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
            // 垂直方向にレイアウト
            VStack {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("問題リスト選択")
                        .font(.title)
                        .bold()
                    Picker("問題リスト選択", selection: $questionSelectionIndex) {
                        ForEach(dummyQuestionNameList.indices, id: \.self) { index in
                            Text(dummyQuestionNameList[index])
                        } // ForEach ここまで
                    } // Picker ここまで
                    .pickerStyle(.wheel)
                    .padding([.top, .bottom], -20)
                    Spacer()
                    Text("モード選択")
                        .font(.title)
                        .bold()
                    Picker("出題モード選択", selection: $modeSelection) {
                        ForEach(StudyMode.allCases, id: \.self) { mode in
                            Text(mode.rawValue).tag(mode)
                        } // ForEach ここまで
                    } // Picker ここまで
                    .pickerStyle(.segmented)
                    .padding()
                    Spacer()
                } // VStack ここまで
                .padding()
                // スタートボタンを配置
                Button {
                    // 学習開始
                    isStudying.toggle()
                    print(questionSelectionIndex)
                    print(modeSelection)
                } label: {
                    Text("スタート")
                        .font(.title2)
                        .frame(width: 150, height: 50)
                        .clipShape(.buttonBorder)
                        .background(Color.buttonOrange)
                        .foregroundStyle(Color.white)
                } // Button ここまで
                .padding(.bottom, 80)
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
