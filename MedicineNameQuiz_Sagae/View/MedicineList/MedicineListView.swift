//
//  MedicineListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct MedicineListView: View {
    // 薬名追加ビューの表示を管理する変数
    @State private var isShowAddMedicineView: Bool = false
    // MedicineListViewModelのインスタンスを生成
    @State private var viewModel: MedicineListViewModel = MedicineListViewModel()
    
    // カスタムの薬データをフェッチ
    @FetchRequest(entity: CustomMedicineName.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \CustomMedicineName.originalName, ascending: true)],
                  animation: nil
    ) private var fetchedCustomMedicines: FetchedResults<CustomMedicineName>
    
    var body: some View {
        NavigationStack {
            // 手前から奥にレイアウト
            ZStack {
                // 背景を水色にする
                Color.backgroundSkyBlue
                // セーフエリア外にも背景を表示
                    .ignoresSafeArea()
                // 垂直方向にレイアウト
                VStack {
                    // 薬の区分を選択するタブを上に配置
                    TopTabView(selectTab: $viewModel.medicineClassification)
                    // 太字にする
                        .bold()
                    // 薬の検索バー
                    SearchBar(searchText: $viewModel.searchMedicineNameText,
                              placeholderText: "薬を検索できます")
                    // searchMedicineNameTextが変更されたときに実行
                    .onChange(of: viewModel.searchMedicineNameText) {
                        // カスタムの薬リストに検索をかける
                        viewModel.searchCustomMedicine(fetchedCustomMedicines: fetchedCustomMedicines)
                    } // onChange ここまで
                    // 上下に余白を追加
                    .padding(.vertical)
                    // 薬リスト
                    medicineList
                } // VStack ここまで
                // 垂直方向にレイアウト
                VStack {
                    // スペースを空ける
                    Spacer()
                    // 水平方向にレイアウト
                    HStack {
                        // スペースを空ける
                        Spacer()
                        // カスタムのタブが選択されている場合、薬名追加ボタンを表示
                        if viewModel.medicineClassification == .customMedicine {
                            addMedicineButton
                                .padding()
                        } // if ここまで
                    } // HStack ここまで
                } // VStack ここまで
            } // ZStack ここまで
            // ナビゲーションバーのタイトルを設定
            .navigationBarTitle("薬リスト", displayMode: .inline)
            // ナビゲーションバーの背景を変更
            .navigationBarBackground()
        } // NavigationStack ここまで
    } // body ここまで

    // 薬のリスト
    private var medicineList: some View {
        Group {
            // カスタムが選択されていたら
            if viewModel.medicineClassification == .customMedicine {
                List {
                    ForEach(fetchedCustomMedicines) { medicine in
                        // 垂直方向にレイアウト
                        VStack(alignment: .leading) {
                            // 先発品名を表示
                            Text(medicine.originalName ?? "")
                            // 文字の色を青に変更
                                .foregroundStyle(Color.blue)
                            // 一般名を表示
                            Text(medicine.genericName ?? "")
                            // 文字の色を赤に変更
                                .foregroundStyle(Color.red)
                        } // VStack ここまで
                    } // ForEach ここまで
                    // カスタムの場合は、リストを左にスライドして項目を削除できるようにする
                    .onDelete { index in
                        viewModel.deleteCustomMedicineData(
                            index: index,
                            fetchedCustomMedicines: fetchedCustomMedicines)
                    } // onDelete ここまで
                } // List ここまで
                // 内用薬、注射薬、外用薬が選択されていたら
            } else {
                List {
                    ForEach(viewModel.medicineItems) { medicine in
                        // 垂直方向にレイアウト
                        VStack(alignment: .leading) {
                            // 先発品名を表示
                            Text(medicine.originalName)
                            // 文字の色を青に変更
                                .foregroundStyle(Color.blue)
                            // 一般名を表示
                            Text(medicine.genericName)
                            // 文字の色を赤に変更
                                .foregroundStyle(Color.red)
                        } // VStack ここまで
                    } // ForEach ここまで
                } // List ここまで
            } // if ここまで
        } // Group ここまで
        // 太字にする
        .bold()
        // リストのスタイルを.groupedに変更
        .listStyle(.grouped)
        // リストの背景のグレーの部分を非表示にする
        .scrollContentBackground(.hidden)
    } // medicineList ここまで
    
    // カスタムで薬名を追加するボタン
    private var addMedicineButton: some View {
        Button {
            // 薬名追加ビューを表示
            isShowAddMedicineView.toggle()
        } label: {
            // ラベル
            Image(systemName: "plus.circle.fill")
            // リサイズする
                .resizable()
            // アスペクト比を保ったまま枠いっぱいに表示
                .scaledToFit()
            // 幅高さ65に指定
                .frame(width: 65, height: 65)
            // ボタンの色をオレンジに指定
                .foregroundStyle(.buttonOrange)
            // 背景を白に指定
                .background(Color.white)
            // 丸くクリッピング
                .clipShape(Circle())
        } // Button ここまで
        // 薬名追加ビューのシート
        .sheet(isPresented: $isShowAddMedicineView) {
            AddMedicineView()
        } // sheet ここまで
    } // addMedicineButton ここまで
} // MedicineListView ここまで

#Preview {
    MedicineListView()
}
