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
    @State var listName: String = "さがえ薬局リスト"
    
    var body: some View {
        // 奥から手前にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
            // セーフエリア外にも背景を表示
                .ignoresSafeArea()
            // 垂直右方向にレイアウト
            VStack {
                // 薬の区分を選択するタブを配置
                TopTabView(
                    tabIndex: $tabIndex, tabNameList: MedicineClassification.allCases.map({classification in classification.rawValue}))
                // リスト名編集用テキストフィールド
                TextField("リストの名前を入力してください", text: $listName)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                // 薬を検索バー
                Text("薬の検索バー")
                Spacer()
                // 薬リスト
                Text("薬リスト")
                Spacer()
            } // VStack ここまで
        } // ZStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("リスト編集", displayMode: .inline)
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
    EditQuestionListView(listName: "さがえ薬局リスト")
}
