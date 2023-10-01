//
//  StudyingView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct StudyingView: View {
    @Binding var isStartStudy: Bool
    
    var body: some View {
        VStack {
            Text("問題画面\n(問題を解き進めるロジックは後で実装)")
            NavigationLink {
                ResultView(isStartStudy: $isStartStudy)
            } label: {
                Text("全問解き終わった時の遷移先")
                    .foregroundColor(Color.blue)
            }
        }
        .navigationBarTitle("学習", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // StudyingViewを閉じる
                    isStartStudy = false
                } label: {
                    Text("終了")
                }
                .foregroundColor(.blue)
            }
        }
    }
}

#Preview {
    StudyingView(isStartStudy: .constant(true))
}
