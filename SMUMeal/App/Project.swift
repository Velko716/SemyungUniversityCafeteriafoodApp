import ProjectDescription
import ProjectDescriptionHelpers

let swiftLintScript = TargetScript.pre(
    script: """
    export PATH="$PATH:/opt/homebrew/bin"
    ROOT_DIR="${SRCROOT%/*}"
    while [ ! -f "$ROOT_DIR/.swiftlint.yml" ] && [ "$ROOT_DIR" != "/" ]; do
        ROOT_DIR="${ROOT_DIR%/*}"
    done
    if which swiftlint > /dev/null && [ -f "$ROOT_DIR/.swiftlint.yml" ]; then
        cd "$ROOT_DIR"
        swiftlint --config "$ROOT_DIR/.swiftlint.yml" "$SRCROOT"
    else
        echo "warning: SwiftLint not installed or config not found"
    fi
    """,
    name: "SwiftLint",
    basedOnDependencyAnalysis: false
)

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
            scripts: [swiftLintScript],
            dependencies: [
                .feature("Meal"),
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
