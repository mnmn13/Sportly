    //
    //  APIError.swift
    //  Sportly
    //
    //  Created by MN on 09.07.2023.
    //  Copyright © 2023 Nikita Moshyn. All rights reserved.
    //

    import Foundation
    import Alamofire

    // MARK: - Error Genesis
    enum ErrorGenesis: Error {
        case networkError(NetworkError)
        case basicError(BasicError)
        case storageError(StorageError)
        case testingError(TestingModeError)
    }

    // MARK: - Network error
    enum NetworkError: Error {
        case connectionError
        case invalidURL
        case requestFailed
    }

    // MARK: - Basic error
    enum BasicError: Error {
        case noneViewModel
        case dataError
    }

    // MARK: - Storage error
    enum StorageError: Error {
        case notAvailable
    }

    // MARK: - Testing mode error
    enum TestingModeError: Error {
        case jsonFileError
        case jsonDecodingError
        case jsonFileNotFound
    }

    // MARK: - Error Genesis extension
    extension ErrorGenesis {
        func handleError(file: StaticString = #file, line: UInt = #line) {
            
        }
        
        func fatalHandle(file: StaticString = #file, line: UInt = #line) {
            
        }
        
        private func getError() {
            
        }
    }

    // MARK: - Network error extension


    // MARK: - Basic error extension
    extension BasicError: LocalizedError {
        var localizedDescription: String {
            switch self {
            case .noneViewModel: return "ViewModel is nil"
            case .dataError: return "Unknown Data Error"
            }
        }
        
        
    }

    // MARK: - Storage error extension
    extension StorageError: LocalizedError {
        var localizedDescription: String {
            switch self {
            case .notAvailable: return "Saving is not carried out"
            }
        }
    }

    // MARK: - Testing mode error extension
    extension TestingModeError: LocalizedError {
        var localizedDescription: String {
            switch self {
            case .jsonFileError: return "Something wrong with JSON file"
            case .jsonDecodingError: return "something wrong with JSON decoding"
            case .jsonFileNotFound: return "JSON file not found"
            }
        }
    }

    // MARK: - Error extension
    extension Error {
        func handleError() {
            if let error = self as? ErrorGenesis {
                
            }
        }
    }

    @available(*, deprecated, message: "Removal required")
    struct ErrorGenesi2s: Error {
        
        let message: String
        let code: Int?
        let error: Error?
        
        init(_ code: Int) {
            self.code = code
            self.error = nil
            switch code {
            case 400: message = "Bad Request"
            case 401: message = "Unauthorized"
            case 403: message = "Forbidden"
            case 404: message = "Not Found"
            case 500: message = "Internal Server Error"
            case 502: message = "Bad Gateway"
            case 503: message = "Service Unavailable"
            default: message = "Unknown error"
            }
        }
        
    //    init(_ error: Error) {
    //        self.error = error
    //
    //    }
        
        private func printError() {
            
        }
    }



    // MARK: - Response Handling

    extension AFDataResponse {
        func handleResponseError() {
            guard let statusCode = self.response?.statusCode else {
                ErrorGenesis.networkError(.requestFailed).handleError()
                return
            }
            
            switch statusCode {
            case 400: print("Bad Request")
            case 401: print("Unauthorized")
            case 403: print("Forbidden")
            case 404: print("Not Found")
            case 500: print("Internal Server Error")
            case 502: print("Bad Gateway")
            case 503: print("Service Unavailable")
            default:  print("Unknown error")
                
                BannerManager.shared.show(.error, "Request error")
            }
        }
    }
