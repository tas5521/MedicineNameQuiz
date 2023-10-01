//
//  QuestionListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct QuestionListView: View {
    var dummyList: [QuestionListItem] = [
        QuestionListItem(listName: "さがえ薬局リスト",
                         date: Date(),
                         questions: [Question(originalName: "アムロジン", genericName: "アムロジピンべシル酸塩"),
                                    Question(originalName: "エバステル", genericName: "エバスチン"),
                                    Question(originalName: "オノン", genericName: "プランルカスト水和物")]
                        ),
        QuestionListItem(listName: "ながつ薬局リスト",
                         date: Date(),
                         questions: [Question(originalName: "ガスター", genericName: "ファモチジン"),
                                     Question(originalName: "キプレス", genericName: "モンテルカストナトリウム"),
                                     Question(originalName: "クラビット", genericName: "レボフロキサシン水和物")]
                        ),
        QuestionListItem(listName: "こばやし薬局リスト",
                         date: Date(),
                         questions: [Question(originalName: "インフリー", genericName: "インドメタシン　ファルネシル"),
                                     Question(originalName: "ウリトス", genericName: "イミダフェナシン"),
                                     Question(originalName: "ケフラール", genericName: "セファクロル")]
                        )
    ]
    
    var body: some View {
        ZStack {
            VStack {
                Text("問題リスト検索")
                List {
                    ForEach(dummyList) { item in
                        NavigationLink {
                            QuestionListRowView(listName: item.listName, questions: item.questions)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(item.listName)
                                HStack {
                                    Text("\(item.date.formatted(date: .long, time: .omitted))")
                                    Spacer()
                                    Text("問題数: \(item.questions.count)")
                                } // HStack ここまで
                            } // VStack ここまで
                            .bold()
                        } // NavigationLink ここまで
                    } // ForEach ここまで
                } // List ここまで
                .listStyle(.grouped)
            } // VStack ここまで
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink {
                        CreateQuestionListView()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 65, height: 65)
                            .foregroundStyle(Color.customOrange)
                            .background(Color.white)
                            .clipShape(Circle())
                    } // Button ここまで
                    .padding()
                } // HStack ここまで
            } // VStack ここまで
        } // ZStack ここまで
    } // body ここまで
} // QuestionListView ここまで

#Preview {
    QuestionListView()
}
