import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
    name: "Meal",
    moduleType: .feature,
    dependencies: [
        .ui("Components"),
        .core("Repository"),
        .core("Utility")
    ]
)
