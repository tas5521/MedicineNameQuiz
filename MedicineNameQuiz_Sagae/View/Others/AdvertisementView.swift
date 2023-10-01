//
//  AdvertisementView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2023/10/01.
//

import SwiftUI

struct AdvertisementView: View {
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        Text("Advertisement")
            .navigationBarTitle("広告の表示について", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentation.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("戻る")
                        }
                    }
                    .foregroundColor(Color.blue)
                }
            } // toolbar ここまで
    } // body ここまで
} // AdvertisementView

#Preview {
    AdvertisementView()
}
