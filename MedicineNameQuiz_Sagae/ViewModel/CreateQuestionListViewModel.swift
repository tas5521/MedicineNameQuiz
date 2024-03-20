//
//  CreateQuestionListViewModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/02/23.
//

import SwiftUI
import CoreData

@Observable
final class CreateQuestionListViewModel {
    // 問題リストの名前を保持する変数
    var listName: String = ""
    // 選択されているタブを管理する変数
    var category: MedicineCategory = .oral
    // 薬の検索に使う変数
    var medSearchText: String = ""

    // 内用薬の配列
    var oralListItems: [MedicineListItem] = []
    // 注射薬の配列
    var injectionListItems: [MedicineListItem] = []
    // 外用薬の配列
    var topicalListItems: [MedicineListItem] = []
    // カスタム薬の配列
    var customListItems: [MedicineListItem] = []

    // 検索条件に合う要素のindexを取得
    var indicesForSearch: [Int] {
        // 選択されている薬リスト
        var selectedListItems: [MedicineListItem] {
            switch category {
            case .oral:
                oralListItems
            case .injection:
                injectionListItems
            case .topical:
                topicalListItems
            case .custom:
                customListItems
            } // switch ここまで
        } // selectedMedicineListItems ここまで
        // 検索キーワードが無ければ、全てのIndexを返して終了
        guard medSearchText.isEmpty == false else {
            return Array(selectedListItems.indices)
        } // guard ここまで
        // 検索キーワードがある場合、検索キーワードを商品名もしくは一般名に持つ要素のindexを返す
        return selectedListItems.indices.filter {
            selectedListItems[$0].brandName.contains(medSearchText) ||
                selectedListItems[$0].genericName.contains(medSearchText)
        } // selectedListItems.indices.filter ここまで
    } // indicesForSearch ここまで

    // 問題リストを作成するか編集するかを管理する変数
    let questionListMode: QuestionListMode

    // 問題リストを保持する変数
    private var questionList: QuestionList = QuestionList()

    // CreateQuestionListModelのインスタンスを生成
    private let model = CreateQuestionListModel()

    // イニシャライザ（問題リスト作成の場合）
    init(questionListMode: QuestionListMode) {
        self.questionListMode = questionListMode
    } // init ここまで

    // イニシャライザ（問題リスト編集の場合）
    init(questionListMode: QuestionListMode, questionList: QuestionList) {
        self.questionListMode = questionListMode
        self.questionList = questionList
        self.listName = questionList.listName ?? ""
    } // initここまで

    // 薬データをフェッチ
    func fetchListItems(from fetchedCustomMedicines: FetchedResults<CustomMedicine>) {
        // 薬データを取得
        model.fetchListItems(from: fetchedCustomMedicines)
        // 薬データを配列に格納
        oralListItems = model.listItems.filter { $0.category == .oral }
        injectionListItems = model.listItems.filter { $0.category == .injection }
        topicalListItems = model.listItems.filter { $0.category == .topical }
        customListItems = model.listItems.filter { $0.category == .custom }
    } // fetchListItems ここまで

    // 問題リストをCore Dataに保存するメソッド
    func saveQuestionList(context: NSManagedObjectContext) {
        // 内用薬、注射薬、外用薬、カスタムのデータを連結
        let allListItems = oralListItems + injectionListItems + topicalListItems + customListItems
        // 選択されているものを条件にフィルターする
        let filteredListItems = allListItems.filter { $0.selected == true }
        // 問題リスト作成モードの場合
        if questionListMode == .create {
            // 問題リストのインスタンスを生成
            let questionList = QuestionList(context: context)
            // questionListにデータを格納
            for listItem in filteredListItems {
                // 問題のインスタンスを生成
                let question = Question(context: context)
                // カテゴリ、商品名、一般名を保持
                question.category = listItem.category.rawValue
                question.brandName = listItem.brandName
                question.genericName = listItem.genericName
                // 作成した問題を問題リストに追加
                questionList.addToQuestions(question)
            } // for ここまで
            // リスト名を保持
            questionList.listName = listName
            // 作成した日付を保持
            questionList.createdDate = Date()
            // 問題数を保持
            questionList.numberOfQuestions = Int16(questionList.questions?.count ?? 0)
            do {
                // 問題リストをCore Dataに保存
                try context.save()
            } catch {
                // 何らかのエラーが発生した場合は、エラー内容をデバッグエリアに表示
                print("エラー: \(error)")
            } // do-try-catch ここまで
            // 問題リスト編集モードの場合
        } else {
            // 問題型の集合を作成
            var questionSet: Set<Question> = []
            // 選択されている問題を集合に格納
            for item in filteredListItems {
                // 問題のインスタンスを生成
                let question = Question(context: context)
                // カテゴリ、商品名、一般名を保持
                question.category = item.category.rawValue
                question.brandName = item.brandName
                question.genericName = item.genericName
                // 作成した問題を集合に追加
                questionSet.insert(question)
            } // for ここまで
            // 元の問題リストを上書き
            self.questionList.questions = questionSet as NSSet
            // リスト名を保持
            self.questionList.listName = listName
            // 作成した日付を保持
            self.questionList.createdDate = Date()
            // 問題数を保持
            self.questionList.numberOfQuestions = Int16(questionSet.count)
        } // if ここまで
    } // saveQuestionList ここまで

    // 問題を取得して、リストの配列にマージし、ソートするメソッド
    func mergeQuestionsToListItems() {
        // questionListから取り出した問題をMedicineItem型に変換
        let questions = (questionList.questions as? Set<Question> ?? [])
            .map({
                MedicineItem(category: MedicineCategory(rawValue: $0.category ?? "") ?? .custom,
                             brandName: $0.brandName ?? "",
                             genericName: $0.genericName ?? ""
                ) // MedicineItem ここまで
            }) // map ここまで
        // 各問題を該当するカテゴリの配列にマージする
        let mergedListItems = model.mergeQuestionsToListItems(questions: questions)
        // マージ後のデータをカテゴリ別に表示するために分配する
        oralListItems = mergedListItems.filter { $0.category == .oral }
        injectionListItems = mergedListItems.filter { $0.category == .injection }
        topicalListItems = mergedListItems.filter { $0.category == .topical }
        customListItems = mergedListItems.filter { $0.category == .custom }
        // 全ての配列をソート
        oralListItems.sort(by: { $0.brandName < $1.brandName })
        injectionListItems.sort(by: { $0.brandName < $1.brandName })
        topicalListItems.sort(by: { $0.brandName < $1.brandName })
        customListItems.sort(by: { $0.brandName < $1.brandName })
    } // mergeQuestionsToListItems ここまで
} // CreateQuestionListViewModel ここまで
