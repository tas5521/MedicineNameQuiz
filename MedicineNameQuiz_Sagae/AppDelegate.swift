//
//  AppDelegate.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/05/22.
//

import GoogleMobileAds
import AppTrackingTransparency

// アプリケーションのライフサイクルイベントを処理するためのデリゲート（ここでは、広告を表示する準備をする）
// UIResponderクラスはイベント処理の基盤を提供
// UIApplicationDelegateプロトコルに準拠することで、アプリケーションのライフサイクルイベントをハンドリングできるようにする
class AppDelegate: UIResponder, UIApplicationDelegate {
    // アプリケーションが起動した直後に呼び出されるメソッド
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // GADMobileAdsクラスから共有インスタンスを取得し、Google Mobile Ads SDKを初期化
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        // トラッキングの許可をリクエスト
        requestTrackingAuthorization()
        // trueを返すことで、アプリケーションの起動が正常に完了したことを示す
        return true
    } // application ここまで

    // トラッキングの許可をリクエストするメソッド
    private func requestTrackingAuthorization() {
        if #available(iOS 14.5, *) {
            // ポップアップ表示のタイミングを遅らせる為に処理を遅延させる（こうしないとポップアップが表示されない）
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                // ユーザーにトラッキングの許可をリクエスト
                ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                    // デバッグエリアに結果を表示
                    switch status {
                    case .authorized:
                        print("Tracking authorized")
                    case .denied, .notDetermined, .restricted:
                        print("Tracking not authorized")
                    @unknown default:
                        print("Unknown tracking status")
                    } // switch ここまで
                }) // requestTrackingAuthorization ここまで
            } // DispatchQueue.main.asyncAfter ここまで
        } else {
            // iOS14.5以前ではトラッキングの許可リクエストは不要
            print("Tracking authorization not needed for iOS versions prior to 14.5")
        } // if ここまで
    } // requestTrackingAuthorization ここまで
} // AppDelegate ここまで
