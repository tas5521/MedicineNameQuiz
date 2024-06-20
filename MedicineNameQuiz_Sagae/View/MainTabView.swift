//
//  MainTabView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct MainTabView: View {
    // タブの選択項目を保持する変数
    @State private var tabSelection: TabSelection = .study

    // 問題リストをフェッチ
    @FetchRequest(entity: QuestionList.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \QuestionList.createdDate, ascending: false)],
                  predicate: nil,
                  animation: nil
    ) private var fetchedLists: FetchedResults<QuestionList>

    var body: some View {
        // タブを配置
        TabView(selection: $tabSelection) {
            // タブの項目をグループにまとめる
            Group {
                // 項目をグループにまとめる
                Group {
                    // 問題リストがない場合
                    if fetchedLists.isEmpty {
                        // 導入画面のViewを配置
                        IntroductionView(tabSelection: $tabSelection)
                        // 問題リストがある場合
                    } else {
                        // 学習画面のViewを配置
                        ModeSelectionView()
                    } // if ここまで
                } // Group ここまで
                .tabItem {
                    Label(TabSelection.study.rawValue, systemImage: "book.fill")
                } // tabItem ここまで
                .tag(TabSelection.study)

                // 項目をグループにまとめる
                Group {
                    // 問題リストがない場合
                    if fetchedLists.isEmpty {
                        // 問題リストの作成を促す画面のViewを配置
                        PromptToCreateQuestionListView()
                    } else {
                        // 問題リスト画面のViewを配置
                        QuestionListView()
                    } // if ここまで
                } // Group ここまで
                .tabItem {
                    Label(TabSelection.questionList.rawValue, systemImage: "square.and.pencil")
                } // tabItem ここまで
                .tag(TabSelection.questionList)

                // 薬リスト画面のViewを配置
                MedicineListView()
                    .tabItem {
                        Label(TabSelection.medicineList.rawValue, systemImage: "list.bullet.rectangle.portrait.fill")
                    } // tabItem ここまで
                    .tag(TabSelection.medicineList)

                // 設定画面のViewを配置
                SettingsListView()
                .tabItem {
                    Label(TabSelection.settings.rawValue, systemImage: "gearshape.fill")
                } // tabItem ここまで
                .tag(TabSelection.settings)
            } // Group ここまで
            // タブの背景を青色に変更
            .toolbarBackground(.tabBlue, for: .tabBar)
            // タブの背景を表示
            .toolbarBackground(.visible, for: .tabBar)
            // タブ外観をダークに設定
            .toolbarColorScheme(.dark, for: .tabBar)
        } // TabView ここまで
    } // body ここまで
} // MainTabView ここまで

#Preview {
    MainTabView()
}
