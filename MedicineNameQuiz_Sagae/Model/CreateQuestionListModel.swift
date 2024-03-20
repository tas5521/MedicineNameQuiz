//
//  CreateQuestionListModel.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/02/23.
//

import SwiftUI

final class CreateQuestionListModel {
    // 薬のデータをこの配列に格納
    var listItems: [MedicineListItem] = []

    // 薬データをフェッチ
    func fetchListItems(from fetchedCustomMedicines: FetchedResults<CustomMedicine>) {
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
        // 薬のデータを配列に格納
        listItems = csvListItems + customListItems
    } // fetchListItems ここまで

    // 選択されている問題を該当するカテゴリの配列にマージする
    /// 薬のカテゴリで絞って、薬リストのデータの中に同じ商品名・一般名のデータがあるかどうか探索します。
    /// 同じカテゴリ・商品名・一般名のデータが見つかった場合、薬リストのデータの該当する問題のselectedプロパティをtrueに変更します。
    /// 探索は、1つの問題につき、薬リストのデータ内に該当するデータが1件見つかり次第終了します。
    /// カテゴリ・商品名・一般名の全てが一致するものが複数見つかる可能性もありますが、該当データが1件見つかり次第終了することで、
    /// 複数選択されるのを回避します。
    /// もし、カテゴリ・商品名・一般名が一致するデータが見つからなかった場合、そのデータは、「過去にCoreDataに保存する時には存在したが、
    /// 今は薬リストのデータに無いデータ」なので、このデータをselectedプロパティをtrueにして薬リストに追加します。
    func mergeQuestionsToListItems(questions: [MedicineItem]) -> [MedicineListItem] {
        for question in questions {
            for index in 0...listItems.count {
                // questionとカテゴリ・商品名・一般名が一致するlistItemがなかった場合
                if index == listItems.count {
                    // その問題を配列に追加する
                    let additionalQuestion = MedicineListItem(category: question.category,
                                                              brandName: question.brandName,
                                                              genericName: question.genericName,
                                                              selected: true)
                    listItems.append(additionalQuestion)
                } else {
                    // listItemとquestionのカテゴリと商品名と一般名が一致したら通過。一致しなければ次のループへ
                    guard listItems[index].category == question.category &&
                            listItems[index].brandName == question.brandName &&
                            listItems[index].genericName == question.genericName
                    else { continue }
                    // まだlistItems内の問題が選択されていなかったら通過。選択されていれば、次のループへ
                    guard listItems[index].selected == false else { continue }
                    // 問題を選択された状態にし、ループを終了
                    listItems[index].selected = true
                    break
                } // if ここまで
            } // for ここまで
        } // for ここまで
        return listItems
    } // mergeQuestionsToListItems ここまで
} // CreateQuestionListModel ここまで
