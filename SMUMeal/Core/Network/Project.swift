import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
    name: "Network",
    moduleType: .core,
    dependencies: [
        .core("Domain"),
        .core("Common"),
        .core("Utility")
    ]
)
