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
    
    var body: some View {
        // 追加する薬の名前を入力するようユーザーに促すためのテキスト
        Text("追加する薬の名前を入力してください")
            .padding()
        // 先発品名を入力するためのテキストフィールド
        Text("先発品名")
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
    } // body ここまで
} // AddMedicineView ここまで

#Preview {
    AddMedicineView()
}
