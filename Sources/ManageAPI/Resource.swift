import Foundation

public enum RequestType: String {
    case get
    case post
    case delete
    case put
}


public struct Resource<T: Decodable> {
    public let requestType: RequestType
    public let parameters: [String: Any]?
    public let url: URL
    public let customHeaders: [String: String]?
    
    public init(requestType: RequestType, parameters: [String : Any]?, url: URL, customHeaders: [String : String]?) {
        self.requestType = requestType
        self.parameters = parameters
        self.url = url
        self.customHeaders = customHeaders
    }
}
