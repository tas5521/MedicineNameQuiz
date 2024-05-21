//
//  StudyView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct StudyView: View {
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) private var context
    // 学習中であるかを管理する変数
    @Binding var isStudying: Bool
    // 問題リストをフェッチ
    @FetchRequest(entity: QuestionList.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \QuestionList.createdDate, ascending: false)],
                  predicate: nil,
                  animation: nil
    ) private var fetchedLists: FetchedResults<QuestionList>

    // 出題に関する変数
    // 出題する問題
    @Binding var questions: [StudyItem]
    // モード選択を管理する変数
    let studyMode: StudyMode
    // 問題リストのID
    let questionListID: UUID
    // 問題番号を管理する変数
    @State private var questionNumber: Int = 0

    // View Presentation State
    // 結果画面の表示を管理する変数
    @State private var isShowResult: Bool = false

    // カードフリップに関する変数
    // カードがめくられているかを管理する変数
    @State private var isCardFlipped: Bool = false
    // カードのめくられた角度
    @State private var cardDegree: Double = 0.0
    // カードの面が表か裏か
    @State private var isFront: Bool = true
    // カードが半分めくられるまでの時間間隔
    private let duration: CGFloat = 0.1

    var body: some View {
        // 手前から奥にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
                // セーフエリア外にも背景を表示
                .ignoresSafeArea()
            // 垂直方向にレイアウト
            VStack {
                // バナー広告を配置
                AdMobBannerView()
                    // 幅高さを指定
                    .frame(width: 320, height: 50)
                    // 上下に余白を追加
                    .padding(.vertical)
                // 問題番号
                Text("\(questionNumber + 1)/\(questions.count)")
                    // フォントを.titleに変更
                    .font(.title)
                // スペースを空ける
                Spacer()
                // 奥から手前にレイアウト
                ZStack {
                    // カードを配置
                    flipCardView
                } // ZStack ここまで
                // スペースを空ける
                Spacer()
                // 水平方向にレイアウト
                HStack(spacing: 20) {
                    // 正解ボタン
                    AnswerButton(buttonType: .correct, action: {
                        // 現在の問題が正解であることを記録する
                        questions[questionNumber].studyResult = .correct
                        Task {
                            // 次の問題へ進むか、結果を表示
                            await advanceToNextQuestionOrShowResult()
                        } // Task ここまで
                    }) // 正解ボタン ここまで

                    // 不正解ボタン
                    AnswerButton(buttonType: .incorrect, action: {
                        // 現在の問題が不正解であることを記録する
                        questions[questionNumber].studyResult = .incorrect
                        Task {
                            // 次の問題へ進むか、結果を表示
                            await advanceToNextQuestionOrShowResult()
                        } // Task ここまで
                    }) // 不正解ボタン ここまで

                    // 一つ前の問題に戻るボタン
                    AnswerButton(buttonType: .back, action: {
                        Task {
                            // 前の問題に戻る
                            await goBackToPreviousQuestion()
                        } // Task ここまで
                    }) // 一つ前の問題に戻るボタン ここまで
                    .disabled(questionNumber <= 0)
                } // HStack ここまで
                // スペースを空ける
                Spacer()
            } // VStack ここまで
        } // ZStack ここまで
        // 画面が閉じられた時
        .onDisappear {
            // 学習結果を保存
            saveStudyResult()
        } // onDisappear ここまで
        // 問題を解く画面へ遷移
        .navigationDestination(isPresented: $isShowResult) {
            // 結果画面を表示
            ResultView(isStudying: $isStudying, questions: questions)
        } // navigationDestination ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("学習中", displayMode: .inline)
        // ナビゲーションバーの背景を変更
        .navigationBarBackground()
    } // body ここまで

    // 薬の名前の変数
    private var medicineName: String {
        switch studyMode {
        // 出題モードが「商品名 → 一般名」だったら、カードの表面に商品名を、裏面に一般名を表示
        case .brandToGeneric:
            isFront ? questions[questionNumber].brandName : questions[questionNumber].genericName
        // 出題モードが「一般名 → 商品名」だったら、カードの表面に一般名を、裏面に商品名を表示
        case .genericToBrand:
            isFront ? questions[questionNumber].genericName : questions[questionNumber].brandName
        } // switch ここまで
    } // medicineName ここまで

    // カードのView
    private var flipCardView: some View {
        // カードの幅
        let width: CGFloat = 260
        // カードの高さ
        let height: CGFloat = 180
        // ZStack を返す
        return ZStack {
            // 角の丸い長方形を配置
            RoundedRectangle(cornerRadius: 20)
                // 白で塗る
                .fill(.white)
                // 幅高さを指定
                .frame(width: width, height: height)
                // 影をつける
                .shadow(color: .gray, radius: 2, x: 0, y: 0)
            // 左上のテキストを表面ではQ、裏面ではAにする
            Text(isFront ? "Q.":"A.")
                // 太字にする
                .bold()
                // カードの左上に配置
                .offset(CGSize(width: -100, height: -60.0))
            // 薬の名前のテキスト
            Text(medicineName)
                // 太字にする
                .bold()
                // 幅高さを指定
                .frame(width: width - 50, height: height - 50)
        } // ZStack ここまで
        // 文字の色を表面では黒、裏面では赤にする
        .foregroundStyle(isFront ? .black : .red)
        // 回転エフェクトをつける
        .rotation3DEffect(Angle(degrees: cardDegree), axis: (x: 0, y: 1, z: 0))
        // タップされたら
        .onTapGesture {
            Task {
                // カードをめくる
                await flipCard()
            } // Task ここまで
        } // onTapGesture ここまで
    } // flipCardView ここまで

    // カードをめくるメソッド
    private func flipCard() async {
        // カードがめくられているか、めくられていないかを、切り替え
        isCardFlipped.toggle()
        // カードを半分めくるアニメーション
        withAnimation(.linear(duration: duration)) {
            cardDegree = isCardFlipped ? 90 : 270
        } // withAnimation ここまで
        do {
            // カードが半分めくられるまで待つ
            try await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
        } catch {
            // デバッグエリアにエラーメッセージを表示
            print("Error: \(error)")
        } // do-try-catch ここまで
        // カードのめくられた角度を一気に180°回して文字の向きを表面に合わせる
        cardDegree = isCardFlipped ? 270 : 90
        // 表面と裏面を切り替え
        isFront.toggle()
        // カードを半分めくるアニメーション
        withAnimation(.linear(duration: duration)) {
            cardDegree = isCardFlipped ? 360 : 0
        } // withAnimation ここまで
    } // flipCard ここまで

    // 次の問題へ進むか、結果を表示
    private func advanceToNextQuestionOrShowResult() async {
        // もし最後の問題だったら
        if questionNumber >= questions.count - 1 {
            // 結果画面を表示
            isShowResult.toggle()
            // もし最後の問題でなかったら
        } else {
            // カードをめくり、指定した時間待機する
            await flipCardAndWait()
            // 次の問題へ
            questionNumber += 1
        } // if ここまで
    } // advanceToNextQuestionOrShowResult ここまで

    // 前の問題に戻る処理
    private func goBackToPreviousQuestion() async {
        // カードをめくり、指定した時間待機する
        await flipCardAndWait()
        // 一つ前の問題に戻る
        questionNumber -= 1
    } // goBackToPreviousQuestion ここまで

    // カードをめくり、指定した時間待機する
    private func flipCardAndWait() async {
        // カードがめくられていたら
        if isCardFlipped {
            // カードをめくる（元に戻す）
            await flipCard()
        } // if ここまで
    } // flipCardAndWait ここまで

    // 学習結果を保存するメソッド
    private func saveStudyResult() {
        // 問題リストの配列から該当するUUIDの問題のindexを取得
        guard let index = fetchedLists.firstIndex(where: { $0.id == questionListID }) else { return }
        // 該当のIndexの問題リストから問題を取得
        guard let fetchedQuestions = fetchedLists[index].questions as? Set<Question> else { return }
        // 学習結果を問題に保持する
        for studyItem in questions {
            if let index = fetchedQuestions.firstIndex(where: { $0.id == studyItem.id }) {
                fetchedQuestions[index].studyResult = studyItem.studyResult.rawValue
            } // if let ここまで
        } // for ここまで
        // 学習結果を保持した問題で、元の問題を上書き
        fetchedLists[index].questions = fetchedQuestions as NSSet
        do {
            // 問題リストをCore Dataに保存
            try context.save()
        } catch {
            // 何らかのエラーが発生した場合は、エラー内容をデバッグエリアに表示
            print("エラー: \(error)")
        } // do-try-catch ここまで
    } // saveStudyResult ここまで
} // StudyView ここまで

#Preview {
    // ダミーの問題
    let dummyQuestions: [StudyItem] = [
        StudyItem(category: .oral,
                  brandName: "ダミーの商品名",
                  genericName: "ダミーの一般名",
                  studyResult: .incorrect)
    ] // dummyStudyItem ここまで
    return StudyView(isStudying: .constant(true),
                     questions: .constant(dummyQuestions),
                     studyMode: .brandToGeneric,
                     questionListID: UUID())
}
