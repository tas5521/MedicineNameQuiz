//
//  EditQuestionListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct EditQuestionListView: View {
    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // タブの選択項目を保持する変数
    @State private var tabIndex: Int = 0
    // リスト名
    @State private var listName: String = "さがえ薬局リスト"
    // 薬の検索に使う変数
    @State private var medicineNameText: String = ""
    // 「すべてチェックする」か「すべてのチェックを外す」かを管理する変数
    @State private var checkAll: Bool = true
    // ダミーの薬リスト
    @State private var dummyMedicineList: [MedicineListItem] = [
        MedicineListItem(originalName: "アムロジン", genericName: "アムロジピンベシル酸塩", checked: false),
        MedicineListItem(originalName: "インフリー", genericName: "インドメタシン　ファルネシル", checked: false),
        MedicineListItem(originalName: "ウリトス", genericName: "イミダフェナシン", checked: false),
        MedicineListItem(originalName: "エバステル", genericName: "エバスチン", checked: false),
        MedicineListItem(originalName: "オノン", genericName: "プランルカスト水和物", checked: false),
        MedicineListItem(originalName: "ガスター", genericName: "ファモチジン", checked: false),
        MedicineListItem(originalName: "キプレス", genericName: "モンテルカストナトリウム", checked: false),
        MedicineListItem(originalName: "クラビット", genericName: "レボフロキサシン", checked: false)
    ] // dummyMedicineList ここまで
    
    var body: some View {
        // 奥から手前にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
            // セーフエリア外にも背景を表示
                .ignoresSafeArea()
            // 垂直右方向にレイアウト
            VStack {
                // 薬の区分を選択するタブを配置
                TopTabView(
                    tabIndex: $tabIndex, tabNameList: MedicineClassification.allCases.map({classification in classification.rawValue}))
                // リスト名編集用テキストフィールド
                TextField("リストの名前を入力してください", text: $listName)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                // 水平方向にレイアウト
                HStack {
                    // 虫眼鏡のImage
                    Image(systemName: "magnifyingglass")
                    // 薬の検索バー
                    TextField("薬を検索できます", text: $medicineNameText)
                        .textFieldStyle(.roundedBorder)
                } // HStack ここまで
                // 上下左右に余白を追加
                .padding()
                Spacer()
                // 薬リスト
                // 垂直方向にレイアウト
                VStack(alignment: .leading) {
                    // 水平方向にレイアウト
                    HStack {
                        // 総問題数を表示
                        Text("総問題数: \(dummyMedicineList.count)")
                        // スペースを空ける
                        Spacer()
                        // 「すべてチェックする」もしくは「すべてのチェックを外す」ボタン
                        Button {
                            // もしボタンが「すべてチェックする」の状態だったら
                            if checkAll {
                                // すべてチェック状態にする
                                for index in dummyMedicineList.indices {
                                    dummyMedicineList[index].checked = true
                                } // for ここまで
                                // もしボタンが「すべてのチェックを外す」の状態だったら
                            } else {
                                // すべてのチェックを外す
                                for index in dummyMedicineList.indices {
                                    dummyMedicineList[index].checked = false
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
                        ForEach(dummyMedicineList.indices, id: \.self) { index in
                            // 水平方向にレイアウト
                            HStack {
                                // 垂直方向にレイアウト
                                VStack(alignment: .leading) {
                                    // 先発品名を表示
                                    Text(dummyMedicineList[index].originalName)
                                    // 文字の色を青に変更
                                        .foregroundStyle(Color.blue)
                                    // 一般名を表示
                                    Text(dummyMedicineList[index].genericName)
                                    // 文字の色を赤に変更
                                        .foregroundStyle(Color.red)
                                } // VStack ここまで
                                // スペースを空ける
                                Spacer()
                                // チェックボタン
                                Button {
                                    // チェック状態を変更
                                    dummyMedicineList[index].checked.toggle()
                                } label: {
                                    // ラベル
                                    Image(systemName: "checkmark.square.fill")
                                    // チェック状態では青、チェックされていない状態ではグレーにする
                                        .foregroundStyle(dummyMedicineList[index].checked ? .blue : .gray)
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
                // 太字にする
                .bold()
            } // VStack ここまで
            Spacer()
        } // ZStack ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("リスト編集", displayMode: .inline)
        // ナビゲーションバーの背景を青色に変更
        .toolbarBackground(.navigationBarBlue, for: .navigationBar)
        // ナビゲーションバーの背景を表示
        .toolbarBackground(.visible, for: .navigationBar)
        // ナビゲーションバーのタイトルの色を白にする
        .toolbarColorScheme(.dark)
        // ナビゲーションバーの右側に保存ボタンを配置
        .toolbar {
            // ボタンの位置を指定
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // 保存処理
                    // 画面を閉じる
                    dismiss()
                } label: {
                    // ラベル
                    Text("保存")
                    // 色を指定
                        .foregroundColor(Color.white)
                } // Button ここまで
            } // ToolbarItem ここまで
        } // toolbar ここまで
    } // body ここまで
} // EditQuestionListViewここまで

#Preview {
    EditQuestionListView()
}
