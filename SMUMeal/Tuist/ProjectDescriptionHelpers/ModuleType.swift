import ProjectDescription

public enum ModuleType {
    case app
    case feature
    case core
    case ui

    public var name: String {
        switch self {
        case .app: return "App"
        case .feature: return "Feature"
        case .core: return "Core"
        case .ui: return "UI"
        }
    }

    public var product: Product {
        switch self {
        case .app: return .app
        case .feature, .core, .ui: return .staticFramework
        }
    }
}
