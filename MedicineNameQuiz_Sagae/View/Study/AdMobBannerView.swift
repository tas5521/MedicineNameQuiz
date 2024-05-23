//
//  AdMobBannerView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/05/21.
//

import SwiftUI
import GoogleMobileAds

struct AdMobBannerView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        // GADBannerViewのインスタンスを生成
        let banner = GADBannerView(adSize: GADAdSizeBanner)
        // 設定
        // テスト専用広告ユニットID
        banner.adUnitID = "ca-app-pub-3940256099942544/2435281174"
        // アプリケーションに接続されているシーンを取得し、最初のシーンをUIWindowScene型にキャスト
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        // シーンの最初のウィンドウのrootViewControllerをGADBannerViewに設定
        banner.rootViewController = windowScene?.windows.first?.rootViewController
        // GADRequestを使用して広告をロード
        banner.load(GADRequest())
        // インスタンスを返す
        return banner
    } // makeUIView ここまで

    func updateUIView(_ uiView: GADBannerView, context: Context) {
        // 特にないのでメソッドだけ用意
    } // updateUIView ここまで
} // AdMobBannerView ここまで
