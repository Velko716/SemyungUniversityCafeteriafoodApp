import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "App",
    settings: .settings(
        configurations: [
            .debug(name: "Debug", xcconfig: "Configurations/Config.xcconfig"),
            .release(name: "Release", xcconfig: "Configurations/Config.xcconfig"),
        ]
    ),
    targets: [
        .target(
            name: "App",
            destinations: [.iPhone, .iPad],
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
                    "UIBackgroundModes": [
                        "remote-notification"
                    ],
                    "API_BASE_URL": "$(API_BASE_URL)",
                    "API_KEY": "$(API_KEY)",
                    "HOLIDAY_API_BASE_URL": "$(HOLIDAY_API_BASE_URL)",
                    "HOLIDAY_API_KEY": "$(HOLIDAY_API_KEY)",
                    "GADApplicationIdentifier": "ca-app-pub-xxxxxxxxxxxxxxxx~xxxxxxxxxx",
                    "SKAdNetworkItems": [
                        ["SKAdNetworkIdentifier": "cstr6suwn9.skadnetwork"],
                        ["SKAdNetworkIdentifier": "4fzdc2evr5.skadnetwork"],
                        ["SKAdNetworkIdentifier": "2fnua5tdw4.skadnetwork"],
                        ["SKAdNetworkIdentifier": "ydx93a7ass.skadnetwork"],
                        ["SKAdNetworkIdentifier": "p78axxw29g.skadnetwork"],
                        ["SKAdNetworkIdentifier": "v72qych5uu.skadnetwork"],
                        ["SKAdNetworkIdentifier": "ludvb6z3bs.skadnetwork"],
                        ["SKAdNetworkIdentifier": "cp8zw746q7.skadnetwork"],
                        ["SKAdNetworkIdentifier": "3sh42y64q3.skadnetwork"],
                        ["SKAdNetworkIdentifier": "c6k4g5qg8m.skadnetwork"],
                        ["SKAdNetworkIdentifier": "s39g8k73mm.skadnetwork"],
                        ["SKAdNetworkIdentifier": "wg4vff78zm.skadnetwork"],
                        ["SKAdNetworkIdentifier": "3qy4746246.skadnetwork"],
                        ["SKAdNetworkIdentifier": "f38h382jlk.skadnetwork"],
                        ["SKAdNetworkIdentifier": "hs6bdukanm.skadnetwork"],
                        ["SKAdNetworkIdentifier": "mlmmfzh3r3.skadnetwork"],
                        ["SKAdNetworkIdentifier": "v4nxqhlyqp.skadnetwork"],
                        ["SKAdNetworkIdentifier": "wzmmz9fp6w.skadnetwork"],
                        ["SKAdNetworkIdentifier": "su67r6k2v3.skadnetwork"],
                        ["SKAdNetworkIdentifier": "yclnxrl5pm.skadnetwork"],
                        ["SKAdNetworkIdentifier": "t38b2kh725.skadnetwork"],
                        ["SKAdNetworkIdentifier": "7ug5zh24hu.skadnetwork"],
                        ["SKAdNetworkIdentifier": "gta9lk7p23.skadnetwork"],
                        ["SKAdNetworkIdentifier": "vutu7akeur.skadnetwork"],
                        ["SKAdNetworkIdentifier": "y5ghdn5j9k.skadnetwork"],
                        ["SKAdNetworkIdentifier": "v9wttpbfk9.skadnetwork"],
                        ["SKAdNetworkIdentifier": "n38lu8286q.skadnetwork"],
                        ["SKAdNetworkIdentifier": "47vhws6wlr.skadnetwork"],
                        ["SKAdNetworkIdentifier": "kbd757ywx3.skadnetwork"],
                        ["SKAdNetworkIdentifier": "9t245vhmpl.skadnetwork"],
                        ["SKAdNetworkIdentifier": "a2p9lx4jpn.skadnetwork"],
                        ["SKAdNetworkIdentifier": "22mmun2rn5.skadnetwork"],
                        ["SKAdNetworkIdentifier": "44jx6755aq.skadnetwork"],
                        ["SKAdNetworkIdentifier": "k674qkevps.skadnetwork"],
                        ["SKAdNetworkIdentifier": "4468km3ulz.skadnetwork"],
                        ["SKAdNetworkIdentifier": "2u9pt9hc89.skadnetwork"],
                        ["SKAdNetworkIdentifier": "8s468mfl3y.skadnetwork"],
                        ["SKAdNetworkIdentifier": "klf5c3l5u5.skadnetwork"],
                        ["SKAdNetworkIdentifier": "ppxm28t8ap.skadnetwork"],
                        ["SKAdNetworkIdentifier": "kbmxgpxpgc.skadnetwork"],
                        ["SKAdNetworkIdentifier": "uw77j35x4d.skadnetwork"],
                        ["SKAdNetworkIdentifier": "578prtvx9j.skadnetwork"],
                        ["SKAdNetworkIdentifier": "4dzt52r2t5.skadnetwork"],
                        ["SKAdNetworkIdentifier": "tl55sbb4fm.skadnetwork"],
                        ["SKAdNetworkIdentifier": "c3frkrj4fj.skadnetwork"],
                        ["SKAdNetworkIdentifier": "e5fvkxwrpn.skadnetwork"],
                        ["SKAdNetworkIdentifier": "8c4e2ghe7u.skadnetwork"],
                        ["SKAdNetworkIdentifier": "3rd42ekr43.skadnetwork"],
                        ["SKAdNetworkIdentifier": "97r2b46745.skadnetwork"],
                        ["SKAdNetworkIdentifier": "3qcr597p9d.skadnetwork"]
                    ]
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            entitlements: "Configurations/App.entitlements",
            dependencies: [
                .feature("Meal"),
                .feature("Setting"),
                .core("Network"),
                .ui("DesignSystem"),
                .external(name: "FirebaseMessaging"),
                .external(name: "GoogleMobileAds"),
                .target(name: "MealWidgetExtension"),
            ]
        ),
        .target(
            name: "MealWidgetExtension",
            destinations: [.iPhone, .iPad],
            product: .appExtension,
            bundleId: "com.SemyungUniversityCafeteriafoodApp.ManduU2App.MealWidget",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .extendingDefault(
                with: [
                    "CFBundleShortVersionString": "2.0.0",
                    "CFBundleVersion": "1",
                    "CFBundleDisplayName": "학식 위젯",
                    "API_BASE_URL": "$(API_BASE_URL)",
                    "API_KEY": "$(API_KEY)",
                    "NSExtension": [
                        "NSExtensionPointIdentifier": "com.apple.widgetkit-extension",
                    ],
                ]
            ),
            sources: ["WidgetExtension/Sources/**"],
            resources: ["WidgetExtension/Resources/**"],
            dependencies: [
                .core("Network"),
                .core("Domain"),
                .core("Common"),
                .core("Utility"),
            ],
            settings: .settings(
                configurations: [
                    .debug(name: "Debug", xcconfig: "Configurations/Config.xcconfig"),
                    .release(name: "Release", xcconfig: "Configurations/Config.xcconfig"),
                ]
            )
        ),
        .target(
            name: "AppTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "com.SemyungUniversityCafeteriafoodApp.ManduU2AppTests",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [.target(name: "App")]
        ),
    ]
)
// ca-app-pub-1780050413977337~9607449866
