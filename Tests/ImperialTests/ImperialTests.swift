import ImperialAuth0
import ImperialDeviantArt
import ImperialDiscord
import ImperialDropbox
import ImperialFacebook
import ImperialGitHub
import ImperialGitlab
import ImperialGoogle
import ImperialImgur
import ImperialKeycloak
import ImperialMicrosoft
import ImperialMixcloud
import Testing
import XCTVapor

@testable import ImperialCore

@Suite("Imperial Tests", .serialized)
struct ImperialTests {
    @Test("Google Route")
    func googleRoute() async throws {
        try await withApp(service: Google.self) { app in
            try await app.test(
                .GET, apiAuthURL,
                afterResponse: { res async throws in
                    #expect(res.status == .seeOther)
                }
            )

            try await app.test(
                .GET, "\(apiCallbackURL)?code=123",
                afterResponse: { res async throws in
                    // Google returns a 400 Bad Request error when the code is invalid with a JSON error message
                    #expect(res.status == .badRequest)
                }
            )
        }
    }

    @Test("Google JWT Route")
    func googleJWTRoute() async throws {
        try await withApp(service: GoogleJWT.self) { app in
            try await app.test(
                .GET, apiAuthURL,
                afterResponse: { res async throws in
                    #expect(res.status == .seeOther)
                }
            )

            try await app.test(
                .GET, apiCallbackURL,
                afterResponse: { res async throws in
                    // We don't have a valid key to sign the JWT
                    #expect(res.status == .internalServerError)
                }
            )
        }
    }

    @Test("ImperialError")
    func imperialError() {
        let variable = "test"
        let imperialError = ImperialError.missingEnvVar(variable)
        #expect(
            imperialError.description
                == "ImperialError(errorType: \(imperialError.errorType.base.rawValue), missing enviroment variable: \(variable))"
        )
        #expect(ImperialError.missingEnvVar("foo") == ImperialError.missingEnvVar("bar"))
    }
}
