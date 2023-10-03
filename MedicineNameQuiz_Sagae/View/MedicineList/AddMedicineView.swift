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
        message
            .padding()
        // 先発品名を入力するためのテキストフィールド
        textFieldToInputNameOfOriginalMedicine
            .padding()
        // 一般名を入力するためのテキストフィールド
        textFieldToInputNameOfGenericMedicine
            .padding()
        // 追加ボタン
        addButton
            .padding()
        
        // やめるボタン
        cancelButton
            .padding()
    } // body ここまで
    
    // メッセージ
    private var message: some View {
        Text("追加する薬の名前を入力してください")
    } // message ここまで
    
    // 先発品名を入力するためのテキストフィールド
    private var textFieldToInputNameOfOriginalMedicine: some View {
        Text("先発品名")
    } // textFieldToInputNameOfOriginalMedicine ここまで
    
    // 一般名を入力するためのテキストフィールド
    private var textFieldToInputNameOfGenericMedicine: some View {
        Text("一般名")
    } // textFieldToInputNameOfOriginalMedicine ここまで
    
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
    } // addButton ここまで
} // AddMedicineView

#Preview {
    AddMedicineView()
}
