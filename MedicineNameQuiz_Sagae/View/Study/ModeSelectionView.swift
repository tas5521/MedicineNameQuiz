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
    // 問題を選択するために用いる番号
    @State private var questionSelectionIndex: Int = 0
    // モード選択を管理する変数
    @State private var modeSelection: StudyMode = .brandToGeneric
    // ダミーのリスト
    private var dummyQuestionNameList: [String] = ["さがえ薬局リスト", "ながつ薬局リスト", "こばやし薬局リスト"]
    
    var body: some View {
        // 手前から奥にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
            // セーフエリア外にも背景を反映
                .ignoresSafeArea()
            
            // 垂直方向にレイアウト
            VStack {
                // 垂直方向にレイアウト（Viewを右に寄せる）
                VStack(alignment: .leading) {
                    // スペースを空ける
                    Spacer()
                    
                    // 問題リストの選択を促すテキスト
                    Text("問題リスト選択")
                    // フォントを.titleに指定
                        .font(.title)
                    // 太字にする
                        .bold()
                    
                    // 問題リスト選択用のPicker
                    Picker("問題リスト選択", selection: $questionSelectionIndex) {
                        // 要素を繰り返す
                        ForEach(dummyQuestionNameList.indices, id: \.self) { index in
                            // 問題名
                            Text(dummyQuestionNameList[index])
                                .tag(index)
                        } // ForEach ここまで
                    } // Picker ここまで
                    // ホイールで表示
                    .pickerStyle(.wheel)
                    // 上下の余白を20減らす
                    .padding([.top, .bottom], -20)
                    
                    // スペースを空ける
                    Spacer()
                    
                    // モード選択を促すテキスト
                    Text("モード選択")
                    // フォントを.titleに指定
                        .font(.title)
                    // 太字にする
                        .bold()
                    
                    // 出題モード選択用のPicker
                    Picker("出題モード選択", selection: $modeSelection) {
                        // 要素を繰り返す
                        ForEach(StudyMode.allCases, id: \.self) { mode in
                            // モードの選択肢
                            Text(mode.rawValue)
                                .tag(mode)
                        } // ForEach ここまで
                    } // Picker ここまで
                    // セグメントで表示
                    .pickerStyle(.segmented)
                    // 上下左右に余白を追加
                    .padding()
                    
                    //スペースを空ける
                    Spacer()
                } // VStack ここまで
                // 上下左右に余白を追加
                .padding()
                
                // スタートボタンを配置
                Button {
                    // 学習開始
                    isStudying.toggle()
                } label: {
                    // ラベル
                    Text("スタート")
                    // フォントを.title2に指定
                        .font(.title2)
                    // 太字にする
                        .bold()
                    // 幅150高さ50に指定
                        .frame(width: 150, height: 60)
                    // 背景色をオレンジに指定
                        .background(Color.buttonOrange)
                    // 角を丸くする
                        .clipShape(.buttonBorder)
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
