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
        do {
            // 問題リストをCore Dataに保存
            try context.save()
        } catch {
            // 何らかのエラーが発生した場合は、エラー内容をデバッグエリアに表示
            print("エラー: \(error)")
        } // do-try-catch ここまで
    } // saveQuestionList ここまで

    // 選択されている問題をリストに表示する配列にマージするメソッド
    /// ＜想定しているデータのマージのルール＞
    /// CSVから内用薬、注射薬、外用薬のデータを、CoreDataからカスタムのデータを取得し、MeidicineListItem型にして、selectedプロパティを全てfalseにします。ここでは、これを「薬リストのデータ」と呼びます（このデータは可変です。この後の説明でselectedの値がtrueに変わったり、要素が追加されたりします）。
    /// 「CoreDataに保存されている問題」を取得します。このデータは、既に選択されているものなので、薬リストのデータにマージした後には、これらのデータに該当する項目のselectedプロパティはtrueになります。
    /// マージの方法について説明します。CoreDataに保存されている問題の薬のカテゴリ（内用薬など）および商品名・一般名の情報を取得します。次に、その薬のカテゴリで絞って、薬リストのデータの中に同じ商品名・一般名のデータがあるかどうか探索します。同じ商品名・一般名のデータが見つかった場合、薬リストのデータの該当する問題のselectedプロパティをtrueに変更します。探索は、1つの問題につき、薬リストのデータ内に該当するデータが1件見つかり次第終了します。この処理を全ての問題について行います。なお、内用薬、注射薬、外用薬では、同じカテゴリのデータに同じ商品名のデータは存在しません。しかし、カスタムではユーザーが同じ商品名・一般名のデータを複数作ることができる（これは許容します）ので、商品名と一般名の両方が一致するものが見つかった場合、selectedプロパティをtrueに変更します。また、商品名と一般名の両方が一致するものが複数見つかる可能性もありますが、ここでも該当するデータが1件見つかり次第終了することで、回避します。
    /// もし、商品名と一般名が一致するデータが見つからなかった場合、そのデータは、「過去にCoreDataに保存する時には存在したが、今は薬リストのデータに無いデータ」なので、このデータをselectedプロパティをtrueにして薬リストに追加します。
    /// マージされた薬リストのデータをCreateQuestionListViewに表示します。
    func mergeSelectedQuestions() {
        // questionListから取り出した問題をMedicineItem型に変換
        let questions = (questionList.questions as? Set<Question> ?? [])
            .map({
                MedicineItem(category: MedicineCategory(rawValue: $0.category ?? "") ?? .custom,
                             brandName: $0.brandName ?? "",
                             genericName: $0.genericName ?? ""
                ) // MedicineItem ここまで
            }) // map ここまで
        // 各問題を該当するカテゴリの配列にセットする
        for question in questions {
            switch question.category {
            case .oral:
                setSelectedQuestion(to: &oralListItems, question: question)
            case .injection:
                setSelectedQuestion(to: &injectionListItems, question: question)
            case .topical:
                setSelectedQuestion(to: &topicalListItems, question: question)
            case .custom:
                setSelectedQuestion(to: &customListItems, question: question)
            } // switch ここまで
        } // for ここまで
        // 全ての配列をソート
        oralListItems.sort(by: { $0.brandName < $1.brandName })
        injectionListItems.sort(by: { $0.brandName < $1.brandName })
        topicalListItems.sort(by: { $0.brandName < $1.brandName })
        customListItems.sort(by: { $0.brandName < $1.brandName })
    } // mergeSelectedQuestions ここまで

    // 選択されている問題を該当するカテゴリの配列にセットする
    private func setSelectedQuestion(to listItems: inout [MedicineListItem], question: MedicineItem) {
        for index in 0...listItems.count {
            // questionと商品名が一致するlistItemがなかった場合
            if index == listItems.count {
                // その問題を該当するカテゴリの配列に追加する
                let additionalQuestion = MedicineListItem(category: question.category,
                                                          brandName: question.brandName,
                                                          genericName: question.genericName,
                                                          selected: true)
                listItems.append(additionalQuestion)
                return
            } // if ここまで
            // listItemとquestionの商品名と一般名が一致したら通過。一致しなければ次のループへ
            guard listItems[index].brandName == question.brandName &&
                    listItems[index].genericName == question.genericName
            else { continue }
            // まだlistItems内の問題が選択されていなかったら通過。選択されていれば、次のループへ
            guard listItems[index].selected == false else { continue }
            // 問題を選択された状態にし、ループを終了
            listItems[index].selected = true
            break
        } // for ここまで
    } // setSelectedQuestion ここまで
} // CreateQuestionListViewModel ここまで
