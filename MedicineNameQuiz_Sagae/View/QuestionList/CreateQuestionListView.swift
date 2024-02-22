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
    @State private var listName: String = ""
    // 選択されているタブを管理する変数
    @State private var medicineClassification: MedicineClassification = .internalMedicine
    // 薬の検索に使う変数
    @State private var searchMedicineName: String = ""

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
    // リストに名前が無い時に表示するアラートを管理する変数
    @State private var isShowNoListNameAlert = false
    
    // 問題リストを作成するか編集するかを管理する変数
    let questionListMode: QuestionListMode

    var body: some View {
        // 奥から手前にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
            // セーフエリア外にも背景を表示
                .ignoresSafeArea()
            // 垂直右方向にレイアウト
            VStack(spacing: 0) {
                // 奥から手前にレイアウト
                ZStack {
                    // 背景をタブの青色にする
                    Color.tabBlue
                    // セーフエリア外にも背景を表示
                        .ignoresSafeArea()
                    // 高さを90に指定
                        .frame(height: 90)
                    // 垂直右方向にレイアウト
                    VStack(alignment: .leading) {
                        // 「リストの名前」のテキストを配置
                        Text("リストの名前")
                        // 文字色を白に指定
                            .foregroundStyle(Color.white)
                        // 左に余白を追加
                            .padding(.leading)
                        // リスト名編集用テキストフィールド
                        TextField("リストの名前を入力してください", text: $listName)
                        // テキストフィールドの背景を指定
                            .textFieldBackground()
                            .padding(.horizontal)
                    } // VStack ここまで
                } // ZStack ここまで
                // 薬の区分を選択するタブを配置
                TopTabView(selectTab: $medicineClassification)
                // 太字にする
                .bold()
                // 薬の検索バーを配置
                SearchBar(searchText: $searchMedicineName, placeholderText: "薬を検索できます")
                    .padding(.top)
                // 薬リスト
                switch medicineClassification {
                    // 内用薬を表示
                case .internalMedicine:
                    MedicineSelectableList(medicineArray: $dummyInternalMedicineList)
                    // 注射薬を表示
                case .injectionMedicine:
                    MedicineSelectableList(medicineArray: $dummyInjectionMedicineList)
                    // 外用薬を表示
                case .externalMedicine:
                    MedicineSelectableList(medicineArray: $dummyExternalMedicineList)
                    // カスタムを表示
                case .customMedicine:
                    MedicineSelectableList(medicineArray: $dummyCustomMedicineList)
                } // switch ここまで
            } // VStack ここまで
        } // ZStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("リスト\(questionListMode.rawValue)", displayMode: .inline)
        // ナビゲーションバーの背景を変更
        .navigationBarBackground()
        .toolbar {
            // ボタンの位置を指定
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if listName.isEmpty {
                        isShowNoListNameAlert.toggle()
                    } else {
                        // 保存処理
                        // 画面を閉じる
                        dismiss()
                    } // if ここまで
                } label: {
                    // ラベル
                    Text("保存")
                    // 色を指定
                        .foregroundColor(Color.white)
                } // Button ここまで
            } // ToolbarItem ここまで
        } // toolbar ここまで
        // リストの名前が無いことを警告するアラート
        .alert("リストに名前がありません", isPresented: $isShowNoListNameAlert) {
                // やめるボタン
                Button {
                    // 何もしない
                } label: {
                    // ラベル
                    Text("OK")
                } // Button ここまで
            } message: {
                Text("リストに名前をつけてください")
        } // alert ここまで
    } // body ここまで
} // CreateQuestionListView ここまで

#Preview {
    CreateQuestionListView(questionListMode: .create)
}
