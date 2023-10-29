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

    // View Presentation State
    // リストに保存するためのポップアップの表示を管理する変数
    @State private var isShowPopUp = false

    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // 薬の区分を選択するタブを上に配置
            classificationTab
            Spacer()
            // 薬を検索するためのテキストフィールド
            searchMedicineTextField
            Spacer()
            // 薬のリスト
            medicineList
            Spacer()
        } // VStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("リスト作成", displayMode: .inline)
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
                        .foregroundColor(Color.black)
                } // Button ここまで
            } // ToolbarItem ここまで
        } // toolbar ここまで
        // リストに保存するためのポップアップ
        .alert("リストに保存", isPresented: $isShowPopUp) {
            // リスト名を取得するためのテキストフィールド
            listNameTextField
            // 名前が付けられたリストを保存するボタン
            saveButton
            // やめるボタン
            cancelButton
        } message: {
            Text("リストに名前をつけてください")
        } // alert ここまで
    } // body ここまで

    // 薬の区分を選択するタブ
    private var classificationTab: some View {
        // 薬の区分の配列を取得
        let classificationArray = MedicineClassification.allCases.map({classification in classification.rawValue})
        // 薬の区分を選択するタブを返す
        return TopTabView(tabNameList: classificationArray, tabIndex: $tabIndex)
    } // classificationTab ここまで

    // 薬を検索するためのテキストフィールド
    private var searchMedicineTextField: some View {
        Text("薬の検索バー")
    } // searchMedicineTextField ここまで

    // 薬のリスト
    private var medicineList: some View {
        Text("薬リスト")
    } // medicineList ここまで

    // リスト名を取得するためのテキストフィールド
    private var listNameTextField: some View {
        // リストの名前を取得するためのテキストフィールド
        TextField("リストの名前", text: $questionListName)
    } // listNameTextField ここまで

    // 名前が付けられたリストを保存するボタン
    private var saveButton: some View {
        Button {
            // 問題リストの作成処理
            // 画面を閉じる
            dismiss()
        } label: {
            // ラベル
            Text("保存")
        } // Button ここまで
    } // saveButton ここまで

    // やめるボタン
    private var cancelButton: some View {
        Button(role: .cancel) {
            // 何もしない
        } label: {
            // ラベル
            Text("やめる")
        } // Button ここまで
    } // cancelButton ここまで
} // CreateQuestionListView ここまで

#Preview {
    CreateQuestionListView()
}
