//
//  CardView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/11/21.
//

import SwiftUI

struct CardView: View {
    // 表面のテキスト
    let frontText: String
    // 裏面のテキスト
    let backText: String
    // CardViewModelのインスタンス
    private let cardViewModel: CardViewModel = CardViewModel.shared
    
    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // 奥から手前にレイアウト
            ZStack {
                // 裏面
                face(text: backText, isFront: false)
                // 表面
                face(text: frontText, isFront: true)
            } // ZStack ここまで
            .onTapGesture {
                cardViewModel.flipCard()
            } // onTapGesture ここまで
        } // VStack ここまで
    } // body ここまで
    
    // カードの面のView
    private func face(text: String, isFront: Bool) -> some View {
        // カードの幅
        let width : CGFloat = 260
        // カードの高さ
        let height : CGFloat = 180
        return ZStack {
            // 角の丸い長方形を配置
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: width, height: height)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)
            Text(isFront ? "Q.":"A.")
                .bold()
                .foregroundStyle(isFront ? .black : .red)
                .offset(CGSize(width: -100, height: -60.0))
            Text(text)
                .bold()
                .foregroundStyle(isFront ? .black : .red)
                .frame(width: width - 50, height: height - 50)
                .foregroundColor(.black)
        } // ZStack ここまで
        .rotation3DEffect(
            Angle(degrees: isFront ? cardViewModel.frontDegree : cardViewModel.backDegree),
            axis: (x: 0, y: 1, z: 0)
        )
    } // face ここまで
} // CardViewここまで

#Preview {
    CardView(frontText: "アムロジン", backText: "アムロジピンベシル酸塩")
}
