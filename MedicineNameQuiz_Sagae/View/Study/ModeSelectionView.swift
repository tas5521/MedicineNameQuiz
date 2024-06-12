//
//  ModeSelectionView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct ModeSelectionView: View {
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) private var context
    // 学習中であるかを管理する変数
    @State private var isStudying: Bool = false
    // ModeSelectionViewModelのインスタンス
    @State private var viewModel: ModeSelectionViewModel = ModeSelectionViewModel()
    // 問題リストをフェッチ
    @FetchRequest(entity: QuestionList.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \QuestionList.createdDate, ascending: false)],
                  predicate: nil,
                  animation: nil
    ) private var fetchedLists: FetchedResults<QuestionList>
    // Pickerに表示する問題リストの配列
    private var questionListPickerItems: [QuestionListPickerItem] {
        fetchedLists.map { QuestionListPickerItem(id: $0.id ?? UUID(), listName: $0.listName ?? "") }
    } // questionListPickerItems ここまで

    var body: some View {
        NavigationStack {
            // 手前から奥にレイアウト
            ZStack {
                // 背景を水色にする
                Color.backgroundSkyBlue
                    // セーフエリア外にも背景を表示
                    .ignoresSafeArea()
                // 垂直方向にレイアウト
                VStack {
                    // 垂直方向にレイアウト（Viewを左に寄せる）
                    VStack(alignment: .leading) {
                        // スペースを空ける
                        Spacer()

                        // 問題リストの選択を促すテキスト
                        Text("問題リスト選択")
                            // フォントを.titleに指定
                            .font(.title2)
                            // 太字にする
                            .bold()

                        // 問題リスト選択用のPicker
                        Picker("問題リスト選択", selection: $viewModel.questionListID) {
                            ForEach(questionListPickerItems) { item in
                                Text(item.listName)
                                    .tag(item.id)
                            } // ForEach ここまで
                        } // Picker ここまで
                        // ホイールで表示
                        .pickerStyle(.wheel)
                        // 上下の余白を20減らす
                        .padding([.top, .bottom], -20)

                        // スペースを空ける
                        Spacer()

                        // モード選択を促すテキスト
                        Text("問題リストからの出題設定")
                            // フォントを.titleに指定
                            .font(.title2)
                            // 太字にする
                            .bold()

                        // 出題モード選択用のPicker
                        Picker("出題モード選択", selection: $viewModel.studyMode) {
                            // 要素を繰り返す
                            ForEach(StudyMode.allCases, id: \.self) { mode in
                                // モードの選択肢
                                Text(mode.rawValue)
                                    .tag(mode)
                            } // ForEach ここまで
                        } // Picker ここまで
                        // セグメントで表示
                        .pickerStyle(.segmented)
                        // 上下左右に余白を追加
                        .padding()

                        // 出題設定用のPicker
                        Picker("出題設定", selection: $viewModel.questionSelection) {
                            // 要素を繰り返す
                            ForEach(QuestionSelectionMode.allCases, id: \.self) { mode in
                                // モードの選択肢
                                Text(mode.rawValue)
                                    .tag(mode)
                            } // ForEach ここまで
                        } // Picker ここまで
                        // セグメントで表示
                        .pickerStyle(.segmented)
                        // 上下左右に余白を追加
                        .padding(.horizontal)
                    } // VStack ここまで
                    // 上下左右に余白を追加
                    .padding()
                    Text("リスト内の全ての問題に正解している場合は、\nわからない問題を選択しても、全問出題されます")
                        .padding(.bottom)
                    // スペースを空ける
                    Spacer()
                    // スタートボタンを配置
                    Button {
                        // 問題を作成
                        viewModel.createQuestions(fetchedLists: fetchedLists)
                        // 学習開始
                        isStudying.toggle()
                    } label: {
                        // ラベル
                        Text("スタート")
                            // フォントを.title2に指定
                            .font(.title2)
                            // 太字にする
                            .bold()
                            // 文字の色を白にする
                            .foregroundStyle(Color.white)
                            // 幅150高さ50に指定
                            .frame(width: 150, height: 60)
                            // 背景色をオレンジに指定
                            .background(Color.buttonOrange)
                            // 角を丸くする
                            .clipShape(.buttonBorder)
                    } // Button ここまで
                    .padding(.bottom, 80)
                } // VStack ここまで
                // 問題を解く画面へ遷移
                .navigationDestination(isPresented: $isStudying) {
                    StudyView(isStudying: $isStudying,
                              questions: $viewModel.questions,
                              studyMode: viewModel.studyMode,
                              questionListID: viewModel.questionListID)
                } // navigationDestination ここまで
            } // ZStack ここまで
            .onAppear {
                // Pickerの状態を読み込み
                viewModel.loadUserSelection()
            } // onAppear ここまで
            .navigationBarTitle("学習", displayMode: .inline)
            // ナビゲーションバーの背景を変更
            .navigationBarBackground()
        } // NavigationStack ここまで
    } // body ここまで
} // ModeSelectionView ここまで

#Preview {
    ModeSelectionView()
}
