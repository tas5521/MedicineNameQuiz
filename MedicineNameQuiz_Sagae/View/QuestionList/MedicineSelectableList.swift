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
                // 全て選択されているかどうかを判定
                var isAllSelected: Bool {
                    // 初期値はtrue
                    var isSelected: Bool = true
                    // 全てのselectedの値との論理積をとる
                    for medicineArrayItem in medicineArray {
                        isSelected = isSelected && medicineArrayItem.selected
                    } // for ここまで
                    // isSelectedを返す
                    return isSelected
                } // isAllSelected ここまで
                // 選択されている項目が1つでもある場合
                if isAllSelected {
                    // 「全て選択しない」ボタンを表示
                    selectAllButton(selectAll: false)
                    // 選択されていない項目が一つでもある場合
                } else {
                    // 「全て選択する」ボタン
                    selectAllButton(selectAll: true)
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
                            Text(medicineArray[index].originalName)
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
            .constant([MedicineListItem(originalName: "内用薬先発品名1", genericName: "内用薬一般名1", selected: false),
                       MedicineListItem(originalName: "内用薬先発品名2", genericName: "内用薬一般名2", selected: false)]))
}
