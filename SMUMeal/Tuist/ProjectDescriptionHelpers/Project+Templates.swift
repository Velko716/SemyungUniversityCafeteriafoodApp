import ProjectDescription

public extension Project {
    static func make(
        name: String,
        moduleType: ModuleType,
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = []
    ) -> Project {
        let targetResources: ResourceFileElements? = {
            if let resources = resources {
                return resources
            }
            return moduleType == .app ? ["Resources/**"] : nil
        }()

        let target = Target.target(
            name: name,
            destinations: .iOS,
            product: moduleType.product,
            bundleId: "com.smumeal.\(name.lowercased())",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: targetResources,
            dependencies: dependencies
        )

        return Project(
            name: name,
            targets: [target]
        )
    }
}
