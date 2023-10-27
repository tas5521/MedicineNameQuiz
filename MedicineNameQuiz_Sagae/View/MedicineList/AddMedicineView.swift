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
        enterMedicineNameText
            .padding()
        // 先発品名を入力するためのテキストフィールド
        originalMedicineTextField
            .padding()
        // 一般名を入力するためのテキストフィールド
        genericMedicineTextField
            .padding()
        // 追加ボタン
        addButton
            .padding()
        // やめるボタン
        cancelButton
            .padding()
    } // body ここまで
    
    // 追加する薬の名前を入力するようユーザーに促すためのテキスト
    private var enterMedicineNameText: some View {
        Text("追加する薬の名前を入力してください")
    } // enterMedicineNameText ここまで
    
    // 先発品名を入力するためのテキストフィールド
    private var originalMedicineTextField: some View {
        Text("先発品名")
    } // originalMedicineTextField ここまで
    
    // 一般名を入力するためのテキストフィールド
    private var genericMedicineTextField: some View {
        Text("一般名")
    } // genericMedicineTextField ここまで
    
    // 追加ボタン
    private var addButton: some View {
        Button {
            // 薬の名前をカスタムに追加する処理
            dismiss()
        } label: {
            // ラベル
            Text("追加")
        } // Button ここまで
    } // addButton ここまで
    
    // やめるボタン
    private var cancelButton: some View {
        Button {
            // シートを閉じる
            dismiss()
        } label: {
            // ラベル
            Text("やめる")
        } // Button ここまで
    } // cancelButton ここまで
} // AddMedicineView

#Preview {
    AddMedicineView()
}
