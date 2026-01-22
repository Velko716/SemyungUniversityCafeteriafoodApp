import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "App",
    targets: [
        .target(
            name: "App",
            destinations: .iOS,
            product: .app,
            bundleId: "com.SemyungUniversityCafeteriafoodApp.ManduU2App",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .extendingDefault(
                with: [
                    "CFBundleShortVersionString": "2.0.0",
                    "CFBundleVersion": "1",
                    "CFBundleDisplayName": "학식 알리미",
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                    "UIAppFonts": [
                        "Pretendard-Black.ttf",
                        "Pretendard-Bold.ttf",
                        "Pretendard-ExtraBold.ttf",
                        "Pretendard-ExtraLight.ttf",
                        "Pretendard-Light.ttf",
                        "Pretendard-Medium.ttf",
                        "Pretendard-Regular.ttf",
                        "Pretendard-SemiBold.ttf",
                        "Pretendard-Thin.ttf",
                    ],
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .feature("Meal"),
                .ui("DesignSystem"),
                // Firebase
                .external(name: "FirebaseAnalytics"),
                .external(name: "FirebaseMessaging"),
            ]
        ),
        .target(
            name: "AppTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.SemyungUniversityCafeteriafoodApp.ManduU2AppTests",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [.target(name: "App")]
        ),
    ]
)
