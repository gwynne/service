import Async

public protocol ServiceType {
    /// An array of protocols (or types) that this
    /// service conforms to. 
    ///     ex. when `container.make(X.self)`
    ///     is called, all services that support `X`
    ///     will be considered.
    static var serviceSupports: [Any.Type] { get }

    /// If true, the service will only be initialized once.
    static var serviceIsSingleton: Bool { get }

    /// Creates a new instance of the service
    /// Using the service container.
    static func makeService(for worker: Container) throws -> Self
}

/// MARK: Optional

extension ServiceType {
    /// See `ServiceType.serviceIsSingleton`
    public static var serviceIsSingleton: Bool {
        return false
    }

    /// See `ServiceType.serviceSupports`
    public static var serviceSupports: [Any.Type] {
        return []
    }
}
