//
//  QRCodeView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct QRCodeView: View {
    // カメラの表示を管理する変数
    @State private var isShowCamera: Bool = true
    
    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // スペースを空ける
            Spacer()
            // カメラの表示を管理する変数がtrueの場合
            if isShowCamera {
                // カメラを表示
                Text("QRコード読み取りカメラ")
                // カメラの表示を管理する変数がfalseの場合
            } else {
                // 自分のQRコードを表示
                Image(systemName: "qrcode")
                    .foregroundStyle(Color.black)
                    .scaleEffect(15)
            } // if ここまで
            // 空白を空ける
            Spacer()
            // カメラとQRコードを切り替えるボタン
            Button {
                // カメラとQRコードを切り替える
                isShowCamera.toggle()
            } label: {
                // ラベル
                Text(isShowCamera ? "自分のQRコードを表示" : "QRコード読み取りカメラを表示")
            } // Button ここまで
            Spacer()
        } // VStack ここまで
    } // body ここまで
} // QRCodeView ここまで

#Preview {
    QRCodeView()
}
