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
    
    // View Presentation State
    // リストに保存するためのポップアップの表示を管理する変数
    @State private var isShowPopUp = false
    
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
                Text("薬リスト")
                Spacer()
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
