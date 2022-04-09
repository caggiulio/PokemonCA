//
//  NetworkingLogger.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

/** This class is used to log a HTTP request and his response
 */
class NetworkingLogger {
    // MARK: - Internal methods
    func logResponse(_ response: URLResponse?, data: Data?, error: Error? = nil) {
        
        print("\n⬇️ ----- START RESPONSE ----- ⬇️")
        if let response = response as? HTTPURLResponse {
            print("    -- Url: \(response.url?.absoluteString ?? "NO URL")")
            
            let statusCode = response.statusCode
            if statusCode >= 200 && statusCode < 300 {
                print("    -- Status Code: ✅ \(statusCode)")
            } else {
                print("    -- Status Code: ❌ \(statusCode)")
            }
        } else {
            print("    -- Response: NO RESPONSE")
        }
        if let data = data {
            if let stringBody = String(data: data, encoding: .utf8) {
                print("    -- Body : \(stringBody)")
            } else {
                print("    -- Body : NO HTTP BODY")
            }
        } else {
            print("    -- data: NO DATA")
        }
        if let error = error {
            print("    -- Error: 🚨 \(error.localizedDescription)")
        } else {
            print("    -- Error: 👌 NO ERROR")
        }
        print("⬇️ ----- END RESPONSE ----- ⬇️")
    }
    
}
