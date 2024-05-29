//
//  AppDelegate.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/05/22.
//

import GoogleMobileAds

// アプリケーションのライフサイクルイベントを処理するためのデリゲート（ここでは、広告を表示する準備をする）
// UIResponderクラスはイベント処理の基盤を提供
// UIApplicationDelegateプロトコルに準拠することで、アプリケーションのライフサイクルイベントをハンドリングできるようにする
class AppDelegate: UIResponder, UIApplicationDelegate {
    // アプリケーションが起動した直後に呼び出されるメソッド
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // GADMobileAdsクラスから共有インスタンスを取得し、Google Mobile Ads SDKを初期化
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        // trueを返すことで、アプリケーションの起動が正常に完了したことを示す
        return true
    } // application ここまで
} // AppDelegate ここまで
