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
    // 問題リストを作成するか編集するかを管理する変数
    let questionListMode: QuestionListMode

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

    // View Presentation State
    // リストに名前が無い時に表示するアラートを管理する変数
    var isShowNoListNameAlert: Bool = false
    // 問題が一つも選択されていない場合に表示するアラートを管理する変数
    var isShowNoQuestionAlert: Bool = false

    // 問題リストを保持する変数
    private var questionList: QuestionList = QuestionList()

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
        let fetchedListItems = CreateQuestionListModel.fetchListItems(from: fetchedCustomMedicines)
        // 薬データを配列に格納
        oralListItems = fetchedListItems.filter { $0.category == .oral }
        injectionListItems = fetchedListItems.filter { $0.category == .injection }
        topicalListItems = fetchedListItems.filter { $0.category == .topical }
        customListItems = fetchedListItems.filter { $0.category == .custom }
    } // fetchListItems ここまで

    // 問題リストをCore Dataに保存するメソッド
    func saveQuestionList(context: NSManagedObjectContext, dismiss: DismissAction) {
        // もしリスト名がない場合
        if listName.isEmpty {
            // リスト名がない警告を表示
            isShowNoListNameAlert.toggle()
            return
        } // if ここまで
        // 内用薬、注射薬、外用薬、カスタムのデータを連結
        let allListItems = oralListItems + injectionListItems + topicalListItems + customListItems
        // 選択されているものを条件にフィルターする
        let filteredListItems = allListItems.filter { $0.selected == true }
        // もし選択されている問題がない場合
        if filteredListItems.isEmpty {
            isShowNoQuestionAlert.toggle()
            return
        } // if ここまで
        // 問題リスト作成モードの場合
        switch questionListMode {
        case .create:
            // 問題リストのインスタンスを生成
            let questionList = QuestionList(context: context)
            // questionListにデータを格納
            for listItem in filteredListItems {
                // 問題のインスタンスを生成
                let question = Question(context: context)
                // カテゴリ、商品名、一般名、問題IDを保持
                question.category = listItem.category.rawValue
                question.brandName = listItem.brandName
                question.genericName = listItem.genericName
                question.id = listItem.id
                // 作成した問題を問題リストに追加
                questionList.addToQuestions(question)
            } // for ここまで
            // リスト名を保持
            questionList.listName = listName
            // 作成した日付を保持
            questionList.createdDate = Date()
            // 問題数を保持
            questionList.numberOfQuestions = Int16(questionList.questions?.count ?? 0)
            // 問題リストを一意に識別するIDを保持
            questionList.id = UUID()
        // 問題リスト編集モードの場合
        case .edit:
            // Question型の集合を作成
            var questionSet: Set<Question> = []
            // 問題を取得
            guard let questions = questionList.questions as? Set<Question> else { return }
            // 選択されている問題を集合に格納
            for item in filteredListItems {
                // 問題のインスタンスを生成
                let question = Question(context: context)
                // カテゴリ、商品名、一般名、IDを保持
                question.category = item.category.rawValue
                question.brandName = item.brandName
                question.genericName = item.genericName
                question.id = item.id
                // 該当する問題がある場合
                if let index = questions.firstIndex(where: {
                    $0.category == item.category.rawValue &&
                        $0.brandName == item.brandName &&
                        $0.genericName == item.genericName
                }) {
                    // 学習結果を保持
                    question.studyResult = questions[index].studyResult
                } else {
                    // 該当する問題がない場合、「まだ解いていない」という状態を保持
                    question.studyResult = StudyResult.unanswered.rawValue
                } // if let ここまで
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
        } // switch ここまで
        do {
            // 問題リストをCore Dataに保存
            try context.save()
            // 保存が正常に完了したら、画面を閉じる
            dismiss()
        } catch {
            // 何らかのエラーが発生した場合は、エラー内容をデバッグエリアに表示
            print("エラー: \(error)")
        } // do-try-catch ここまで
    } // saveQuestionList ここまで

    // 問題を取得して、リストの配列にマージするメソッド
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
        // マージ後のデータをカテゴリ別に表示するために分配する
        // カテゴリ別にすることで、mergeQuestions内のループ部分でcategoryが一致しないもの同士の比較が行われなくなり、ループ回数を省ける。
        // 内用薬
        let oralQuestions = questions.filter { $0.category == .oral }
        self.mergeQuestions(to: &oralListItems, with: oralQuestions)
        oralListItems.sort(by: { $0.brandName < $1.brandName })
        // 注射薬
        let injectionQuestions = questions.filter { $0.category == .injection }
        self.mergeQuestions(to: &injectionListItems, with: injectionQuestions)
        injectionListItems.sort(by: { $0.brandName < $1.brandName })
        // 外用薬
        let topicalQuestions = questions.filter { $0.category == .topical }
        self.mergeQuestions(to: &topicalListItems, with: topicalQuestions)
        topicalListItems.sort(by: { $0.brandName < $1.brandName })
        // カスタム
        let customQuestions = questions.filter { $0.category == .custom }
        self.mergeQuestions(to: &customListItems, with: customQuestions)
        customListItems.sort(by: { $0.brandName < $1.brandName })
    } // mergeQuestionsToListItems ここまで

    // 選択されている問題を該当するカテゴリの配列にマージする
    /// 同じ商品名・一般名のデータが見つかり、かつ、選択されていない場合、薬リストのデータの該当する問題のselectedプロパティをtrueに変更します。
    /// もし、商品名・一般名が一致するデータが見つからなかった場合、そのデータは、「過去にCoreDataに保存する時には存在したが、
    /// 今は薬リストのデータに無いデータ」なので、このデータをselectedプロパティをtrueにして薬リストに追加します。
    private func mergeQuestions(to listItems: inout [MedicineListItem], with questions: [MedicineItem]) {
        for question in questions {
            // 条件に一致する最初の要素を取得
            if let index = listItems.firstIndex(where: {
                // 商品名・一般名が一致する要素を探す
                $0.brandName == question.brandName && $0.genericName == question.genericName
            }) {
                // 該当する問題のselectedプロパティをtrueに変更
                listItems[index].selected = true
            } else {
                // 商品名・一般名が一致するデータが見つからなかった場合、このデータをselectedプロパティをtrueにして薬リストに追加
                let newItem = MedicineListItem(category: question.category,
                                               brandName: question.brandName,
                                               genericName: question.genericName,
                                               selected: true)
                listItems.append(newItem)
            } // if let ここまで
        } // for ここまで
    } // mergeQuestions ここまで
} // CreateQuestionListViewModel ここまで
