//
//  AppDelegate.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/05/22.
//

import GoogleMobileAds

// アプリケーションのライフサイクルイベントを処理するためのデリゲート（広告を表示する準備）
// UIResponderクラスは、イベント処理の基盤を提供（必須ではないが、AppDelegateの一般的な実装ではUIResponderを継承することが推奨されている）
// UIApplicationDelegateプロトコルに準拠することで、アプリケーションのライフサイクルイベントをハンドリングできるようにする
class AppDelegate: UIResponder, UIApplicationDelegate {
    // アプリケーションが起動（ライフサイクルの1つ）した直後に呼び出されるメソッド
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // GADMobileAdsクラスから共有インスタンスを取得し、Google Mobile Ads SDKを初期化
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        // trueを返すことで、アプリケーションの起動が正常に完了したことを示す
        return true
    } // application ここまで
} // AppDelegate ここまで
