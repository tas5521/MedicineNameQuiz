//
//  MedicineListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct MedicineListView: View {
    // タブの選択項目を保持する変数
    @State private var tabIndex: Int = 0
    // 薬名追加ビューの表示を管理する変数
    @State private var isShowAddMedicineView: Bool = false
    // 現在タブで選択されている区分を取得
    private var classification: MedicineClassification {
        MedicineClassification.allCases[tabIndex]
    } // classificationここまで
    
    var body: some View {
        // 奥から手前方向にレイアウト
        ZStack {
            // 垂直方向にレイアウト
            VStack {
                // 薬の区分を選択するタブを上に配置
                TopTabView(tabNameList: MedicineClassification.allCases.map({classification in
                    classification.rawValue}), tabIndex: $tabIndex)
                // 薬の検索バー
                Text("検索バー")
                // スペースを空ける
                Spacer()
                // 薬リスト
                Text("薬リスト")
                // スペースを空ける
                Spacer()
            } // VStack ここまで
            // 垂直方向にレイアウト
            VStack {
                // スペースを空ける
                Spacer()
                // 水平方向にレイアウト
                HStack {
                    // スペースを空ける
                    Spacer()
                    // カスタムのタブが選択されている場合、薬名追加ボタンを表示
                    if classification == .customMedicine {
                        addMedicineButton
                            .padding()
                    } // if ここまで
                } // HStack ここまで
            } // VStack ここまで
        } // ZStack ここまで
    } // body ここまで

    // カスタムで薬名を追加するボタン
    private var addMedicineButton: some View {
        Button {
            // 薬名追加ビューを表示
            isShowAddMedicineView.toggle()
        } label: {
            // ラベル
            Image(systemName: "plus.circle.fill")
            // リサイズする
                .resizable()
            // アスペクト比を保ったまま枠いっぱいに表示
                .scaledToFit()
            // 幅高さ65に指定
                .frame(width: 65, height: 65)
            // 色をカスタムのボタンの色に指定
                .foregroundStyle(Color.orangeButtonColor)
            // 背景を白に指定
                .background(Color.white)
            // 丸くクリッピング
                .clipShape(Circle())
        } // Button ここまで
        // 薬名追加ビューのシート
        .sheet(isPresented: $isShowAddMedicineView) {
            AddMedicineView()
        }  // sheet ここまで
    } // addMedicineButton ここまで
} // MedicineListView ここまで

#Preview {
    MedicineListView()
}
