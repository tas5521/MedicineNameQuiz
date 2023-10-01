//
//  QRCodeView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct QRCodeView: View {
    @State var isShowCamera: Bool = true
    var body: some View {
        VStack {
            Spacer()
            if isShowCamera {
                Text("QRコード読み取りカメラ")
            } else {
                Image(systemName: "qrcode")
                    .foregroundStyle(Color.black)
                    .scaleEffect(20)
            }
            Spacer()
            Button {
                isShowCamera.toggle()
            } label: {
                Text(isShowCamera ? "自分のQRコードを表示" : "QRコード読み取りカメラを表示")
            } // Button ここまで
            Spacer()
        } // VStack ここまで
    }
}

#Preview {
    QRCodeView()
}
