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
        } // selectedListItems ここまで
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

    // CreateQuestionListModelのインスタンスを生成
    private let model = CreateQuestionListModel()

    // 薬データをフェッチ
    func fetchListItems(from fetchedCustomMedicines: FetchedResults<CustomMedicine>) {
        // 薬データを取得
        let fetchedListItems = model.fetchListItems(from: fetchedCustomMedicines)
        // 薬データを配列に格納
        oralListItems = fetchedListItems.filter { $0.category == .oral }
        injectionListItems = fetchedListItems.filter { $0.category == .injection }
        topicalListItems = fetchedListItems.filter { $0.category == .topical }
        customListItems = fetchedListItems.filter { $0.category == .custom }
    } // fetchListItems ここまで

    // 問題リストをCore Dataに保存するメソッド
    func saveQuestionList(context: NSManagedObjectContext) {
        // 内用薬、注射薬、外用薬、カスタムのデータを連結
        let allListItems = oralListItems + injectionListItems + topicalListItems + customListItems
        // 選択されているものを条件にフィルターする
        let filteredListItems = allListItems.filter { $0.selected == true }
        // 問題リストのインスタンスを生成
        let questionList = QuestionList(context: context)
        // リスト名を保持
        questionList.listName = listName
        // 作成した日付を保持
        questionList.createdDate = Date()
        // questionSetにデータを格納
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
        // 問題数を保持
        questionList.numberOfQuestions = Int16(questionList.questions?.count ?? 0)
        do {
            // 問題リストをCore Dataに保存
            try context.save()
        } catch {
            // 何らかのエラーが発生した場合は、エラー内容をデバッグエリアに表示
            print("エラー: \(error)")
        } // do-try-catch ここまで
    } // saveQuestionList ここまで
} // CreateQuestionListViewModel ここまで
