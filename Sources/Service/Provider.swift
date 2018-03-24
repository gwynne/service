import Async

/// Providers allow external projects to be easily
/// integrated into an application's service container.
///
/// Simply add the provider using services.register(Provider.self)
///
///The Provider should take care of setting up any
///necessary configurations on itself and the container.
public protocol Provider {
    /// This should be the name of the actual repository
    /// that contains the Provider.
    /// 
    /// this will be used for things like providing 
    /// resources
    ///
    /// this will default to stripped camel casing, 
    /// for example MyProvider will become `my-provider`
    /// if your Provider is providing resources
    /// it is HIGHLY recommended to provide a static let
    /// for performance considerations
    static var repositoryName: String { get }
    
    /// The location of the public directory
    /// _relative_ to the root of the provider package.
    static var publicDir: String { get }
    
    /// The location of the views directory
    /// _relative_ to the root of the provider package.
    static var viewsDir: String { get }

    /// Gives the provider a chance to detect information from the `Environment`.
    /// - parameters:
    ///     - env: Mutable `Environment`. This can be used to parse command line flags, fetch env variables, and more.
    func detect(_ env: inout Environment) throws
    
    /// Register all services provided by the provider here.
    func register(_ services: inout Services) throws

    /// Called before the container has fully initialized.
    func willBoot(_ worker: Container) throws -> Future<Void>

    /// Called after the container has fully initialized.
    func didBoot(_ worker: Container) throws -> Future<Void>
}

extension Provider {
    /// Called before the container has fully initialized.
    public func willBoot(_ worker: Container) throws -> Future<Void> {
        return .done(on: worker)
    }
}

// MARK: Optional

extension Provider {
    /// By default, the `Public` folder will be used as all `Provider`'s public dir.
    public static var publicDir: String {
        return "Public"
    }

    /// By default, the `Resources/Views` folder will be used for all `Provider`'s views dir.
    public static var viewsDir: String {
        return "Resources/Views"
    }

    /// By default, all providers will ignore the `Environment` during `detect(_:)`.
    public func detect(_ env: inout Environment) throws { }
}
