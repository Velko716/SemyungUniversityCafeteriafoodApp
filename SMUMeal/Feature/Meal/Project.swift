import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
    name: "Meal",
    moduleType: .feature,
    dependencies: [
        .feature("Settings"),
        .ui("Components"),
        .core("Repository"),
        .core("Network"),
        .core("Utility"),
    ]
)
