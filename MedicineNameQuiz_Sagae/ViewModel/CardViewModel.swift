//
//  CardViewModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/11/21.
//

import SwiftUI

@Observable
class CardViewModel {
    static let shared: CardViewModel = CardViewModel()
    var isFlipped: Bool = false
    var frontDegree: Double = 0.0
    var backDegree: Double = -90.0
    var duration : CGFloat = 0.1
    let medicineNames: [(front: String, back: String)] = [
        ("アムロジン", "アムロジピンベシル酸塩"),
        ("インフリー", "インドメタシン　ファルネシル"),
        ("ウリトス", "イミダフェナシン")
    ]

    // カードをめくるメソッド
    func flipCard() {
        isFlipped.toggle()
        if isFlipped {
            withAnimation(.linear(duration: duration)) {
                frontDegree = 90
            } // withAnimation ここまで
            withAnimation(.linear(duration: duration).delay(duration)){
                backDegree = 0
            } // withAnimation ここまで
        } else {
            withAnimation(.linear(duration: duration)) {
                backDegree = -90
            } // withAnimation ここまで
            withAnimation(.linear(duration: duration).delay(duration)){
                frontDegree = 0
            } // withAnimation ここまで
        } // if ここまで
    } // flipCard ここまで
} // CardViewModel ここまで
