import Foundation

//TODO: Support iOS 13 and above...
public final class ManageAPI {
    
    private init() {}
    public let shared = ManageAPI()
    
    // default headers.
    // set headers option
    // custom headers can be passed with resource object.
    
    public func PerformRequest<T>(resource: Resource<T>,completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: resource.url)
        request.addHeaders(resource.customHeaders)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            else {
                do  {
                    if let data = data {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(result))
                    }
                    else {
                        completion(.failure(APIError.invalidData))
                    }
                } catch let error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    public func performRequest<T>(resource: Resource<T>) async -> Result<T,Error> {
        var request = URLRequest(url: resource.url)
        
        if let headers = resource.customHeaders {
            request.allHTTPHeaderFields = headers
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let result = try JSONDecoder().decode(T.self, from: data)
            return .success(result)
            
        } catch let error {
            return .failure(error)
        }
    }
}


extension URLRequest {
    mutating func addHeaders(_ headers: [String: String]?) {
        if let customHeaders = headers {
            self.allHTTPHeaderFields = customHeaders
            addAdditionalHeader()
        }
        else {
            addAdditionalHeader()
        }
    }
    
    mutating private func addAdditionalHeader() {
        self.setValue("Content-Type", forHTTPHeaderField: "application/json")
    }
}
