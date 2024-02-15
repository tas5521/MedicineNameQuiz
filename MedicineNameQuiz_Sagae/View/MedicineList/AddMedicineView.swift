//
//  AddMedicineView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct AddMedicineView: View {
    @Environment(\.managedObjectContext) private var context

    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // 入力された先発品名を管理する変数
    @State private var originalName: String = ""
    // 入力された一般名を管理する変数
    @State private var genericName: String = ""
    // 新しい薬名を追加できるかどうかを管理する変数
    private var canAddNew: Bool {
        !(originalName == "" || genericName == "")
    } // canAddNew ここまで

    var body: some View {
        // 奥から手前にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
            // セーフエリア外にも背景を表示
                .ignoresSafeArea()
            // 垂直方向にレイアウト
            VStack(spacing: 30) {
                // スペースを空ける
                Spacer()
                // 追加する薬の名前を入力するようユーザーに促すためのテキスト
                Text("追加する薬の名前を入力してください")
                // フォントを.title3に変更
                    .font(.title3)
                // 太字にする
                    .bold()
                // 先発品名を入力するためのテキストフィールド
                TextField("先発品名", text: $originalName)
                // テキストフィールドの背景を指定
                    .textFieldBackground()
                // 一般名を入力するためのテキストフィールド
                TextField("一般名", text: $genericName)
                // テキストフィールドの背景を指定
                    .textFieldBackground()
                // スペースを空ける
                Spacer()
                // 追加ボタン
                Button {
                    // 新しいカスタムの薬名データのインスタンスを生成
                    let newCustomMedicineName = CustomMedicineName(context: context)
                    // 薬のカテゴリを保持
                    newCustomMedicineName.medicineCategory = "カスタム"
                    // 先発品名を保持
                    newCustomMedicineName.originalName = originalName
                    // 一般名を保持
                    newCustomMedicineName.genericName = genericName
                    do {
                        // カスタムの薬名をCore Dataに保存
                        try context.save()
                    } catch {
                        // 何らかのエラーが発生した場合は、エラー内容をデバッグエリアに表示
                        print("エラー: \(error)")
                    } // do-try-catch ここまで

                    // シートを閉じる
                    dismiss()
                } label: {
                    // ラベル
                    Text("追加")
                    // 太字にする
                        .bold()
                    // 最大幅.infinityに指定
                        .frame(maxWidth: .infinity)
                    // 高さ60に指定
                        .frame(height: 60)
                    // 両方のテキストフィールドに文字が入力されている場合、背景色をオレンジに指定。そうでない場合はグレー
                        .background(canAddNew ? Color.buttonOrange : Color.disabledButtonGray)
                    // 文字色を白に指定
                        .foregroundStyle(Color.white)
                    // 角を丸くする
                        .clipShape(.buttonBorder)
                } // Button ここまで
                // 先発品名か一般名の少なくとも一方が入力されていなかったら、ボタンを押せなくする
                .disabled(!canAddNew)
                // やめるボタン
                Button {
                    // シートを閉じる
                    dismiss()
                } label: {
                    // ラベル
                    Text("やめる")
                    // 太字にする
                        .bold()
                    // 最大幅.infinityに指定
                        .frame(maxWidth: .infinity)
                    // 高さ60に指定
                        .frame(height: 60)
                    // 背景色をオレンジに指定
                        .background(Color.buttonOrange)
                    // 角を丸くする
                        .clipShape(.buttonBorder)
                } // Button ここまで
                // スペースを空ける
                Spacer()
            } // VStack ここまで
            // 上下左右に余白を追加
            .padding()
        } // ZStack ここまで
    } // body ここまで
} // AddMedicineView ここまで

#Preview {
    AddMedicineView()
}
