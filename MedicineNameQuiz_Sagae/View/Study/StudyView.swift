//
//  StudyView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct StudyView: View {
    // 学習中であるかを管理する変数
    @Binding var isStudying: Bool
    // 問題番号を管理する変数
    @State private var questionNumber: Int = 0
    
    // View Presentation State
    // 結果画面の表示を管理する変数
    @State private var isShowResultView: Bool = false
    
    // カードフリップに関する変数
    // カードがめくられているかを管理する変数
    @State private var isCardFlipped: Bool = false
    // カードの表面についての、めくられた角度
    @State private var frontDegree: Double = 0.0
    // カードの裏面についての、めくられた角度
    @State private var backDegree: Double = -90.0
    // カードが半分めくられるまでの時間間隔
    private let duration : CGFloat = 0.1
    
    // ダミーの問題
    private let medicineNames: [(front: String, back: String)] = [
        ("アムロジン", "アムロジピンベシル酸塩"),
        ("インフリー", "インドメタシン　ファルネシル"),
        ("ウリトス", "イミダフェナシン"),
        ("ティーエスワン", "テガフール・ギメラシル・オテラシルカリウム")
    ] // medicineNames ここまで
    
    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // スペースを空ける
            Spacer()
            // 問題番号
            Text("\(questionNumber + 1)/\(medicineNames.count)")
            // フォントを.titleに変更
                .font(.title)
            // スペースを空ける
            Spacer()
            // カードのViewを配置
            cardView(frontText: medicineNames[questionNumber].front,
                     backText: medicineNames[questionNumber].back)
            // スペースを空ける
            Spacer()
            // 水平方向にレイアウト
            HStack(spacing: 20) {
                // 正解ボタン
                AnswerButton(answerButtonType: .correct, action: {
                    // TODO: 現在の問題が正解であることを記録する処理を実装
                    Task {
                        // 次の問題へ進むか、結果を表示
                        await advanceToNextQuestionOrShowResult()
                    } // Task ここまで
                }) // 正解ボタン ここまで
                
                // 不正解ボタン
                AnswerButton(answerButtonType: .incorrect, action: {
                    // TODO: 現在の問題が不正解であることを記録する処理を実装
                    Task {
                        // 次の問題へ進むか、結果を表示
                        await advanceToNextQuestionOrShowResult()
                    } // Task ここまで
                }) // 不正解ボタン ここまで
                
                // 一つ前の問題に戻るボタン
                AnswerButton(answerButtonType: .back, action: {
                    Task {
                        // 前の問題に戻る
                        await goBackToPreviousQuestion()
                    } // Task ここまで
                }) // 一つ前の問題に戻るボタン ここまで
                .disabled(questionNumber == 0)
            } // HStack ここまで
            // スペースを空ける
            Spacer()
        } // VStack ここまで
        // 問題を解く画面へ遷移
        .navigationDestination(isPresented: $isShowResultView) {
            // 結果画面を表示
            ResultView(isStudying: $isStudying)
        } // navigationDestination ここまで
        // ナビゲーションバータイトルを指定
        .navigationBarTitle("学習中", displayMode: .inline)
    } // body ここまで
    
    // カードのView
    private func cardView(frontText: String, backText: String) -> some View {
        // 奥から手前にレイアウト
        ZStack {
            // 裏面
            createCardFace(text: backText, isFront: false)
            // 表面
            createCardFace(text: frontText, isFront: true)
        } // ZStack ここまで
        // タップされたら
        .onTapGesture {
            Task {
                // カードをめくる
                await flipCard()
            } // Task ここまで
        } // onTapGesture ここまで
    } // cardView ここまで
    
    // カードの面を生成するメソッド
    private func createCardFace(text: String, isFront: Bool) -> some View {
        // カードの幅
        let width : CGFloat = 260
        // カードの高さ
        let height : CGFloat = 180
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
            Text(text)
            // 太字にする
                .bold()
            // 幅高さを指定
                .frame(width: width - 50, height: height - 50)
        } // ZStack ここまで
        // 文字の色を表面では黒、裏面では赤にする
        .foregroundStyle(isFront ? .black : .red)
        // 回転エフェクトをつける
        .rotation3DEffect(
            Angle(degrees: isFront ? frontDegree : backDegree), axis: (x: 0, y: 1, z: 0)
        )
    } // createCardFace ここまで
    
    // カードをめくるメソッド
    private func flipCard() async {
        // カードがめくられているか、めくられていないかを、切り替え
        isCardFlipped.toggle()
        // もしカードがめくられたら
        if isCardFlipped {
            // アニメーションで、カードの表面についての、めくられた角度を90度にする
            withAnimation(.linear(duration: duration)) {
                frontDegree = 90
            } // withAnimation ここまで
            // アニメーションで、カードの裏面についての、めくられた角度を0度にする
            withAnimation(.linear(duration: duration).delay(duration)){
                backDegree = 0
            } // withAnimation ここまで
        } else {
            // アニメーションで、カードの裏面についての、めくられた角度を-90度にする
            withAnimation(.linear(duration: duration)) {
                backDegree = -90
            } // withAnimation ここまで
            // アニメーションで、カードの表面についての、めくられた角度を0度にする
            withAnimation(.linear(duration: duration).delay(duration)){
                frontDegree = 0
            } // withAnimation ここまで
        } // if ここまで
    } // flipCard ここまで
    
    // 次の問題へ進むか、結果を表示
    private func advanceToNextQuestionOrShowResult() async {
        // もし最後の問題だったら
        if questionNumber == medicineNames.count - 1 {
            // 結果画面を表示
            isShowResultView.toggle()
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
            do {
                // カードが半分めくられるまで待つ
                try await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
            } catch {
                // デバッグエリアにエラーメッセージを表示
                print("Error: \(error)")
            } // do-try-catch ここまで
        } // if ここまで
    } // flipCardAndWait ここまで
} // StudyView ここまで

#Preview {
    StudyView(isStudying: .constant(true))
}
