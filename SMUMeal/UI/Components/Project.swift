import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
    name: "Components",
    moduleType: .ui,
    dependencies: [
        .ui("DesignSystem")
    ]
)
