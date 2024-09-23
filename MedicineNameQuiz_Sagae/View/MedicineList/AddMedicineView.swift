//
//  AddMedicineView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct AddMedicineView: View {
    // カスタムの薬データをフェッチ
    let fetchedCustomMedicines: FetchedResults<CustomMedicine>
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) private var context
    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // 入力された商品名を管理する変数
    @State private var brandName: String = ""
    // 入力された一般名を管理する変数
    @State private var genericName: String = ""
    // フォーカスを管理する変数
    @FocusState private var focusedField: AddMedicineField?
    // 新しい薬名を追加できるかどうかを管理する変数
    private var canAddNew: Bool {
        !(brandName.isEmpty || genericName.isEmpty || fetchedCustomMedicines.contains(where: {
            $0.brandName == brandName && $0.genericName == genericName
        }))
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
                // 商品名を入力するためのテキストフィールド
                TextField("商品名", text: $brandName)
                    // テキストフィールドの背景を指定
                    .textFieldBackground()
                    // フォーカスを指定
                    .focused($focusedField, equals: .brandName)
                    // 画面が表示された時に商品名のテキストフィールドにフォーカスを当てる
                    .onAppear {
                        focusedField = .brandName
                    } // onAppear ここまで
                    // 商品名の入力が完了して、一般名が入力されていない場合、一般名のテキストフィールドにフォーカスを当てる
                    .onSubmit {
                        if genericName.isEmpty {
                            focusedField = .genericName
                        } // if ここまで
                    } // onSubmit ここまで
                // 一般名を入力するためのテキストフィールド
                TextField("一般名", text: $genericName)
                    // テキストフィールドの背景を指定
                    .textFieldBackground()
                    // フォーカスを指定
                    .focused($focusedField, equals: .genericName)
                    // 一般名の入力が完了して、商品名が入力されていない場合、商品名のテキストフィールドにフォーカスを当てる
                    .onSubmit {
                        if brandName.isEmpty {
                            focusedField = .brandName
                        } // if ここまで
                    } // onSubmit ここまで
                // スペースを空ける
                Spacer()
                // 追加ボタン
                Button {
                    // カスタムの薬名を追加
                    addCustomMedicine()
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
                // 商品名か一般名の少なくとも一方が入力されていなかったら、ボタンを押せなくする
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
                        // 文字色を白に指定
                        .foregroundStyle(Color.white)
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

    // カスタムの薬を追加するメソッド
    private func addCustomMedicine() {
        // 新しいカスタムの薬データのインスタンスを生成
        let customMedicine = CustomMedicine(context: context)
        // 薬のカテゴリを保持
        customMedicine.category = "カスタム"
        // 商品名を保持
        customMedicine.brandName = brandName
        // 一般名を保持
        customMedicine.genericName = genericName
        do {
            // カスタムの薬をCore Dataに保存
            try context.save()
        } catch {
            // 何らかのエラーが発生した場合は、エラー内容をデバッグエリアに表示
            print("エラー: \(error)")
        } // do-try-catch ここまで
    } // addCustomMedicine ここまで
} // AddMedicineView ここまで

#Preview {
    // カスタムの薬データをフェッチ
    @Previewable @FetchRequest(entity: CustomMedicine.entity(),
                               sortDescriptors: [NSSortDescriptor(keyPath: \CustomMedicine.brandName, ascending: true)],
                               animation: nil
    ) var fetchedCustomMedicines: FetchedResults<CustomMedicine>
    return AddMedicineView(fetchedCustomMedicines: fetchedCustomMedicines)
}
