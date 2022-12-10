import Foundation

public enum RequestType: String {
    case get
    case post
    case delete
    case put
}


public struct Resource<T: Decodable> {
    let requestType: RequestType
    let parameters: [String: Any]?
    let url: URL
    let customHeaders: [String: String]?
}
