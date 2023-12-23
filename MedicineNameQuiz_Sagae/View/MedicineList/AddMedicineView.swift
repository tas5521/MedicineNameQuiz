//
//  AddMedicineView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct AddMedicineView: View {
    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // 入力された先発品名を管理する変数
    @State private var brandNameText: String = ""
    
    
    var body: some View {
        // 奥から手前にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
            // セーフエリア外にも背景を表示
                .ignoresSafeArea()
            // 垂直方向にレイアウト
            VStack {
                // 追加する薬の名前を入力するようユーザーに促すためのテキスト
                Text("追加する薬の名前を入力してください")
                    .padding()
                // 先発品名を入力するためのテキストフィールド
                TextField("先発品名", text: $brandNameText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                // 一般名を入力するためのテキストフィールド
                Text("一般名")
                    .padding()
                // 追加ボタン
                Button {
                    // 薬の名前をカスタムに追加する処理
                    dismiss()
                } label: {
                    // ラベル
                    Text("追加")
                } // Button ここまで
                    .padding()
                // やめるボタン
                Button {
                    // シートを閉じる
                    dismiss()
                } label: {
                    // ラベル
                    Text("やめる")
                } // Button ここまで
                    .padding()
            } // VStack ここまで
        } // ZStack ここまで
    } // body ここまで
} // AddMedicineView ここまで

#Preview {
    AddMedicineView()
}
