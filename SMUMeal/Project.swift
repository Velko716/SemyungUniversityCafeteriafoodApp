import ProjectDescription

let project = Project(
  name: "SMUMeal",
  targets: [
    .target(
      name: "SMUMeal",
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
      sources: ["SMUMeal/Sources/**"],
      resources: ["SMUMeal/Resources/**"],
      dependencies: []
    ),
    .target(
      name: "SMUMealTests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "com.SemyungUniversityCafeteriafoodApp.ManduU2AppTests",
      deploymentTargets: .iOS("17.0"),
      infoPlist: .default,
      sources: ["SMUMeal/Tests/**"],
      dependencies: [.target(name: "SMUMeal")]
    ),
  ]
)
