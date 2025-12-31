import ProjectDescription

public extension Project {
    static func make(
        name: String,
        moduleType: ModuleType,
        dependencies: [TargetDependency] = []
    ) -> Project {
        let target = Target.target(
            name: name,
            destinations: .iOS,
            product: moduleType.product,
            bundleId: "com.smumeal.\(name.lowercased())",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: moduleType == .app ? ["Resources/**"] : nil,
            dependencies: dependencies
        )

        return Project(
            name: name,
            targets: [target]
        )
    }
}
