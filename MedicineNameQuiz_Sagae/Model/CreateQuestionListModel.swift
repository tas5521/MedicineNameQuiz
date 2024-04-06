//
//  CreateQuestionListModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/02/23.
//

import SwiftUI

final class CreateQuestionListModel {
    // 薬データをフェッチ
    static func fetchListItems(from fetchedCustomMedicines: FetchedResults<CustomMedicine>) -> [MedicineListItem] {
        // CSVの薬データを取得
        let csvListItems = CSVLoader.loadCsvFile(resourceName: "MedicineNameList")
            // カンマ（,）で分割した配列を作成
            .map { $0.components(separatedBy: ",") }
            // MedicineListItem構造体にする
            .compactMap {
                MedicineListItem(category: MedicineCategory.getCategory(from: $0[1]),
                                 brandName: $0[2],
                                 genericName: $0[3],
                                 selected: false)
            }
        // カスタムの薬データを取得
        let customListItems = fetchedCustomMedicines
            // MedicineListItem構造体にする
            .compactMap {
                MedicineListItem(category: MedicineCategory.getCategory(from: $0.category ?? ""),
                                 brandName: $0.brandName ?? "",
                                 genericName: $0.genericName ?? "",
                                 selected: false)
            }
        // 薬のデータを返却
        return csvListItems + customListItems
    } // fetchListItems ここまで

    // 選択されている問題を該当するカテゴリの配列にマージする
    /// 薬のカテゴリで絞って、薬リストのデータの中に同じ商品名・一般名のデータがあるかどうか探索します。
    /// 同じ商品名・一般名のデータが見つかった場合、薬リストのデータの該当する問題のselectedプロパティをtrueに変更します。
    /// 探索は、1つの問題につき、薬リストのデータ内に該当するデータが1件見つかり次第終了します。
    /// 商品名・一般名の両方が一致するものが複数見つかる可能性もありますが、該当データが1件見つかり次第終了することで、
    /// 複数選択されるのを回避します。
    /// もし、商品名・一般名が一致するデータが見つからなかった場合、そのデータは、「過去にCoreDataに保存する時には存在したが、
    /// 今は薬リストのデータに無いデータ」なので、このデータをselectedプロパティをtrueにして薬リストに追加します。
    static func mergeQuestions(to listItems: inout [MedicineListItem], with questions: [MedicineItem]) {
        for question in questions {
            // listItemとquestionの商品名と一般名が一致する最初の要素のインデックスを探す
            if let index = listItems.firstIndex(
                where: { $0.brandName == question.brandName && $0.genericName == question.genericName }
            ) {
                // まだlistItems内の問題が選択されていない場合は選択状態にする
                if !listItems[index].selected {
                    listItems[index].selected = true
                } // if ここまで
            } else {
                // 一致するlistItemがない場合は新しい項目を追加
                let additionalQuestion = MedicineListItem(category: question.category,
                                                          brandName: question.brandName,
                                                          genericName: question.genericName,
                                                          selected: true)
                listItems.append(additionalQuestion)
            } // if let ここまで
        } // for ここまで
    } // mergeQuestions ここまで
} // CreateQuestionListModel ここまで
