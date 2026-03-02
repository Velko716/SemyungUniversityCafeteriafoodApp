import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
    name: "Repository",
    moduleType: .core,
    dependencies: [
        .core("Domain"),
        .core("Network"),
    ]
)
