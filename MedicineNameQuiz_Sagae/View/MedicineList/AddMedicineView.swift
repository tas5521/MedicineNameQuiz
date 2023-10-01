//
//  AddMedicineView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct AddMedicineView: View {
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        Text("追加する薬の名前を入力してください")
            .padding()
        Text("先発品名")
            .padding()
        Text("一般名")
            .padding()
        Button {
            // 薬の名前をカスタムに追加する処理
            presentation.wrappedValue.dismiss()
        } label: {
            Text("追加")
        } // Button ここまで
        .padding()
        
        Button {
            presentation.wrappedValue.dismiss()
        } label: {
            Text("やめる")
        } // Button ここまで
        .padding()
    } // body ここまで
} // AddMedicineView

#Preview {
    AddMedicineView()
}
