import Vapor

struct MicrosoftCallbackBody: Content {
    let code: String
    let clientId: String
    let clientSecret: String
    let redirectURI: String
    let scope: String
    let grantType: String = "authorization_code"

    static let defaultContentType: HTTPMediaType = .urlEncodedForm

    enum CodingKeys: String, CodingKey {
        case code
        case clientId = "client_id"
        case clientSecret = "client_secret"
        case redirectURI = "redirect_uri"
        case grantType = "grant_type"
        case scope
    }
}
