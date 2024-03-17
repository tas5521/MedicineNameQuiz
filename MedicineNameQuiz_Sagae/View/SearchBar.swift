//
//  SearchBar.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/12/28.
//

import SwiftUI

struct SearchBar: View {
    // 検索するテキストを管理する変数
    @Binding var searchText: String
    // Placeholderを管理する変数
    let placeholderText: String

    var body: some View {
        // 奥から手前にレイアウト
        ZStack {
            // 背景
            RoundedRectangle(cornerRadius: 8)
                // 背景色を指定
                .fill(Color.white)
                // 高さを36に指定
                .frame(height: 36)

            // 水平方向にレイアウト
            HStack(spacing: 6) {
                // スペースを空ける
                Spacer()
                    // 幅を0に指定
                    .frame(width: 0)

                // 虫メガネ
                Image(systemName: "magnifyingglass")
                    // 色をグレーに指定
                    .foregroundStyle(Color.gray)

                // テキストフィールド
                TextField(placeholderText, text: $searchText)

                // 検索文字が空ではない場合は、クリアボタンを表示
                if !searchText.isEmpty {
                    // クリアボタン
                    Button {
                        // 検索するテキストを空にする
                        searchText.removeAll()
                    } label: {
                        // ラベル
                        Image(systemName: "xmark.circle.fill")
                            // 色をグレーにする
                            .foregroundStyle(.gray)
                    } // Button ここまで
                    // 右に余白を指定
                    .padding(.trailing, 6)
                } // if ここまで
            } // HStack ここまで
        } // ZStack ここまで
        // 左右に余白を指定
        .padding(.horizontal)
    } // body ここまで
} // SearchBar ここまで

#Preview {
    SearchBar(searchText: .constant(""), placeholderText: "薬を検索できます")
}
