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
    @State private var selectedTab: Int = 0
    // 警告の表示を管理する変数
    @State private var isShowAlert = false
    
    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // タブを上に配置
            topTabView
            Spacer()
            // 薬を検索するためのテキストフィールド
            textFieldToSearchMedicine
            Spacer()
            // 薬のリスト
            medicineList
            Spacer()
        } // VStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("問題リスト", displayMode: .inline)
        // ナビゲーションバーの左側にカスタムの戻るボタンを配置
        .placeCustomBackButton {
            // 戻るボタンの処理
            // 画面を閉じる
            dismiss()
        } // placeCustomBackButton ここまで
        // ナビゲーションバーの右側にカスタムの保存ボタンを配置
        .placeCustomButtonTrailing(label: "保存") {
            // アラートを表示
            isShowAlert.toggle()
        } // placeCustomNavigationLinkTrailing ここまで
        // リストに保存するためのアラート
        .alert("リストに保存", isPresented: $isShowAlert) {
            textFieldToGetListName
            buttonToSaveNamedList
            cancelButton
        } message: {
            Text("リストに名前をつけてください")
        } // alert ここまで
    } // body ここまで

    // 上部につけるタブ
    private var topTabView: some View {
        TopTabView(tabNameList: SelectedClassification.classificationList, selectedTab: $selectedTab)
    } // topTabView ここまで
    
    // 薬を検索するためのテキストフィールド
    private var textFieldToSearchMedicine: some View {
        Text("薬の検索バー")
    } // textFieldToSearchMedicine ここまで

    // 薬のリスト
    private var medicineList: some View {
        Text("薬リスト")
    } // medicineList ここまで
    
    // リスト名を取得するためのテキストフィールド
    private var textFieldToGetListName: some View {
        // リストの名前を取得するためのテキストフィールド
        TextField("リストの名前", text: $questionListName)
    } // textFieldToGetListName ここまで
    
    // 名前が付けられたリストを保存するボタン
    private var buttonToSaveNamedList: some View {
        Button {
            // 問題リストの作成処理
            // 画面を閉じる
            dismiss()
        } label: {
            // ラベル
            Text("保存")
        } // Button ここまで
    } // buttonToSaveNamedList ここまで
    
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
