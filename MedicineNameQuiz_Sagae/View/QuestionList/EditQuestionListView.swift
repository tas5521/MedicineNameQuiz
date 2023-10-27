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

    var body: some View {
        // 垂直右方向にレイアウト
        VStack {
            // 薬の区分を選択するタブを配置
            classificationTab
            // リスト名編集用テキストフィールド
            listNameEditTextField
            // 薬を検索するためのテキストフィールド
            medicineSearchBar
            Spacer()
            // 薬リスト
            medicineList
            Spacer()
        } // VStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("問題リスト", displayMode: .inline)
        // ナビゲーションバーの左側に戻るボタンを配置
        .navigationBarWithBackButton {
            // 戻るボタンの処理
            // 画面を閉じる
            dismiss()
        } // navigationBarWithBackButton ここまで
        // ナビゲーションバーの右側に保存ボタンを配置
        .navigationBarWithButtonTrailing(label: "保存") {
            // 保存処理
            // 画面を閉じる
            dismiss()
        } // navigationBarWithButtonTrailing ここまで
    } // body ここまで
    
    // 薬の区分を選択するタブ
    private var classificationTab: some View {
        // 薬の区分の配列を取得
        let classificationArray = MedicineClassification.allValues.map({classification in classification.rawValue})
        // 薬の区分を選択するタブを返す
        return TopTabView(tabNameList: classificationArray, tabIndex: $tabIndex)
    } // classificationTab ここまで
    
    // リスト名編集用テキストフィールド
    private var listNameEditTextField: some View {
        Text("リスト名編集用テキストフィールド")
    } // listNameEditTextField ここまで
    
    // 薬を検索するためのテキストフィールド
    private var medicineSearchBar: some View {
        Text("薬の検索バー")
    } // medicineSearchBar ここまで

    // 薬のリスト
    private var medicineList: some View {
        Text("薬リスト")
    } // medicineList ここまで
} // EditQuestionListViewここまで

#Preview {
    EditQuestionListView()
}
