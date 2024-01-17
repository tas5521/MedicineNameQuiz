//
//  AddMedicineView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct AddMedicineView: View {
    // 画面を閉じるために用いる環境変数
    @Environment(\.dismiss) private var dismiss
    // 入力された先発品名を管理する変数
    @State private var originalNameText: String = ""
    // 入力された一般名を管理する変数
    @State private var genericNameText: String = ""
    
    
    var body: some View {
        // 奥から手前にレイアウト
        ZStack {
            // 背景を水色にする
            Color.backgroundSkyBlue
            // セーフエリア外にも背景を表示
                .ignoresSafeArea()
            // 垂直方向にレイアウト
            VStack {
                // スペースを空ける
                Spacer()
                // 追加する薬の名前を入力するようユーザーに促すためのテキスト
                Text("追加する薬の名前を入力してください")
                // フォントを.title3に変更
                    .font(.title3)
                // 太字にする
                    .bold()
                // 上下左右に余白を追加
                    .padding()
                // 先発品名を入力するためのテキストフィールド
                TextField("先発品名", text: $originalNameText)
                // テキストフィールドの背景を指定
                    .textFieldBackground()
                // 上下左右に余白を追加
                    .padding()
                // 一般名を入力するためのテキストフィールド
                TextField("一般名", text: $genericNameText)
                // テキストフィールドの背景を指定
                    .textFieldBackground()
                // 上下左右に余白を追加
                    .padding()
                // スペースを空ける
                Spacer()
                // 追加ボタン
                Button {
                    // 薬の名前をカスタムに追加する処理
                    dismiss()
                } label: {
                    // ラベル
                    Text("追加")
                    // 幅300高さ50に指定
                        .frame(width: 300, height: 60)
                    // 両方のテキストフィールドに文字が入力されている場合、背景色をオレンジに指定。そうでない場合はグレー
                        .background(originalNameText == "" || genericNameText == "" ? Color.disabledButtonGray : Color.buttonOrange)
                    // 文字色を白に指定
                        .foregroundStyle(Color.white)
                    // 角を丸くする
                        .clipShape(.buttonBorder)
                } // Button ここまで
                .disabled(originalNameText == "" || genericNameText == "")
                // 太字にする
                .bold()
                // 下に余白を追加
                .padding(.bottom)
                // やめるボタン
                Button {
                    // シートを閉じる
                    dismiss()
                } label: {
                    // ラベル
                    Text("やめる")
                    // 幅300高さ50に指定
                        .frame(width: 300, height: 60)
                    // 背景色をオレンジに指定
                        .background(Color.buttonOrange)
                    // 角を丸くする
                        .clipShape(.buttonBorder)
                } // Button ここまで
                // 太字にする
                .bold()
                // スペースを空ける
                Spacer()
            } // VStack ここまで
        } // ZStack ここまで
    } // body ここまで
} // AddMedicineView ここまで

#Preview {
    AddMedicineView()
}
