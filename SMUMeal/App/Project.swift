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
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                // 필요한 모듈 의존성 추가
                // .core("Domain"),
                // .feature("Home"),
                // .ui("DesignSystem"),
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
