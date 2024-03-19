//
//  CreateQuestionListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct CreateQuestionListView: View {
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) private var context
    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // CreateQuestionListViewModelのインスタンスを生成
    @State private var viewModel: CreateQuestionListViewModel

    // View Presentation State
    // リストに名前が無い時に表示するアラートを管理する変数
    @State private var isShowNoListNameAlert = false
    // フォーカス制御を行うための変数
    @FocusState private var isFocusActive: Bool
    // カスタムの薬データをフェッチ
    @FetchRequest(entity: CustomMedicine.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \CustomMedicine.brandName, ascending: true)],
                  animation: nil
    ) private var fetchedCustomMedicines: FetchedResults<CustomMedicine>

    // イニシャライザ（問題リスト作成の場合）
    init(questionListMode: QuestionListMode) {
        _viewModel = State(initialValue: CreateQuestionListViewModel(questionListMode: questionListMode))
    } // init ここまで

    // イニシャライザ（問題リスト編集の場合）
    init(questionListMode: QuestionListMode, questionList: QuestionList) {
        _viewModel = State(initialValue: CreateQuestionListViewModel(questionListMode: questionListMode,
                                                                     questionList: questionList))
    } // init ここまで

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
                            // フォーカスを当てる
                            .focused($isFocusActive)
                            // テキストフィールドの背景を指定
                            .textFieldBackground()
                            .padding(.horizontal)
                    } // VStack ここまで
                } // ZStack ここまで
                // 薬の区分を選択するタブを配置
                TopTabView(selectTab: $viewModel.category)
                    // 太字にする
                    .bold()
                // 薬の検索バーを配置
                SearchBar(searchText: $viewModel.medSearchText, placeholderText: "薬を検索できます")
                    .padding(.top)
                // 薬リスト
                switch viewModel.category {
                // 内用薬を表示
                case .oral:
                    MedicineSelectableList(listItems: $viewModel.oralListItems, indicesForSearch: viewModel.indicesForSearch)
                // 注射薬を表示
                case .injection:
                    MedicineSelectableList(listItems: $viewModel.injectionListItems, indicesForSearch: viewModel.indicesForSearch)
                // 外用薬を表示
                case .topical:
                    MedicineSelectableList(listItems: $viewModel.topicalListItems, indicesForSearch: viewModel.indicesForSearch)
                // カスタムを表示
                case .custom:
                    MedicineSelectableList(listItems: $viewModel.customListItems, indicesForSearch: viewModel.indicesForSearch)
                } // switch ここまで
            } // VStack ここまで
        } // ZStack ここまで
        // タブバーを隠す
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            // 薬リストをフェッチ
            viewModel.fetchListItems(from: fetchedCustomMedicines)
            // 問題作成モードの場合
            if viewModel.questionListMode == .create {
                // リスト名を無くす
                viewModel.listName.removeAll()
                // 画面を表示した時に名前を入力するテキストフィールドにフォーカスを当てる
                isFocusActive = true
            } else {
                // 選択されている問題をリストに表示する配列にマージ
                viewModel.mergeSelectedQuestions()
            } // if ここまで
        } // onAppear ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("リスト\(viewModel.questionListMode.rawValue)", displayMode: .inline)
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
                        viewModel.saveQuestionList(context: context)
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
