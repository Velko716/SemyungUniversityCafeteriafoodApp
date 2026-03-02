import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
    name: "Meal",
    moduleType: .feature,
    dependencies: [
        .ui("UIComponents"),
        .core("Repository"),
        .core("Utility"),
        .core("Network"),
        .feature("Setting"),
    ],
    hasDemo: true
)
