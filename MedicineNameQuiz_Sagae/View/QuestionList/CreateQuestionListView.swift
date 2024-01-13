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
    @State private var searchMedicineNameText: String = ""
    
    // ダミーの内用薬の配列
    @State private var dummyInternalMedicineList: [MedicineListItem] = [
        MedicineListItem(originalName: "内用薬先発品名1", genericName: "内用薬一般名1", selected: false),
        MedicineListItem(originalName: "内用薬先発品名2", genericName: "内用薬一般名2", selected: false),
        MedicineListItem(originalName: "内用薬先発品名3", genericName: "内用薬一般名3", selected: false)
    ] // dummyInternalMedicineList ここまで
    
    // ダミーの注射薬の配列
    @State private var dummyInjectionMedicineList: [MedicineListItem] = [
        MedicineListItem(originalName: "注射薬先発品名1", genericName: "注射薬一般名1", selected: false),
        MedicineListItem(originalName: "注射薬先発品名2", genericName: "注射薬一般名2", selected: false),
        MedicineListItem(originalName: "注射薬先発品名3", genericName: "注射薬一般名3", selected: false)
    ] // dummyInjectionMedicineList ここまで
    
    // ダミーの外用薬の配列
    @State private var dummyExternalMedicineList: [MedicineListItem] = [
        MedicineListItem(originalName: "外用薬先発品名1", genericName: "外用薬一般名1", selected: false),
        MedicineListItem(originalName: "外用薬先発品名2", genericName: "外用薬一般名2", selected: false),
        MedicineListItem(originalName: "外用薬先発品名3", genericName: "外用薬一般名3", selected: false)
    ] // dummyExternalMedicineList ここまで
    
    // ダミーのカスタム薬の配列
    @State private var dummyCustomMedicineList: [MedicineListItem] = [
        MedicineListItem(originalName: "カスタム先発品名1", genericName: "カスタム一般名1", selected: false),
        MedicineListItem(originalName: "カスタム先発品名2", genericName: "カスタム一般名2", selected: false),
        MedicineListItem(originalName: "カスタム先発品名3", genericName: "カスタム一般名3", selected: false)
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
                    tabIndex: $tabIndex, 
                    tabNameList: MedicineClassification.allCases.map({classification in classification.rawValue}))
                // 太字にする
                .bold()
                // 薬の検索バー
                SearchBar(searchText: $searchMedicineNameText, placeholderText: "薬を検索できます")
                // 上に余白を追加
                    .padding(.top)
                // 薬リスト
                switch classification {
                case .internalMedicine:
                    MedicineSelectableList(medicineArray: $dummyInternalMedicineList)
                case .injectionMedicine:
                    MedicineSelectableList(medicineArray: $dummyInjectionMedicineList)
                case .externalMedicine:
                    MedicineSelectableList(medicineArray: $dummyExternalMedicineList)
                case .customMedicine:
                    MedicineSelectableList(medicineArray: $dummyCustomMedicineList)
                } // switch ここまで
            } // VStack ここまで
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
