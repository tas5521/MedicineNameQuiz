//
//  CreateQuestionListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct CreateQuestionListView: View {
    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // 問題リストの名前を保持する変数
    @State private var questionListName: String = ""
    // タブの選択項目を保持する変数
    @State private var tabIndex: Int = 0
    // 薬の検索に使う変数
    @State private var medicineNameText: String = ""
    
    // 内用薬の画面の「すべてチェックする」か「すべてのチェックを外す」かを管理する変数
    @State private var checkAllInternal: Bool = true
    // 注射薬の画面の「すべてチェックする」か「すべてのチェックを外す」かを管理する変数
    @State private var checkAllInjection: Bool = true
    // 外用薬の画面の「すべてチェックする」か「すべてのチェックを外す」かを管理する変数
    @State private var checkAllExternal: Bool = true
    // カスタムの画面の「すべてチェックする」か「すべてのチェックを外す」かを管理する変数
    @State private var checkAllCustom: Bool = true
    
    // ダミーの内用薬の配列
    @State private var dummyInternalMedicineList: [MedicineListItem] = [
        MedicineListItem(medicineClassification: .internalMedicine, originalName: "内用薬先発品名1", genericName: "内用薬一般名1", checked: false),
        MedicineListItem(medicineClassification: .internalMedicine, originalName: "内用薬先発品名2", genericName: "内用薬一般名2", checked: false),
        MedicineListItem(medicineClassification: .internalMedicine, originalName: "内用薬先発品名3", genericName: "内用薬一般名3", checked: false)
    ] // dummyInternalMedicineList ここまで
    
    // ダミーの注射薬の配列
    @State private var dummyInjectionMedicineList: [MedicineListItem] = [
        MedicineListItem(medicineClassification: .injectionMedicine, originalName: "注射薬先発品名1", genericName: "注射薬一般名1", checked: false),
        MedicineListItem(medicineClassification: .injectionMedicine, originalName: "注射薬先発品名2", genericName: "注射薬一般名2", checked: false),
        MedicineListItem(medicineClassification: .injectionMedicine, originalName: "注射薬先発品名3", genericName: "注射薬一般名3", checked: false)
    ] // dummyInjectionMedicineList ここまで
    
    // ダミーの外用薬の配列
    @State private var dummyExternalMedicineList: [MedicineListItem] = [
        MedicineListItem(medicineClassification: .externalMedicine, originalName: "外用薬先発品名1", genericName: "外用薬一般名1", checked: false),
        MedicineListItem(medicineClassification: .externalMedicine, originalName: "外用薬先発品名2", genericName: "外用薬一般名2", checked: false),
        MedicineListItem(medicineClassification: .externalMedicine, originalName: "外用薬先発品名3", genericName: "外用薬一般名3", checked: false)
    ] // dummyExternalMedicineList ここまで
    
    // ダミーのカスタム薬の配列
    @State private var dummyCustomMedicineList: [MedicineListItem] = [
        MedicineListItem(medicineClassification: .customMedicine, originalName: "カスタム先発品名1", genericName: "カスタム一般名1", checked: false),
        MedicineListItem(medicineClassification: .customMedicine, originalName: "カスタム先発品名2", genericName: "カスタム一般名2", checked: false),
        MedicineListItem(medicineClassification: .customMedicine, originalName: "カスタム先発品名3", genericName: "カスタム一般名3", checked: false)
    ] // dummyCustomMedicineList ここまで
        
    // View Presentation State
    // リストに保存するためのポップアップの表示を管理する変数
    @State private var isShowPopUp = false
    
    // 現在タブで選択されている区分を取得
    private var classification: MedicineClassification {
        MedicineClassification.allCases[tabIndex]
    } // classificationここまで

    
    var body: some View {
        ZStack {
            // 背景を水色に変更
            Color.backgroundSkyBlue
            // セーフエリア外にも背景を表示
                .ignoresSafeArea()
            // 垂直方向にレイアウト
            VStack {
                // 薬の区分を選択するタブを上に配置
                TopTabView(
                    tabIndex: $tabIndex, tabNameList: MedicineClassification.allCases.map({classification in classification.rawValue}))
                // 薬を検索するためのテキストフィールド
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
                Spacer()
                // 薬のリスト
                // 薬リスト
                switch classification {
                case .internalMedicine:
                    MedicineSelectableList(checkAll: $checkAllInternal, medicineArray: $dummyInternalMedicineList)
                case .injectionMedicine:
                    MedicineSelectableList(checkAll: $checkAllInjection, medicineArray: $dummyInjectionMedicineList)
                case .externalMedicine:
                    MedicineSelectableList(checkAll: $checkAllExternal, medicineArray: $dummyExternalMedicineList)
                case .customMedicine:
                    MedicineSelectableList(checkAll: $checkAllCustom, medicineArray: $dummyCustomMedicineList)
                } // switch ここまで
            } // VStack ここまで
            .bold()
        } // ZStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("リスト作成", displayMode: .inline)
        // ナビゲーションバーの背景を青色に変更
        .toolbarBackground(.navigationBarBlue, for: .navigationBar)
        // ナビゲーションバーの背景を表示
        .toolbarBackground(.visible, for: .navigationBar)
        // ナビゲーションバーのタイトルの色を白にする
        .toolbarColorScheme(.dark)
        // ナビゲーションバーの右側に保存ボタンを配置
        .toolbar {
            // ボタンの位置を指定
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // アラートを表示
                    isShowPopUp.toggle()
                } label: {
                    // ラベル
                    Text("保存")
                    // 色を指定
                        .foregroundStyle(Color.white)
                } // Button ここまで
            } // ToolbarItem ここまで
        } // toolbar ここまで
        // リストに保存するためのポップアップ
        .alert("リストに保存", isPresented: $isShowPopUp) {
            // リスト名を取得するためのテキストフィールド
            TextField("リストの名前", text: $questionListName)
            // 名前が付けられたリストを保存するボタン
            Button {
                // 問題リストの作成処理
                // 画面を閉じる
                dismiss()
            } label: {
                // ラベル
                Text("保存")
            } // Button ここまで
            // やめるボタン
            Button(role: .cancel) {
                // 何もしない
            } label: {
                // ラベル
                Text("やめる")
            } // Button ここまで
        } message: {
            Text("リストに名前をつけてください")
        } // alert ここまで
    } // body ここまで
} // CreateQuestionListView ここまで

#Preview {
    CreateQuestionListView()
}
