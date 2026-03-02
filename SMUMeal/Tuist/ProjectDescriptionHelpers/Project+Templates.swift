import ProjectDescription

public extension Project {
    static func make(
        name: String,
        moduleType: ModuleType,
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = [],
        hasDemo: Bool = false
    ) -> Project {
        let targetResources: ResourceFileElements? = {
            if let resources = resources {
                return resources
            }
            return moduleType == .app ? ["Resources/**"] : nil
        }()

        let mainTarget = Target.target(
            name: name,
            destinations: [.iPhone],
            product: moduleType.product,
            bundleId: "com.smumeal.\(name.lowercased())",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: targetResources,
            dependencies: dependencies
        )

        var targets: [Target] = [mainTarget]
        var schemes: [Scheme] = []

        // Demo 앱 타겟 추가
        if hasDemo && moduleType == .feature {
            var demoDependencies: [TargetDependency] = [.target(name: name)]
            demoDependencies.append(contentsOf: dependencies)

            let demoTarget = Target.target(
                name: "\(name)Demo",
                destinations: [.iPhone],
                product: .app,
                bundleId: "com.smumeal.\(name.lowercased()).demo",
                deploymentTargets: .iOS("17.0"),
                infoPlist: .extendingDefault(with: [
                    "CFBundleDisplayName": "\(name) Demo",
                    "UILaunchScreen": [:]
                ]),
                sources: ["Demo/**"],
                resources: nil,
                dependencies: demoDependencies
            )
            targets.append(demoTarget)

            // Demo 스킴 추가
            let demoScheme = Scheme.scheme(
                name: "\(name)Demo",
                buildAction: .buildAction(targets: [.target("\(name)Demo")]),
                runAction: .runAction(configuration: .debug, executable: .target("\(name)Demo"))
            )
            schemes.append(demoScheme)
        }

        return Project(
            name: name,
            targets: targets,
            schemes: schemes
        )
    }
}
