//
//  MedicineSelectableList.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/12/21.
//

import SwiftUI

struct MedicineSelectableList: View {
    // 「すべてチェックする」か「すべてのチェックを外す」かを管理する変数
    @Binding var checkAll: Bool
    @Binding var medicineArray: [MedicineListItem]
    
    var body: some View {
        // 垂直方向にレイアウト
        VStack(alignment: .leading) {
            // 水平方向にレイアウト
            HStack {
                // 問題数を表示
                Text("問題数: \(medicineArray.count)")
                // スペースを空ける
                Spacer()
                // 「すべてチェックする」もしくは「すべてのチェックを外す」ボタン
                Button {
                    // もしボタンが「すべてチェックする」の状態だったら
                    if checkAll {
                        // すべてチェック状態にする
                        for index in medicineArray.indices {
                            medicineArray[index].checked = true
                        } // for ここまで
                        // もしボタンが「すべてのチェックを外す」の状態だったら
                    } else {
                        // すべてのチェックを外す
                        for index in medicineArray.indices {
                            medicineArray[index].checked = false
                        } // for ここまで
                    } // if ここまで
                    // ボタンの状態を切り替える
                    checkAll.toggle()
                } label: {
                    // ラベル
                    Text(checkAll ? "すべてチェックする" : "すべてのチェックを外す")
                    // 青色にする
                        .foregroundStyle(Color.blue)
                } // Buttonここまで
            } // HStack ここまで
            // 左に余白を追加
            .padding([.top, .leading, .trailing])
            // 出題される薬の名前のリスト
            List {
                ForEach(medicineArray.indices, id: \.self) { index in
                    // 水平方向にレイアウト
                    HStack {
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
                        // スペースを空ける
                        Spacer()
                        // チェックボタン
                        Button {
                            // チェック状態を変更
                            medicineArray[index].checked.toggle()
                        } label: {
                            // ラベル
                            Image(systemName: "checkmark.square.fill")
                            // チェック状態では青、チェックされていない状態ではグレーにする
                                .foregroundStyle(medicineArray[index].checked ? .blue : .gray)
                            // 大きさを1.8倍にする
                                .scaleEffect(1.8)
                        } // Button ここまで
                    } // HStack ここまで
                } // ForEach ここまで
            } // List ここまで
            // リストのスタイルを.groupedに変更
            .listStyle(.grouped)
            // リストの背景のグレーの部分を非表示にする
            .scrollContentBackground(.hidden)
        } // VStack ここまで
    } // body ここまで
} // MedicineSelectableList ここまで

#Preview {
    MedicineSelectableList(checkAll: .constant(true), medicineArray:
            .constant([MedicineListItem(originalName: "内用薬先発品名1", genericName: "内用薬一般名1", checked: false),
                       MedicineListItem(originalName: "内用薬先発品名2", genericName: "内用薬一般名2", checked: false)]))
}
