@_exported import ImperialCore
import Vapor

public struct Microsoft: FederatedService {
    @discardableResult
    public init(
        routes: some RoutesBuilder,
        authenticate: String,
        authenticateCallback: (@Sendable (Request) async throws -> Void)?,
        callback: String,
        scope: [String] = [],
        completion: @escaping @Sendable (Request, String) async throws -> some AsyncResponseEncodable
    ) throws {
        try MicrosoftRouter(callback: callback, scope: scope, completion: completion)
            .configureRoutes(withAuthURL: authenticate, authenticateCallback: authenticateCallback, on: routes)
    }
}
