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
    // 薬の検索に使う変数
    @State private var searchMedicineNameText: String = ""
    // MedicineListViewModelのインスタンスを生成
    @State private var medicineListViewModel: MedicineListViewModel = MedicineListViewModel()
    
    // カスタムの薬データをフェッチ
    @FetchRequest(entity: CustomMedicineName.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \CustomMedicineName.originalName, ascending: true)],
                  animation: nil
    ) private var fetchedCustomMedicineNameList: FetchedResults<CustomMedicineName>
    
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
                    TopTabView(selectTab: $medicineListViewModel.medicineClassification)
                    // 上部タブが切り替わった時に検索処理を行う
                        .onChange(of: medicineListViewModel.medicineClassification, initial: true) {
                            medicineListViewModel.searchMedicineName(keyword: searchMedicineNameText)
                        } // onChange ここまで
                    // 太字にする
                        .bold()
                    // 薬の検索バー
                    SearchBar(searchText: $searchMedicineNameText, placeholderText: "薬を検索できます")
                    // 検索キーワードが変わった時に検索を行う
                        .onChange(of: searchMedicineNameText) {
                            medicineListViewModel.searchMedicineName(keyword: searchMedicineNameText)
                            searchCustomMedicine(text: searchMedicineNameText)
                        } // onChange ここまで
                    // 上下に余白を追加
                        .padding(.vertical)
                    // 薬リスト
                    if medicineListViewModel.medicineClassification == .customMedicine {
                        List {
                            ForEach(fetchedCustomMedicineNameList) { medicine in
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
                            .onDelete { index in
                                medicineListViewModel.deleteCustomMedicineName(
                                    index: index,
                                    fetchedCustomMedicineNameList: fetchedCustomMedicineNameList)
                            } // onDelete ここまで
                        } // List ここまで
                        // 太字にする
                        .bold()
                        // リストのスタイルを.groupedに変更
                        .listStyle(.grouped)
                        // リストの背景のグレーの部分を非表示にする
                        .scrollContentBackground(.hidden)
                    } else {
                        medicineList(of: medicineListViewModel.searchedMedicineNameData)
                    } // if ここまで
                    
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
                        if medicineListViewModel.medicineClassification == .customMedicine {
                            addMedicineButton
                                .padding()
                        } // if ここまで
                    } // HStack ここまで
                } // VStack ここまで
            } // ZStack ここまで
            // ナビゲーションバーの設定
            // ナビゲーションバーのタイトルを設定
            .navigationBarTitle("薬リスト", displayMode: .inline)
            // ナビゲーションバーの背景を変更
            .navigationBarBackground()
        } // NavigationStack ここまで
    } // body ここまで
    
    // 薬のリスト
    private func medicineList(of medicineArray: [MedicineNameItem]) -> some View {
        List {
            ForEach(medicineArray) { medicine in
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
        .sheet(isPresented: $isShowAddMedicineView, onDismiss: {
            medicineListViewModel.searchMedicineName(keyword: searchMedicineNameText)
        }) {
            AddMedicineView()
        } // sheet ここまで
    } // addMedicineButton ここまで
    
    private func searchCustomMedicine(text: String) {
        if text.isEmpty {
            fetchedCustomMedicineNameList.nsPredicate = nil
        } else {
            let originalNamePredicate: NSPredicate = NSPredicate(format: "originalName contains %@", text)
            let genericNamePredicate: NSPredicate = NSPredicate(format: "genericName contains %@", text)
            fetchedCustomMedicineNameList.nsPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [originalNamePredicate, genericNamePredicate])
        } // if ここまで
    } // searchCustomMedicine
} // MedicineListView ここまで

#Preview {
    MedicineListView()
}
