import ProjectDescription

public extension TargetDependency {
    // MARK: - Feature Modules

    static func feature(_ name: String) -> TargetDependency {
        .project(target: name, path: .relativeToRoot("Feature/\(name)"))
    }

    // MARK: - Core Modules

    static func core(_ name: String) -> TargetDependency {
        .project(target: name, path: .relativeToRoot("Core/\(name)"))
    }

    // MARK: - UI Modules

    static func ui(_ name: String) -> TargetDependency {
        .project(target: name, path: .relativeToRoot("UI/\(name)"))
    }
}
