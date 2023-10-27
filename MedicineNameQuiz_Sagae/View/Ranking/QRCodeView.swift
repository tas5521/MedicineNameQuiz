//
//  QRCodeView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct QRCodeView: View {
    // カメラの表示を管理する変数
    @State var isShowCamera: Bool = true
    
    var body: some View {
        // 垂直方向にレイアウト
        VStack {
            // スペースを空ける
            Spacer()
            // カメラの表示を管理する変数がtrueの場合
            if isShowCamera {
                // カメラを表示
                qrCodeCamera
                // カメラの表示を管理する変数がfalseの場合
            } else {
                // 自分のQRコードを表示
                myQRCode
            } // if ここまで
            // 空白を空ける
            Spacer()
            // カメラとQRコードを切り替えるボタン
            switchButton
            Spacer()
        } // VStack ここまで
    } // body ここまで
    
    // QRコード読み取りカメラ
    private var qrCodeCamera: some View {
        Text("QRコード読み取りカメラ")
    } // qrCodeCamera ここまで
    
    // QRコード
    private var myQRCode: some View {
        Image(systemName: "qrcode")
            .foregroundStyle(Color.black)
            .scaleEffect(15)
    } // myQRCode ここまで
    
    // カメラとQRコードを切り替えるボタン
    private var switchButton: some View {
        Button {
            // カメラとQRコードを切り替える
            isShowCamera.toggle()
        } label: {
            // ラベル
            Text(isShowCamera ? "自分のQRコードを表示" : "QRコード読み取りカメラを表示")
        } // Button ここまで
    } // switchButton ここまで
} // QRCodeView ここまで

#Preview {
    QRCodeView()
}
