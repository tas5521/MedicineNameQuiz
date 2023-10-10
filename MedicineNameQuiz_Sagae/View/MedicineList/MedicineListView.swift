//
//  MedicineListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct MedicineListView: View {
    // タブの選択項目を保持する変数
    @State private var selectedTab: Int = 0
    // シートの表示を管理する変数
    @State private var isShowSheet: Bool = false
    // 選択された区分を管理する変数
    private var selectedClassification: SelectedClassification {
        SelectedClassification.classify(by: selectedTab)
    } // selectedClassification ここまで
    
    var body: some View {
        // 奥から手前方向にレイアウト
        ZStack {
            // 垂直方向にレイアウト
            VStack {
                // タブを上に配置
                toptTabView
                // 薬名を検索するためのテキストフィールド
                textFieldToSearchMedicine
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
                    if selectedClassification == .customMedicine {
                        buttonToAddMedicine
                            .padding()
                    } // if ここまで
                } // HStack ここまで
            } // VStack ここまで
        } // ZStack ここまで
    } // body ここまで
    
    private var toptTabView: some View {
        TopTabView(tabNameList: SelectedClassification.classificationList, selectedTab: $selectedTab)
    } // toptTabView ここまで
    
    private var textFieldToSearchMedicine: some View {
        Text("検索バー")
    } // textFieldToSearchMedicine ここまで
    
    private var medicineList: some View {
        Text("薬リスト")
    } // medicineList ここまで
    
    // buttonToAddMedicineここまで
    private var buttonToAddMedicine: some View {
        Button {
            // シートを表示
            isShowSheet.toggle()
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
                .foregroundStyle(Color.customButtonColor)
            // 背景を白に指定
                .background(Color.white)
            // 丸くクリッピング
                .clipShape(Circle())
        } // Button ここまで
        // 薬名追加ビューのシート
        .sheet(isPresented: $isShowSheet) {
            AddMedicineView()
        }  // sheet ここまで
    } // buttonToAddMedicine
} // MedicineListView ここまで

#Preview {
    MedicineListView()
}
