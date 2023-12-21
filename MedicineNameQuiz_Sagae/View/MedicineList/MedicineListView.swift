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
    // 薬の検索に使う変数
    @State private var medicineNameText: String = ""
    
    // ダミーの内用薬の配列
    private let dummyInternalMedicineArray: [Question] = [
        Question(originalName: "内用薬先発品名1", genericName: "内用薬一般名1"),
        Question(originalName: "内用薬先発品名2", genericName: "内用薬一般名2"),
        Question(originalName: "内用薬先発品名3", genericName: "内用薬一般名3")
    ] // dummyInternalMedicineList ここまで
    
    // ダミーの注射薬の配列
    private let dummyInjectionMedicineArray: [Question] = [
        Question(originalName: "注射薬先発品名1", genericName: "注射薬一般名1"),
        Question(originalName: "注射薬先発品名2", genericName: "注射薬一般名2"),
        Question(originalName: "注射薬先発品名3", genericName: "注射薬一般名3")
    ] // dummyInjectionMedicineList ここまで
    
    // ダミーの外用薬の配列
    private let dummyExternalMedicineArray: [Question] = [
        Question(originalName: "外用薬先発品名1", genericName: "外用薬一般名1"),
        Question(originalName: "外用薬先発品名2", genericName: "外用薬一般名2"),
        Question(originalName: "外用薬先発品名3", genericName: "外用薬一般名3")
    ] // dummyExternalMedicineList ここまで
    
    // ダミーのカスタム薬の配列
    private let dummyCustomMedicineArray: [Question] = [
        Question(originalName: "カスタム先発品名1", genericName: "カスタム一般名1"),
        Question(originalName: "カスタム先発品名2", genericName: "カスタム一般名2"),
        Question(originalName: "カスタム先発品名3", genericName: "カスタム一般名3")
    ] // dummyCustomMedicineList ここまで
    
    // 現在タブで選択されている区分を取得
    private var classification: MedicineClassification {
        MedicineClassification.allCases[tabIndex]
    } // classificationここまで
    
    var body: some View {
        // 奥から手前方向にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
            // 垂直方向にレイアウト
            VStack {
                // 薬の区分を選択するタブを上に配置
                TopTabView(
                    tabIndex: $tabIndex, tabNameList: MedicineClassification.allCases.map({classification in classification.rawValue}))
                // 薬の検索バー
                // 水平方向にレイアウト
                HStack {
                    // 虫眼鏡のImage
                    Image(systemName: "magnifyingglass")
                    // 薬の検索バー
                    TextField("薬を検索できます", text: $medicineNameText)
                        .textFieldStyle(.roundedBorder)
                } // HStack ここまで
                // 上下左右に余白を追加
                .padding()
                
                // スペースを空ける
                Spacer()
                // 薬リスト
                switch classification {
                case .internalMedicine:
                    medicineList(of: dummyInternalMedicineArray)
                case .injectionMedicine:
                    medicineList(of: dummyInjectionMedicineArray)
                case .externalMedicine:
                    medicineList(of: dummyExternalMedicineArray)
                case .customMedicine:
                    medicineList(of: dummyCustomMedicineArray)
                } // switch ここまで
            } // VStack ここまで
            .bold()
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
    
    
    private func medicineList(of medicineArray: [Question]) -> some View {
        // 出題される薬の名前のリスト
        List {
            ForEach(medicineArray.indices, id: \.self) { index in
                // 垂直方向にレイアウト
                VStack(alignment: .leading) {
                    // 先発品名を表示
                    Text(medicineArray[index].originalName)
                    // 文字の色を青に変更
                        .foregroundStyle(Color.blue)
                    // 一般名を表示
                    Text(medicineArray[index].genericName)
                    // 文字の色を赤に変更
                        .foregroundStyle(Color.red)
                } // VStack ここまで
            } // ForEach ここまで
        } // List ここまで
        // リストのスタイルを.groupedに変更
        .listStyle(.grouped)
        // リストの背景のグレーの部分を非表示にする
        .scrollContentBackground(.hidden)
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
            // ボタンの色をオレンジに指定
                .foregroundStyle(.buttonOrange)
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
