//
//  BannerView.swift
//  MedicineNameQuiz_Sagae
//
//  Created by 寒河江彪流 on 2024/05/28.
//

import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency

// バナーViewのコントローラが画面の幅を取得するためのDelegateメソッドを定義するプロトコル
protocol BannerViewControllerWidthDelegate: AnyObject {
    // 幅を取得するためのDelegateメソッド
    func bannerViewController(_ bannerViewController: BannerViewController, didUpdate width: CGFloat)
} // BannerViewControllerWidthDelegate ここまで

// バナーViewのコントローラ
final class BannerViewController: UIViewController {
    // バナーViewのコントローラが画面の幅を取得するためのDelegateを指定
    // weak は循環参照を回避するため
    weak var delegate: BannerViewControllerWidthDelegate?

    // Viewが表示された時に呼び出されるメソッドをオーバーライド
    override func viewDidAppear(_ animated: Bool) {
        // UIViewControllerのviewDidAppearは最初に実行しておく
        super.viewDidAppear(animated)
        // 幅を取得するためのDelegateメソッドの処理を追加
        delegate?.bannerViewController(
            self, didUpdate: view.frame.inset(by: view.safeAreaInsets).size.width)
    } // viewDidAppear オーバーライドここまで

    // ウィンドウの回転などにより、このコントローラのViewのサイズが変わる時に呼び出されるメソッド
    override func viewWillTransition(
        to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator
    ) {
        coordinator.animate { _ in
            // 何もしない
        } completion: { _ in
            // 広告の幅の変更をデリゲートに知らせる
            self.delegate?.bannerViewController(
                self, didUpdate: self.view.frame.inset(by: self.view.safeAreaInsets).size.width)
        } // completion ここまで
    } // viewWillTransition 上書きここまで
} // BannerViewController ここまで

// バナー広告のView
struct BannerView: UIViewControllerRepresentable {
    // Viewの幅を管理する変数
    @State private var viewWidth: CGFloat = .zero
    // バナーViewのインスタンスを生成
    private let bannerView: GADBannerView = GADBannerView()
    // 広告ユニットID
    private let adUnitID: String = Bundle.main.object(forInfoDictionaryKey: "BannerUnitID") as? String ?? ""

    // Viewのコントローラを生成
    func makeUIViewController(context: Context) -> some UIViewController {
        // BannerViewControllerのインスタンスを生成
        let bannerViewController = BannerViewController()
        // バナーViewに広告ユニットIDを指定
        bannerView.adUnitID = adUnitID
        // バナーViewに、そのコントローラとして、bannerViewControllerを指定
        bannerView.rootViewController = bannerViewController
        // bannerViewをbannerViewControllerのビュー階層に追加
        bannerViewController.view.addSubview(bannerView)
        // バナーViewを上部の中央に固定
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: bannerViewController.view.safeAreaLayoutGuide.topAnchor),
            bannerView.centerXAnchor.constraint(equalTo: bannerViewController.view.centerXAnchor)
        ]) // NSLayoutConstraint.activate ここまで
        // バナーViewのコントローラのデリゲートにCoordinatorのインスタンスを指定（デリゲートの具体的な処理の内容は、Coordinator側に記載）
        bannerViewController.delegate = context.coordinator
        // Viewのコントローラを返す
        return bannerViewController
    } // makeUIViewController ここまで

    // Viewのコントローラの更新
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Viewの幅が0でければ、先の処理へ進む。0だったら終了
        guard viewWidth != .zero else { return }
        // 幅が更新されたら、その値をバナーの広告の幅に指定
        bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        // リクエストを取得
        let request = GADRequest()
        // トラッキングが許可されているか確認する。
        // 許可されていたら、デフォルトのまま（パーソナライズド広告のリクエストを設定）
        // 許可されていない場合、ノンパーソナライズド広告のリクエストを設定
        if isTrackingAuthorized() {
            // トラッキングの許可の状態をデバッグエリアに表示
            print("トラッキングは許可されています：パーソナライズド広告を指定")
        } else {
            // トラッキングの許可の状態をデバッグエリアに表示
            print("トラッキングは許可されていません：ノンパーソナライズド広告を指定")
            // 広告リクエストに追加のパラメータを追加するためのクラスのインスタンスを生成
            let extras = GADExtras()
            // ノンパーソナライズド広告を表示するよう指定
            extras.additionalParameters = ["npa": "1"]
            // 広告リクエストに追加の設定を反映
            request.register(extras)
        } // if ここまで
        // バナーを読み込み
        bannerView.load(request)
    } // updateUIViewController ここまで

    // Coordinatorを作成
    // makeUIViewControllerより先に呼ばれて、contextに渡される
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    } // makeCoordinator ここまで

    // ViewControllerがイベントを処理できるようにするため、Coordinatorを定義（ここでは、デリゲートをハンドリングしたい）
    class Coordinator: NSObject, BannerViewControllerWidthDelegate, GADBannerViewDelegate {
        // このCoordinatorの親として、BannerViewを指定
        private let parent: BannerView

        // イニシャライザ
        init(_ parent: BannerView) {
            // このCoordinatorの親として、BannerViewを指定
            self.parent = parent
        } // init ここまで

        // BannerViewControllerWidthDelegateのデリゲートメソッド
        func bannerViewController(_ bannerViewController: BannerViewController, didUpdate width: CGFloat) {
            // Viewの幅を親（BannerView）に渡す
            parent.viewWidth = width
        } // bannerViewController ここまで

        // 以降、GADBannerViewDelegateのデリゲートメソッド（各イベントが発生した際に、デバッグエリアに通知する）
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            print("\(#function) called")
        } // bannerViewDidReceiveAd ここまで

        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            print("\(#function) called")
        } // bannerView ここまで

        func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
            print("\(#function) called")
        } // bannerViewDidRecordImpression ここまで

        func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
            print("\(#function) called")
        } // bannerViewWillPresentScreen ここまで

        func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
            print("\(#function) called")
        } // bannerViewWillDismissScreen ここまで

        func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
            print("\(#function) called")
        } // bannerViewDidDismissScreen ここまで
    } // Coordinator ここまで

    // トラッキングが許可されているかを確認するメソッド
    private func isTrackingAuthorized() -> Bool {
        // トラッキングの許可状態を確認
        switch ATTrackingManager.trackingAuthorizationStatus {
        case .authorized:
            // トラッキングが許可されている場合
            print("Tracking authorized")
            return true
        case .denied, .restricted, .notDetermined:
            // トラッキングが許可されていない場合、または、まだ決定されていない場合
            print("Tracking not authorized")
            return false
        @unknown default:
            // 未知のエラー処理
            print("Unknown tracking status")
            return false
        } // switch ここまで
    } // isTrackingAuthorized ここまで
} // BannerView ここまで

#Preview {
    BannerView()
}
