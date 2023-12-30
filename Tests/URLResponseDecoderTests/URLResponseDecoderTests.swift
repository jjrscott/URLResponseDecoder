import XCTest
@testable import URLResponseDecoder

enum HTTPResponse<Continue: Decodable & Equatable, OK: Decodable & Equatable, BadRequest: Decodable & Equatable, Unauthorized: Decodable & Equatable, NotFound: Decodable & Equatable, Default: Decodable & Equatable>: Decodable, Equatable {
    case `continue`(Continue)
    case ok(OK)
    case badRequest(BadRequest)
    case unauthorized(Unauthorized)
    case notFound(NotFound)
    
        
    case `default`(Default)
    
    enum CodingKeys: Int, CodingKey {
        case `continue` = 100
        case ok = 200
        case badRequest = 400
        case unauthorized = 401
        case notFound = 404
        case `default`
    }
}

struct NotFound: Codable, Equatable {
    let message: String
}

enum CustomResponse: Codable, Equatable {
    case `continue`
    case ok(String)
    case notFound(NotFound)
    case unauthorized(Data)

    enum CodingKeys: Int, CodingKey {
        case `continue` = 100
        case ok = 200
        case notFound = 404
        case unauthorized = -999
    }
}

final class URLResponseDecoderTests: XCTestCase {
    func testExample() throws {
        let response = HTTPURLResponse(url: URL(string: "bob")!, statusCode: 404, httpVersion: nil, headerFields: ["Content-Type":"application/json"])!

        typealias Payload = HTTPResponse<Data, String, Data, Data, NotFound, String>
        
        let responseDecoder = URLResponseDecoder()
        let payload = try responseDecoder.decode(Payload.self, from: (#"{"message" : "Hello World"}"#.data(using: .utf8)!, response))

        XCTAssertEqual(payload, .notFound(NotFound(message: "Hello World")))
    }
    
    func testExample2() throws {
        let response = HTTPURLResponse(url: URL(string: "bob")!, statusCode: 404, httpVersion: nil, headerFields: ["Content-Type":"application/json"])!
        
        let responseDecoder = URLResponseDecoder()
        let payload = try responseDecoder.decode(CustomResponse.self, from: (#"{"message" : "Hello World"}"#.data(using: .utf8)!, response))

        XCTAssertEqual(payload, .notFound(NotFound(message: "Hello World")))
    }
 
    func testExample3() throws {
        let response = HTTPURLResponse(url: URL(string: "bob")!, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type":"application/json"])!

        typealias Payload = HTTPResponse<Data, Int, Data, Data, Data, Data>
        
        let responseDecoder = URLResponseDecoder()
        let payload = try responseDecoder.decode(Payload.self, from: (#"10"#.data(using: .utf8)!, response))

        XCTAssertEqual(payload, .ok(10))
    }
}
