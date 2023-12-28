//
//  SearchBar.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/12/28.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    let placeholder: String
    
    var body: some View {
        // 奥から手前にレイアウト
        ZStack {
            // 背景
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(red: 239 / 255,
                            green: 239 / 255,
                            blue: 241 / 255))
                .frame(height: 36)
            
            HStack(spacing: 6) {
                Spacer()
                    .frame(width: 0)
                
                // 虫メガネ
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.gray)
                
                // テキストフィールド
                TextField(placeholder, text: $searchText)
                
                // 検索文字が空ではない場合は、クリアボタンを表示
                if !searchText.isEmpty {
                    Button {
                        searchText.removeAll()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray)
                    } // Button ここまで
                    .padding(.trailing, 6)
                } // if ここまで
            } // HStack ここまで
        } // ZStack ここまで
        .padding(.horizontal)
    } // body ここまで
} // SearchBar ここまで

#Preview {
    SearchBar(searchText: .constant(""), placeholder: "薬を検索できます")
}
