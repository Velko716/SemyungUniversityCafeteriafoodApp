import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
    name: "UIComponents",
    moduleType: .ui,
    dependencies: [
        .ui("DesignSystem"),
        .core("Domain"),
    ]
)
