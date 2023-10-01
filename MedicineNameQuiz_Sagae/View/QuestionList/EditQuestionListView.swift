//
//  EditQuestionListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct EditQuestionListView: View {
    @Environment(\.presentationMode) var presentation
    // タブの選択項目を保持する変数
    @State private var selectedTab: Int = 0

    var body: some View {
        VStack {
            TopTabView(tabNameList: SelectedClassification.classificationList, selectedTab: $selectedTab)
            Text("リスト名編集用テキストフィールド")
            Text("検索バー")
            Spacer()
            Text("薬リスト")
            Spacer()
        } // VStack ここまで
        // ナビゲーションバーにタイトルを表示
        .navigationBarTitle("問題リスト", displayMode: .inline)
        // デフォルトの戻るボタンを隠す
        .navigationBarBackButtonHidden(true)
        // ツールバー設定
        .toolbar {
            // カスタムの戻るボタンを左に配置
            ToolbarItem(placement: .navigationBarLeading) {
                // 戻るボタン
                Button {
                    // 前の画面に戻る
                    presentation.wrappedValue.dismiss()
                } label: {
                    // 水平方向に配置
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("戻る")
                    } // HStack ここまで
                } // Button ここまで
                .foregroundColor(Color.white)
            } // 戻るボタン ここまで
            // 編集画面に遷移するボタンを右に配置
            ToolbarItem(placement: .navigationBarTrailing) {
                // 編集ボタン
                Button {
                    
                } label: {
                    Text("編集")
                } // Button ここまで
                .foregroundColor(Color.white)
            } // 編集ボタン ここまで
        } // toolbar ここまで
    } // body ここまで
} // EditQuestionListViewここまで

#Preview {
    EditQuestionListView()
}
