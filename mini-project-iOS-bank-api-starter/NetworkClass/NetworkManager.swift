//
//  NetworkManager.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Nawaf Almutairi on 05/03/2024.
//

import Foundation
import Alamofire
class NetworkManager {
    private let baseUrl = "https://coded-bank-api.eapi.joincoded.com/"
    
    static let shared = NetworkManager()
    
    func signup(user: User, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let url = baseUrl + "signup"
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
    func signIn(username: String, password: String, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let url = baseUrl + "signin"
        let parameters: [String: String] = ["username": username, "password": password]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .responseDecodable(of: TokenResponse.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let afError):
                    completion(.failure(afError as Error))
                }
            }
    }
    func deposit(token: String, amountChange: AmountChange, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseUrl + "deposit"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, method: .put, parameters: amountChange, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    
    //MARK: OTHER Networking Functions
    
    func withdraw(token: String, amountChange: AmountChange, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseUrl + "withdraw"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, method: .put, parameters: amountChange, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchUser(token: String, completion: @escaping (Result<UserDetail, Error>) -> Void) {
                   let url = baseUrl + "account"
                   let headers: HTTPHeaders = [.authorization(bearerToken: token)]

                   AF.request(url, headers: headers).responseDecodable(of: UserDetail.self) { response in
                       switch response.result {
                       case .success(let user):
                           completion(.success(user))
                       case .failure(let error):
                           completion(.failure(error))
                       }
                   }
               }
    func fetchTransactions(token: String, completion: @escaping (Result<[Transaction], Error>) -> Void) {
           let url = baseUrl + "transactions"
           let headers: HTTPHeaders = [.authorization(bearerToken: token)]
            AF.request(url, headers: headers).responseDecodable(of: [Transaction].self) { response in
                switch response.result {
                case .success(let transaction):
                    completion(.success(transaction))
                case .failure(let error):
                    completion(.failure(error))
                    if let data = response.data, let str = String(data: data, encoding: .utf8) {
                                        print("Raw response: (str)")
                    }
                   }
                }

           }
}
