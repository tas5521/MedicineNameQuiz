//
//  EditQuestionListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct EditQuestionListView: View {
    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // タブの選択項目を保持する変数
    @State private var tabIndex: Int = 0
    // リスト名
    @State private var listName: String = "さがえ薬局リスト"
    // 薬の検索に使う変数
    @State private var medicineNameText: String = ""

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
    
    // 現在タブで選択されている区分を取得
    private var classification: MedicineClassification {
        MedicineClassification.allCases[tabIndex]
    } // classificationここまで
    
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
                        // 文字の左に余白を追加
                            .padding(.leading, 6)
                        // 背景色を指定
                            .background(
                                // 背景を角の丸い四角にする
                                RoundedRectangle(cornerRadius: 8)
                                // 背景色を変更
                                    .fill(Color(red: 237/255, green: 237/255, blue: 237/255))
                                // 高さを36に指定
                                    .frame(height: 36))
                        // 上下左右に余白をつける
                            .padding(.horizontal)
                    } // VStack ここまで
                } // ZStack ここまで
                // 薬の区分を選択するタブを配置
                TopTabView(
                    tabIndex: $tabIndex, tabNameList: MedicineClassification.allCases.map({classification in classification.rawValue}))
                // 太字にする
                .bold()
                // 薬の検索バーを配置
                SearchBar(searchText: $medicineNameText, placeholderText: "薬を検索できます")
                    .padding(.top)
                // 薬リスト
                switch classification {
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
        .navigationBarTitle("リスト編集", displayMode: .inline)
        // ナビゲーションバーの背景を変更
        .navigationBarBackground()
        .toolbar {
            // ボタンの位置を指定
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // 保存処理
                    // 画面を閉じる
                    dismiss()
                } label: {
                    // ラベル
                    Text("保存")
                    // 色を指定
                        .foregroundColor(Color.white)
                } // Button ここまで
            } // ToolbarItem ここまで
        } // toolbar ここまで
    } // body ここまで
} // EditQuestionListViewここまで

#Preview {
    EditQuestionListView()
}
