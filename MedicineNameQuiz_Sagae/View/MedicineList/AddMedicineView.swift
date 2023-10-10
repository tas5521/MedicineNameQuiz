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
        // メッセージ
        enterMedicineNameMessage
            .padding()
        // 先発品名を入力するためのテキストフィールド
        originalMedicineTextField
            .padding()
        // 一般名を入力するためのテキストフィールド
        genericMedicineTextField
            .padding()
        // 追加ボタン
        addMedicineButton
            .padding()
        
        // やめるボタン
        dismissButton
            .padding()
    } // body ここまで
    
    // メッセージ
    private var enterMedicineNameMessage: some View {
        Text("追加する薬の名前を入力してください")
    } // message ここまで
    
    // 先発品名を入力するためのテキストフィールド
    private var originalMedicineTextField: some View {
        Text("先発品名")
    } // textFieldToInputNameOfOriginalMedicine ここまで
    
    // 一般名を入力するためのテキストフィールド
    private var genericMedicineTextField: some View {
        Text("一般名")
    } // textFieldToInputNameOfOriginalMedicine ここまで
    
    // 追加ボタン
    private var addMedicineButton: some View {
        Button {
            // 薬の名前をカスタムに追加する処理
            dismiss()
        } label: {
            // ラベル
            Text("追加")
        } // Button ここまで
    } // addButton ここまで
    
    // シートを閉じるボタン
    private var dismissButton: some View {
        Button {
            // シートを閉じる
            dismiss()
        } label: {
            // ラベル
            Text("やめる")
        } // Button ここまで
    } // addButton ここまで
} // AddMedicineView

#Preview {
    AddMedicineView()
}
