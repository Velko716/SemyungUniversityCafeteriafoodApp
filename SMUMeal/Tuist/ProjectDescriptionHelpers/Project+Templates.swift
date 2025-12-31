import ProjectDescription

public extension Project {
    static func make(
        name: String,
        moduleType: ModuleType,
        dependencies: [TargetDependency] = []
    ) -> Project {
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

        let target = Target.target(
            name: name,
            destinations: .iOS,
            product: moduleType.product,
            bundleId: "com.smumeal.\(name.lowercased())",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: moduleType == .app ? ["Resources/**"] : nil,
            scripts: [swiftLintScript],
            dependencies: dependencies
        )

        return Project(
            name: name,
            targets: [target]
        )
    }
}
