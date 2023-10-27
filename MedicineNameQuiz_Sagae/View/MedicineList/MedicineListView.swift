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
    // タブで選択された薬の区分を管理する変数
    private var classification: MedicineClassification {
        MedicineClassification.classify(by: tabIndex)
    } // classification ここまで

    var body: some View {
        // 奥から手前方向にレイアウト
        ZStack {
            // 垂直方向にレイアウト
            VStack {
                // 薬の区分を選択するタブを上に配置
                classificationTab
                // 薬の検索バー
                medicineSearchBar
                // スペースを空ける
                Spacer()
                // 薬リスト
                medicineList
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

    // 薬の区分を選択するタブ
    private var classificationTab: some View {
        TopTabView(tabNameList: MedicineClassification.classificationList, tabIndex: $tabIndex)
    } // classificationTab ここまで

    // 薬の検索バー
    private var medicineSearchBar: some View {
        Text("検索バー")
    } // medicineSearchBar ここまで

    // 薬リスト
    private var medicineList: some View {
        Text("薬リスト")
    } // medicineList ここまで

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
                .foregroundStyle(Color.regularButtonColor)
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
