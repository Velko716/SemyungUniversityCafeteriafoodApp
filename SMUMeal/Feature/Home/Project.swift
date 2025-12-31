import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
    name: "Home",
    moduleType: .feature,
    dependencies: [
        .ui("Components"),
        .core("Network")
    ]
)
