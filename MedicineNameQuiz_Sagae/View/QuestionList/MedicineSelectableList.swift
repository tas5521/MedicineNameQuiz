//
//  MedicineSelectableList.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/12/21.
//

import SwiftUI

struct MedicineSelectableList: View {
    // 表示する薬の名前を受け取る配列
    @Binding var medicineArray: [MedicineListItem]

    // 全ての薬が選択されているかどうかを判定
    private var isAllMedicineSelected: Bool {
        medicineArray.allSatisfy( { medicine in medicine.selected } )
    } // isAllMedicineSelected ここまで

    var body: some View {
        // 垂直方向にレイアウト
        VStack(alignment: .leading) {
            // 水平方向にレイアウト
            HStack {
                // 問題数を表示
                Text("問題数: \(medicineArray.count)")
                // 太字にする
                    .bold()
                // スペースを空ける
                Spacer()
                    // 「全て選択する」ボタンまたは「全て選択しない」ボタンを表示
                if !medicineArray.isEmpty {
                    selectAllButton(selectAll: !isAllMedicineSelected)
                } // if ここまで
            } // HStack ここまで
            // 上下と左に余白を追加
            .padding([.top, .leading, .trailing])
            // 出題される薬の名前のリスト
            List {
                ForEach(medicineArray.indices, id: \.self) { index in
                    // Toggleを配置
                    Toggle(isOn: $medicineArray[index].selected) {
                        // 垂直方向にレイアウト
                        VStack(alignment: .leading) {
                            // 先発品名を表示
                            Text(medicineArray[index].brandName)
                            // 文字の色を青に変更
                                .foregroundStyle(Color.blue)
                            // 一般名を表示
                            Text(medicineArray[index].genericName)
                            // 文字の色を赤に変更
                                .foregroundStyle(Color.red)
                        } // VStack ここまで
                    } // Toggle ここまで
                } // ForEach ここまで
            } // List ここまで
            // 太字にする
            .bold()
            // リストのスタイルを.groupedに変更
            .listStyle(.grouped)
            // リストの背景のグレーの部分を非表示にする
            .scrollContentBackground(.hidden)
        } // VStack ここまで
    } // body ここまで

    // 全て選択する、もしくは、全て選択しないボタン
    private func selectAllButton(selectAll: Bool) -> some View {
        Button {
            // 全て選択する、もしくは、全て選択しない
            for index in medicineArray.indices {
                medicineArray[index].selected = selectAll
            } // for ここまで
        } label: {
            // ラベル
            Text(selectAll ? "全て選択する" : "全て選択しない")
            // 青色にする
                .foregroundStyle(Color.blue)
        } // Buttonここまで
    } // selectAllButton ここまで
} // MedicineSelectableList ここまで

#Preview {
    MedicineSelectableList(medicineArray:
            .constant([MedicineListItem(category: .oral, brandName: "内用薬先発品名1", genericName: "内用薬一般名1", selected: false),
                       MedicineListItem(category: .oral, brandName: "内用薬先発品名2", genericName: "内用薬一般名2", selected: false)]))
}
