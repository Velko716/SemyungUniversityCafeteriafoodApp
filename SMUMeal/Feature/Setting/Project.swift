import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
    name: "Setting",
    moduleType: .feature,
    dependencies: [
        .ui("UIComponents")
    ],
    hasDemo: true
)
