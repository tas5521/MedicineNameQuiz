//
//  CreateQuestionListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct CreateQuestionListView: View {
    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // CreateQuestionListViewModelのインスタンスを生成
    @State private var viewModel: CreateQuestionListViewModel =  CreateQuestionListViewModel()
    
    // View Presentation State
    // リストに名前が無い時に表示するアラートを管理する変数
    @State private var isShowNoListNameAlert = false
    // カスタムの薬データをフェッチ
    @FetchRequest(entity: CustomMedicine.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \CustomMedicine.brandName, ascending: true)],
                  animation: nil
    ) private var fetchedCustomMedicines: FetchedResults<CustomMedicine>
    // 問題リストを作成するか編集するかを管理する変数
    let questionListMode: QuestionListMode

    var body: some View {
        // 奥から手前にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
            // セーフエリア外にも背景を表示
                .ignoresSafeArea()
            // 垂直右方向にレイアウト
            VStack(spacing: 0) {
                // 奥から手前にレイアウト
                ZStack {
                    // 背景をタブの青色にする
                    Color.tabBlue
                    // セーフエリア外にも背景を表示
                        .ignoresSafeArea()
                    // 高さを90に指定
                        .frame(height: 90)
                    // 垂直右方向にレイアウト
                    VStack(alignment: .leading) {
                        // 「リストの名前」のテキストを配置
                        Text("リストの名前")
                        // 文字色を白に指定
                            .foregroundStyle(Color.white)
                        // 左に余白を追加
                            .padding(.leading)
                        // リスト名編集用テキストフィールド
                        TextField("リストの名前を入力してください", text: $viewModel.listName)
                        // テキストフィールドの背景を指定
                            .textFieldBackground()
                            .padding(.horizontal)
                    } // VStack ここまで
                } // ZStack ここまで
                // 薬の区分を選択するタブを配置
                TopTabView(selectTab: $viewModel.medicineClassification)
                // 太字にする
                .bold()
                // 薬の検索バーを配置
                SearchBar(searchText: $viewModel.searchMedicineName, placeholderText: "薬を検索できます")
                    .padding(.top)
                // 薬リスト
                switch viewModel.medicineClassification {
                    // 内用薬を表示
                case .oral:
                    MedicineSelectableList(medicineArray: $viewModel.internalMedicineList)
                    // 注射薬を表示
                case .injection:
                    MedicineSelectableList(medicineArray: $viewModel.injectionMedicineList)
                    // 外用薬を表示
                case .externalMedicine:
                    MedicineSelectableList(medicineArray: $viewModel.externalMedicineList)
                    // カスタムを表示
                case .customMedicine:
                    MedicineSelectableList(medicineArray: $viewModel.customMedicineList)
                } // switch ここまで
            } // VStack ここまで
        } // ZStack ここまで
        .onAppear {
            // リスト名を無くす
            viewModel.listName.removeAll()
            // 薬リストをフェッチ
            viewModel.fetchMedicineListItems(fetchedCustomMedicines: fetchedCustomMedicines)
        } // onAppear ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("リスト\(questionListMode.rawValue)", displayMode: .inline)
        // ナビゲーションバーの背景を変更
        .navigationBarBackground()
        .toolbar {
            // ボタンの位置を指定
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if viewModel.listName.isEmpty {
                        isShowNoListNameAlert.toggle()
                    } else {
                        // 保存処理
                        // 画面を閉じる
                        dismiss()
                    } // if ここまで
                } label: {
                    // ラベル
                    Text("保存")
                    // 色を指定
                        .foregroundColor(Color.white)
                } // Button ここまで
            } // ToolbarItem ここまで
        } // toolbar ここまで
        // リストの名前が無いことを警告するアラート
        .alert("リストに名前がありません", isPresented: $isShowNoListNameAlert) {
                // やめるボタン
                Button {
                    // 何もしない
                } label: {
                    // ラベル
                    Text("OK")
                } // Button ここまで
            } message: {
                Text("リストに名前をつけてください")
        } // alert ここまで
    } // body ここまで
} // CreateQuestionListView ここまで

#Preview {
    CreateQuestionListView(questionListMode: .create)
}
