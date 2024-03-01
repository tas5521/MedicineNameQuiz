//
//  MedicineListView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct MedicineListView: View {
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) private var context
    // 薬名追加ビューの表示を管理する変数
    @State private var isShowAddMedicineView: Bool = false
    // MedicineListViewModelのインスタンスを生成
    @State private var viewModel: MedicineListViewModel = MedicineListViewModel()
    
    // カスタムの薬データをフェッチ
    @FetchRequest(entity: CustomMedicine.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \CustomMedicine.brandName, ascending: true)],
                  animation: nil
    ) private var fetchedCustomMedicines: FetchedResults<CustomMedicine>
    
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
                    TopTabView(selectTab: $viewModel.category)
                    // 太字にする
                        .bold()
                    // 薬の検索バー
                    SearchBar(searchText: $viewModel.medSearchText,
                              placeholderText: "薬を検索できます")
                    // medSearchTextが変更されたときに実行
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
                        if viewModel.category == .custom {
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
            if viewModel.category == .custom {
                List {
                    ForEach(fetchedCustomMedicines) { medicine in
                        // 垂直方向にレイアウト
                        VStack(alignment: .leading) {
                            // 商品名を表示
                            Text(medicine.brandName ?? "")
                            // 文字の色を青に変更
                                .foregroundStyle(Color.blue)
                            // 一般名を表示
                            Text(medicine.genericName ?? "")
                            // 文字の色を赤に変更
                                .foregroundStyle(Color.red)
                        } // VStack ここまで
                    } // ForEach ここまで
                    // カスタムの場合は、リストを左にスライドして項目を削除できるようにする
                    .onDelete(perform: deleteCustomMedicineData)
                } // List ここまで
                .onChange(of: viewModel.medSearchText, initial: true) {
                    // カスタムの薬リストに検索をかける
                    searchCustomMedicine()
                } // onChange ここまで
                // 内用薬、注射薬、外用薬が選択されていたら
            } else {
                List {
                    ForEach(viewModel.items) { medicine in
                        // 垂直方向にレイアウト
                        VStack(alignment: .leading) {
                            // 商品名を表示
                            Text(medicine.brandName)
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
    
    // カスタムの薬リストに検索をかけるメソッド
    private func searchCustomMedicine() {
        // 検索キーワードが空の場合
        if viewModel.medSearchText.isEmpty {
            // 検索条件を無し（nil）にする
            fetchedCustomMedicines.nsPredicate = nil
        } else {
            // 検索キーワードがある場合
            // brandNameに検索キーワードを含むか調べる条件を指定
            let brandNamePredicate: NSPredicate = NSPredicate(format: "brandName contains %@", viewModel.medSearchText)
            // genericNameに検索キーワードを含むか調べる条件を指定
            let genericNamePredicate: NSPredicate = NSPredicate(format: "genericName contains %@", viewModel.medSearchText)
            // 指定した条件を適用し、検索をかける
            fetchedCustomMedicines.nsPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [brandNamePredicate, genericNamePredicate])
        } // if ここまで
    } // searchCustomMedicine ここまで
    
    // Core Dataから指定したカスタムの薬名のデータを削除するメソッド
    private func deleteCustomMedicineData(offsets: IndexSet) {
        for index in offsets {
            // CoreDataから該当するindexのメモを削除
            context.delete(fetchedCustomMedicines[index])
        } // for ここまで
        // エラーハンドリング
        do {
            // 生成したインスタンスをCoreDataに保持する
            try context.save()
        } catch {
            // このメソッドにより、クラッシュログを残して終了する
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        } // エラーハンドリングここまで
    } // deleteCustomMedicineData ここまで
} // MedicineListView ここまで

#Preview {
    MedicineListView()
}
