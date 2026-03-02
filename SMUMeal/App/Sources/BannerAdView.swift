//
//  BannerAdView.swift
//  App
//
//  Created by 김진혁 on 2/15/26.
//

//import SwiftUI
//
//struct BannerAdView: UIViewRepresentable {
//    let adUnitID: String
//
//    func makeUIView(context: Context) -> GADBannerView {
//        let bannerView = GADBannerView(adSize: GADAdSizeBanner)
//        bannerView.adUnitID = adUnitID
//        bannerView.load(GADRequest())
//        return bannerView
//    }
//
//    func updateUIView(_ uiView: GADBannerView, context: Context) {}
//}
//
//struct AdaptiveBannerAdView: UIViewControllerRepresentable {
//    let adUnitID: String
//    @Binding var adHeight: CGFloat
//
//    func makeUIViewController(context: Context) -> UIViewController {
//        let viewController = UIViewController()
//        let bannerView = GADBannerView()
//        bannerView.adUnitID = adUnitID
//        bannerView.delegate = context.coordinator
//        bannerView.rootViewController = viewController
//
//        viewController.view.addSubview(bannerView)
//        bannerView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            bannerView.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor),
//            bannerView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor)
//        ])
//
//        context.coordinator.bannerView = bannerView
//
//        return viewController
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        guard let bannerView = context.coordinator.bannerView else { return }
//
//        let viewWidth = uiViewController.view.frame.inset(by: uiViewController.view.safeAreaInsets).width
//        if viewWidth > 0 {
//            bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
//            bannerView.load(GADRequest())
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(adHeight: $adHeight)
//    }
//
//    class Coordinator: NSObject, GADBannerViewDelegate {
//        var bannerView: GADBannerView?
//        @Binding var adHeight: CGFloat
//
//        init(adHeight: Binding<CGFloat>) {
//            _adHeight = adHeight
//        }
//
//        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
//            adHeight = bannerView.adSize.size.height
//            print("📢 Banner ad loaded successfully")
//        }
//
//        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
//            adHeight = 0
//            print("📢 Banner ad failed to load: \(error.localizedDescription)")
//        }
//    }
//}
