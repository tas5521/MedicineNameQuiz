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
    // Pickerの選択されている状態を管理するCoreDataをフェッチ
    @FetchRequest(entity: UserSelection.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \UserSelection.questoinListID, ascending: false)],
                  predicate: nil,
                  animation: nil
    ) private var userSelection: FetchedResults<UserSelection>
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
                        .onChange(of: viewModel.questionListID) {
                            saveUserSelection()
                        } // onChange ここまで
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
                        .onChange(of: viewModel.studyMode) {
                            saveUserSelection()
                        } // onChange ここまで
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
                        .onChange(of: viewModel.questionSelection) {
                            saveUserSelection()
                        } // onChange ここまで
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
                if userSelection.isEmpty {
                    // 初回はuserSelectionが空なので、第一要素を作成
                    initializeUserSelection()
                } else {
                    // 次回以降はuserSelectionに要素があるので、状態を読み込み
                    loadUserSelection()
                } // if ここまで
                // もし、現在指定されたIDの問題が問題リスト（fetchedLists）になかったら、リストの一番上のものにする
                if !fetchedLists.contains(where: { $0.id == viewModel.questionListID }) {
                    viewModel.questionListID = fetchedLists.first?.id ?? UUID()
                    // 値が変わった時は必ず状態を記憶しておく
                    saveUserSelection()
                } // if ここまで
            } // onAppear ここまで
            // ナビゲーションバーの設定
            // ナビゲーションバーのタイトルを設定
            .navigationBarTitle("学習", displayMode: .inline)
            // ナビゲーションバーの背景を変更
            .navigationBarBackground()
        } // NavigationStack ここまで
    } // body ここまで

    // 最初にUserSelectionに第一要素を作成するメソッド
    private func initializeUserSelection() {
        // UserSelectionのインスタンスを生成
        let initialUserSelection = UserSelection(context: context)
        // 問題リストを識別するIDを保持
        initialUserSelection.questoinListID = viewModel.questionListID
        // 出題モードを保持
        initialUserSelection.studyMode = viewModel.studyMode.rawValue
        // 出題設定を保持
        initialUserSelection.questionSelection = viewModel.questionSelection.rawValue
        do {
            // 問題リストをCore Dataに保存
            try context.save()
        } catch {
            // 何らかのエラーが発生した場合は、エラー内容をデバッグエリアに表示
            print("エラー: \(error)")
        } // do-try-catch ここまで
    } // initializeUserSelection ここまで

    // Pickerの選択の状態を保存するメソッド
    private func saveUserSelection() {
        // 問題リストを識別するIDを保持
        userSelection.first?.questoinListID = viewModel.questionListID
        // 出題モードを保持
        userSelection.first?.studyMode = viewModel.studyMode.rawValue
        // 出題設定を保持
        userSelection.first?.questionSelection = viewModel.questionSelection.rawValue
        do {
            // 問題リストをCore Dataに保存
            try context.save()
        } catch {
            // 何らかのエラーが発生した場合は、エラー内容をデバッグエリアに表示
            print("エラー: \(error)")
        } // do-try-catch ここまで
    } // saveUserSelection ここまで

    // Pickerの選択の状態を読み込むメソッド
    private func loadUserSelection() {
        // 問題リストを識別するIDを読み込み
        viewModel.questionListID = userSelection.first?.questoinListID ?? UUID()
        // 出題モードを読み込み
        viewModel.studyMode = StudyMode(rawValue: userSelection.first?.studyMode ?? "") ?? .brandToGeneric
        // 出題設定を読み込み
        viewModel.questionSelection = QuestionSelectionMode(rawValue: userSelection.first?.questionSelection ?? "") ?? .all
    } // loadUserSelection ここまで

    // UserSelectionの要素を全て削除するメソッド（デバッグ用）
    /*
     private func deleteUserSelection() {
     // フェッチリクエストを生成
     let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
     // エンティティにUserSelectionを指定
     fetchRequest.entity = UserSelection.entity()
     // UserSelectionの要素を取得
     if let userSelections = try? context.fetch(fetchRequest) as? [UserSelection] {
     // 全て削除
     for userSelection in userSelections {
     context.delete(userSelection)
     } // for ここまで
     } // if let ここまで
     // 数を確認
     print(userSelection.count)
     } // deleteUserSelection
     */
} // ModeSelectionView ここまで

#Preview {
    ModeSelectionView()
}
