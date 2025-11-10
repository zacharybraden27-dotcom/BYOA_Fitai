//
//  NetworkService.swift
//  FitAI
//
//  Network service for API calls
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(Int)
    case unauthorized
    case unknown(Error)
}

class NetworkService {
    static let shared = NetworkService()
    
    private let session: URLSession
    private let baseURL: String
    
    private init() {
        self.baseURL = AppConfig.backendURL
        self.session = URLSession.shared
    }
    
    // Generic GET request
    func get<T: Decodable>(endpoint: String, headers: [String: String]? = nil) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return try await performRequest(request: request)
    }
    
    // Generic POST request
    func post<T: Decodable>(endpoint: String, body: Encodable, headers: [String: String]? = nil) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            throw NetworkError.unknown(error)
        }
        
        return try await performRequest(request: request)
    }
    
    // Generic PUT request
    func put<T: Decodable>(endpoint: String, body: Encodable, headers: [String: String]? = nil) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            throw NetworkError.unknown(error)
        }
        
        return try await performRequest(request: request)
    }
    
    // Generic DELETE request
    func delete<T: Decodable>(endpoint: String, headers: [String: String]? = nil) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return try await performRequest(request: request)
    }
    
    // Perform request and decode response
    private func performRequest<T: Decodable>(request: URLRequest) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknown(NSError(domain: "NetworkService", code: -1))
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    return try decoder.decode(T.self, from: data)
                } catch {
                    print("Decoding error: \(error)")
                    throw NetworkError.decodingError
                }
            case 401:
                throw NetworkError.unauthorized
            default:
                throw NetworkError.serverError(httpResponse.statusCode)
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}

// Helper extension to encode any Encodable
extension Encodable {
    func encode() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

