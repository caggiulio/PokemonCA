//
//  Networking.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

// MARK: - Networking

/// Public class used to build an object that will deal with HTTP calls. It's builded with the `baseURL` and the `WebServiceInterceptorProtocol` passed on init.
public class Networking: NSObject, NetworkingProtocol {
  // MARK: - Business logic properties

  private let session: URLSession
  private let baseURL: URL
  private var logger = NetworkingLogger()

  /// The init of a Networking instance.
  /// - Parameter baseURL: The host baseURL for this instance of Networking
  public init(baseURL: String, cachePolicy: NSURLRequest.CachePolicy) {
    guard let url = URL(string: baseURL) else { fatalError("Base URL cannot be invalid!") }
    self.baseURL = url

    let configuration = URLSessionConfiguration.default
    configuration.requestCachePolicy = cachePolicy
    session = .init(configuration: configuration)
  }

  public func send<SuccessResponse: Decodable>(request: NetworkingRequest, completion: ((Result<SuccessResponse, Error>) -> Void)?) {
    send(request: request, decoder: JSONDecoder(), completion: completion)
  }

  public func send<SuccessResponse>(request: NetworkingRequest, decoder: JSONDecoder, completion: ((Result<SuccessResponse, Error>) -> Void)?) where SuccessResponse: Decodable {
    guard let finalUrl = makeUrl(path: request.path.url, queryItems: request.path.query) else {
      completion?(.failure(NetworkingError.invalidUrl))
      return
    }

    let request = makeRequest(url: finalUrl, request: request)
    send(request: request, completion: { result in
      switch result {
        case let .success(result):
          do {
            let decodedObject = try decoder.decode(SuccessResponse.self, from: result)
            completion?(.success(decodedObject))
          } catch {
            completion?(.failure(NetworkingError.decodingFailed(error: error)))
          }
        case let .failure(error):
          completion?(.failure(error))
      }
    })
  }
}

// MARK: - Private methods

private extension Networking {
  /// This method is used to build an `URL` object
  func makeUrl(path: String, queryItems: [URLQueryItem]?) -> URL? {
    var components = URLComponents()
    components.scheme = baseURL.scheme
    components.host = baseURL.host
    components.path = baseURL.path + path
    components.queryItems = queryItems
    guard let url = components.url else { return nil }
    return url
  }

  /// This method is used to build an `URLRequest` object
  func makeRequest(url: URL, request: NetworkingRequest) -> URLRequest {
    var finalRequest = URLRequest(url: url)
    finalRequest.httpMethod = request.method.rawValue

    request.header?.forEach { key, value in
      if let value = value as? String {
        finalRequest.setValue(value, forHTTPHeaderField: key)
      }
    }

    switch request.body?.encoding {
      case .json:
        guard let dictionary = request.body?.data.dictionary else { break }
        finalRequest.httpBody = try? JSONSerialization.data(withJSONObject: dictionary)
      case .urlEncoded:
        guard let params = request.body?.data.dictionary else { break }
        let httpBody = params
          .map { key, value -> String in
            "\(key)=\(value)"
          }
          .joined(separator: "&")
          .data(using: String.Encoding.utf8)
        finalRequest.httpBody = httpBody
      case .none:
        break
    }

    return finalRequest
  }
}

private extension Networking {
  /// This func is the final step to make an HTTP call using the `dataTask`method.
  func send(request: URLRequest, completion: ((Result<Data, Error>) -> Void)?) {
    let task = session.dataTask(with: request) { data, response, error in
      if let httpResponse = response as? HTTPURLResponse {
        let statusCode = httpResponse.statusCode

        switch statusCode {
          case 200 ... 299:
            self.logger.logResponse(response, data: data)
            if let data = data {
              DispatchQueue.main.async {
                completion?(.success(data))
              }
            } else {
              DispatchQueue.main.async {
                completion?(.failure(NetworkingError.underlying(response: httpResponse, data: nil)))
              }
            }
          default:
            let error = NetworkingError.underlying(response: response, data: data)
            self.logger.logResponse(response, data: data, error: error)
            DispatchQueue.main.async {
              completion?(.failure(error))
            }
        }
      } else {
        DispatchQueue.main.async {
          completion?(.failure(NetworkingError.invalidHTTPResponse))
        }
      }
    }
    task.resume()
  }
}
