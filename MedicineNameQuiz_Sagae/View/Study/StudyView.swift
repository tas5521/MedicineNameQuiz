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
    @State private var isFlipped: Bool = false
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
        ("ウリトス", "イミダフェナシン")
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
                    // カードがめくられていたら、元に戻す（ただし、最後の問題だったら、フリップしない）
                    if isFlipped && questionNumber != medicineNames.count - 1 {
                        // カードをめくる
                        flipCard()
                    } // if ここまで
                    // カードが半分めくられるまで待つ
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        // 次の問題へ
                        questionNumber += 1
                        // もし、最後の問題だったら
                        if questionNumber == medicineNames.count {
                            // クラッシュしないよう、numberを1減らす
                            questionNumber -= 1
                            // 結果画面を表示
                            isShowResultView.toggle()
                        } // if ここまで
                    } // DispatchQueue ここまで
                }) // 正解ボタン ここまで
                
                // 不正解ボタン
                AnswerButton(answerButtonType: .incorrect, action: {
                    // カードがめくられていたら、元に戻す（ただし、最後の問題だったら、フリップしない）
                    if isFlipped && questionNumber != medicineNames.count - 1 {
                        // カードをめくる
                        flipCard()
                    } // if ここまで
                    // カードが半分めくられるまで待つ
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        // 次の問題へ
                        questionNumber += 1
                        // もし、最後の問題だったら
                        if questionNumber == medicineNames.count {
                            // クラッシュしないよう、numberを1減らす
                            questionNumber -= 1
                            // 結果画面を表示
                            isShowResultView.toggle()
                        } // if ここまで
                    } // DispatchQueue ここまで
                }) // 不正解ボタン ここまで
                
                // 一つ前の問題に戻るボタン
                AnswerButton(answerButtonType: .back, action: {
                    // カードがめくられていたら、元に戻す
                    if isFlipped {
                        // カードをめくる
                        flipCard()
                    } // if ここまで
                    // カードが半分めくられるまで待つ
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        // 一つ前の問題に戻る
                        questionNumber -= 1
                        // 問題番号が0未満の時
                        if questionNumber < 0 {
                            // クラッシュを避けるため、問題番号を0にする
                            questionNumber = 0
                        } // if ここまで
                    } // DispatchQueue ここまで
                }) // 一つ前の問題に戻るボタン ここまで
            } // HStack ここまで
            // スペースを空ける
            Spacer()
        } // VStack ここまで
        // 学習終了時に、必ず、カードを元の面に戻す
        .onDisappear {
            // カードがめくられていたら、元に戻す
            if isFlipped {
                // カードをめくる
                flipCard()
            } // if ここまで
        } // onDisappear ここまで
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
        // 垂直方向にレイアウト
        VStack {
            // 奥から手前にレイアウト
            ZStack {
                // 裏面
                createCardFace(text: backText, isFront: false)
                // 表面
                createCardFace(text: frontText, isFront: true)
            } // ZStack ここまで
            // タップされたら
            .onTapGesture {
                // カードをめくる
                flipCard()
            } // onTapGesture ここまで
        } // VStack ここまで
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
    private func flipCard() {
        // カードがめくられているか、めくられていないかを、切り替え
        isFlipped.toggle()
        // もしカードがめくられたら
        if isFlipped {
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
} // StudyView ここまで

#Preview {
    StudyView(isStudying: .constant(true))
}
