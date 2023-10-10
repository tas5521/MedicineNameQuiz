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
    @State private var selectedTabIndex: Int = 0

    var body: some View {
        // 垂直右方向にレイアウト
        VStack {
            // タブを上に配置
            topTabView
            // リスト名編集用テキストフィールド
            listNameEditTextField
            // 薬を検索するためのテキストフィールド
            medicineSearchBar
            Spacer()
            // 薬リスト
            medicineListView
            Spacer()
        } // VStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("問題リスト", displayMode: .inline)
        // ナビゲーションバーの左側にカスタムの戻るボタンを配置
        .backButton {
            // 戻るボタンの処理
            // 画面を閉じる
            dismiss()
        } // placeCustomBackButton ここまで
        // ナビゲーションバーの右側にカスタムの保存ボタンを配置
        .buttonTrailing(label: "保存") {
            // 保存処理
            // 画面を閉じる
            dismiss()
        } // placeCustomNavigationLinkTrailing ここまで
    } // body ここまで
    
    // 上部につけるタブ
    private var topTabView: some View {
        TopTabView(tabNameList: SelectedClassification.classificationList, selectedTabIndex: $selectedTabIndex)
    } // topTabView ここまで
    
    // リスト名編集用テキストフィールド
    private var listNameEditTextField: some View {
        Text("リスト名編集用テキストフィールド")
    } // textFieldToEdit ここまで
    
    // 薬を検索するためのテキストフィールド
    private var medicineSearchBar: some View {
        Text("薬の検索バー")
    } // textFieldToSearchMedicine ここまで

    // 薬のリスト
    private var medicineListView: some View {
        Text("薬リスト")
    } // medicineList ここまで
} // EditQuestionListViewここまで

#Preview {
    EditQuestionListView()
}
