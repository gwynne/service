public struct TypeServiceFactory<S: ServiceType>: ServiceFactory {
    public var serviceType: Any.Type {
        return S.self
    }

    public var serviceName: String {
        return S.serviceName
    }

    public var serviceIsSingleton: Bool {
        return S.serviceIsSingleton
    }

    public var serviceSupports: [Any.Type] {
        return S.serviceSupports
    }

    public func makeService(for container: Container) throws -> Any? {
        return try S.makeService(for: container)
    }

    public init(_ s: S.Type = S.self) { }
}
