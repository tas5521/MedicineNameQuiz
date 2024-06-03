//
//  QuestionListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct QuestionListView: View {
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) private var context
    // 問題リストをフェッチ
    @FetchRequest(entity: QuestionList.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \QuestionList.createdDate, ascending: false)],
                  animation: nil
    ) private var fetchedLists: FetchedResults<QuestionList>
    // リスト名検索テキスト
    @State private var listName: String = ""

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
                    // 問題リストの検索バー
                    SearchBar(searchText: $listName, placeholderText: "リストを検索できます")
                        .onChange(of: listName) {
                            // 問題リストに検索をかける
                            searchList()
                        } // onChange ここまで
                        // 上下に余白を指定
                        .padding(.vertical)
                    // 問題リスト
                    questionList
                } // VStack ここまで
                // 垂直方向にレイアウト
                VStack {
                    // スペースを空ける
                    Spacer()
                    // 水平方向にレイアウト
                    HStack {
                        // スペースを空ける
                        Spacer()
                        // リスト追加ボタン
                        addListButton
                            .padding()
                    } // HStack ここまで
                } // VStack ここまで
            } // ZStack ここまで
            // ナビゲーションバーの設定
            // ナビゲーションバーのタイトルを設定
            .navigationBarTitle("問題リスト", displayMode: .inline)
            // ナビゲーションバーの背景を変更
            .navigationBarBackground()
        } // NavigationStack ここまで
    } // body ここまで

    // 問題リスト
    private var questionList: some View {
        List {
            ForEach(fetchedLists) { list in
                // 商品名→一般名の正解数
                let brandToGenericCorrectCount = (list.questions as? Set<Question>)?.filter({
                    $0.brandToGenericResult == StudyResult.correct.rawValue
                }).count
                // 商品名→一般名の正答率
                let brandToGenericAnswerPercentage = String(
                    format: "%.1f%%", Float(brandToGenericCorrectCount ?? 0) / Float(list.numberOfQuestions) * 100
                ) // brandToGenericAnswerPercentage ここまで
                // 一般名→商品名の正解数
                let genericToBrandCorrectCount = (list.questions as? Set<Question>)?.filter({
                    $0.genericToBrandResult == StudyResult.correct.rawValue
                }).count
                // 一般名→商品名の正答率
                let genericToBrandAnswerPercentage = String(
                    format: "%.1f%%", Float(genericToBrandCorrectCount ?? 0) / Float(list.numberOfQuestions) * 100
                ) // answerPercentage ここまで
                // 各行に対応した画面へ遷移
                NavigationLink {
                    QuestionsView(brandToGenericAnswerPercentage: brandToGenericAnswerPercentage,
                                  genericToBrandAnswerPercentage: genericToBrandAnswerPercentage,
                                  questionList: list)
                } label: {
                    // 水平方向にレイアウト
                    HStack {
                        // 垂直方向にレイアウト
                        VStack(alignment: .leading) {
                            // リストの名前
                            Text(list.listName ?? "")
                            // 問題数を表示
                            Text("問題数: \(list.numberOfQuestions)")
                        } // VStack ここまで
                        // スペースを空ける
                        Spacer()
                        // 垂直方向にレイアウト
                        VStack(alignment: .leading) {
                            // 商品名→一般名の正答率を表示
                            Text("商 → 般: \(brandToGenericAnswerPercentage)")
                            // 一般名→商品名の正答率を表示
                            Text("般 → 商: \(genericToBrandAnswerPercentage)")
                        } // VStack ここまで
                    } // HStack ここまで
                    // 太字にする
                    .bold()
                } // NavigationLink ここまで
            } // ForEach ここまで
            // リストを左にスライドして削除できるようにする
            .onDelete(perform: deleteQuestionList)
        } // List ここまで
        // リストのスタイルを.groupedに変更
        .listStyle(.grouped)
        // リストの背景のグレーの部分を非表示にする
        .scrollContentBackground(.hidden)
    } // questionList ここまで

    // リスト追加ボタン
    private var addListButton: some View {
        NavigationLink {
            // 問題リスト作成画面へ遷移
            CreateQuestionListView(questionListMode: .create)
        } label: {
            Image(systemName: "plus.circle.fill")
                // リサイズする
                .resizable()
                // アスペクト比を保ったまま枠いっぱいに表示
                .scaledToFit()
                // 幅高さ65に指定
                .frame(width: 65, height: 65)
                // ボタンの色をオレンジに指定
                .foregroundStyle(.buttonOrange)
                // 背景を白に指定
                .background(Color.white)
                // 丸くクリッピング
                .clipShape(Circle())
        } // Button ここまで
    } // addListButton ここまで

    // 問題リストに検索をかけるメソッド
    private func searchList() {
        // 検索キーワードが空の場合
        if listName.isEmpty {
            // 検索条件を無し（nil）にする
            fetchedLists.nsPredicate = nil
        } else {
            // 検索キーワードがある場合
            // listNameに検索キーワードを含むか調べる条件を指定
            fetchedLists.nsPredicate = NSPredicate(format: "listName contains %@", listName)
        } // if ここまで
    } // searchList ここまで

    // Core Dataから指定した問題リストを削除するメソッド
    private func deleteQuestionList(offsets: IndexSet) {
        for index in offsets {
            // CoreDataから該当するindexのメモを削除
            context.delete(fetchedLists[index])
        } // for ここまで
        // エラーハンドリング
        do {
            // 生成したインスタンスをCoreDataに保持する
            try context.save()
        } catch {
            // このメソッドにより、クラッシュログを残して終了する
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        } // エラーハンドリングここまで
    } // deleteQuestionList ここまで
} // QuestionListView ここまで

#Preview {
    QuestionListView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
