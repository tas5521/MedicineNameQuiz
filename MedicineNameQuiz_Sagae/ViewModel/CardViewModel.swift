//
//  CardViewModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/11/21.
//

import SwiftUI

@Observable
class CardViewModel {
    // シングルトン化
    static let shared: CardViewModel = CardViewModel()
    // カードがめくられているかを管理する変数
    var isFlipped: Bool = false
    // カードの表面についての、めくられた角度
    var frontDegree: Double = 0.0
    // カードの裏面についての、めくられた角度
    var backDegree: Double = -90.0
    // カードが半分めくられるまでの時間間隔
    var duration : CGFloat = 0.1
    // ダミーの問題
    let medicineNames: [(front: String, back: String)] = [
        ("アムロジン", "アムロジピンベシル酸塩"),
        ("インフリー", "インドメタシン　ファルネシル"),
        ("ウリトス", "イミダフェナシン")
    ] // medicineNames ここまで

    // カードをめくるメソッド
    func flipCard() {
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
} // CardViewModel ここまで
