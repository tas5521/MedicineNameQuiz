//
//  StudyView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/09/30.
//

import SwiftUI

struct StudyView: View {
    // タブの選択項目を保持する変数
    @State private var selectedTab: Int = 0
    // 選択されているモードを保持する変数
    private var selectedMode: SelectedStudyMode {
        SelectedStudyMode.dicideMode(by: selectedTab)
    } // selectedModeここまで
    // signInしているかどうかの引数
    @Binding var isSignIn: Bool
    // シートの表示を管理する変数
    @State private var isShowSheet: Bool = false
    // サインイン画面の表示を管理する変数
    @State var isShowSignInView: Bool = false
    // 学習の開始を管理する変数
    @State private var isStartStudy: Bool = false
    // ユーザー名
    @Binding var userName: String
    
    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // タブを上に配置
            TopTabView(tabNameList: SelectedStudyMode.modeList, selectedTab: $selectedTab)
            Spacer()
            // 垂直方向にレイアウト
            VStack(alignment: .leading) {
                // モード選択
                Text("モード選択")
                    .bold()
                switch selectedMode {
                    
                case .actual:
                    // 区分選択
                    Text("区分")
                        .bold()
                case .practice:
                    Text("制限時間")
                        .bold()
                    Text("記録の表示")
                        .bold()
                    Text("問題リスト選択")
                        .bold()
                } // switch ここまで
            } // VStack ここまで
            // スタートボタン
            Button {
                switch selectedMode {
                case .actual:
                    if userName.isEmpty {
                        isShowSheet.toggle()
                    } else if !isSignIn {
                        isShowSignInView.toggle()
                    } else {
                        isStartStudy.toggle()
                    }
                case .practice:
                    isStartStudy.toggle()
                } // switch ここまで
            } label: {
                Text("スタート")
            } // Button ここまで
            .sheet(isPresented: $isShowSheet) {
                // ユーザー登録画面を表示
                RegistrationView(userName: $userName)
                    .onDisappear {
                        if isSignIn == false && !userName.isEmpty {
                            isShowSignInView.toggle()
                        }
                    }
            } // sheet ここまで
            .sheet(isPresented: $isShowSignInView) {
                // ユーザー登録画面を表示
                SignInView(isSignIn: $isSignIn)
            } // sheet ここまで
            Spacer()
        } // VStack ここまで
        .navigationDestination(isPresented: $isStartStudy) {
            StudyingView(isStartStudy: $isStartStudy)
        }
    } // body ここまで
} // StudyView ここまで

#Preview {
    StudyView(isSignIn: .constant(true), userName: .constant("sagae"))
}
