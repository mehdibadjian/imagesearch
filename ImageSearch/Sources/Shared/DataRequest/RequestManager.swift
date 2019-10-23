//
//  RequestManager.swift
//
//  Created by Mehdi on 25/9/19.
//  Copyright © 2019 Mehdi. All rights reserved.
//
import Foundation
class RequestManager: NSObject {
    static let sharedInstance = RequestManager()
    static var defaultTimeoutInterval: TimeInterval = 30
    fileprivate func getRequest(_ url: URL, timeoutInterval: TimeInterval = RequestManager.defaultTimeoutInterval) -> NSMutableURLRequest {
        let theRequest = NSMutableURLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: timeoutInterval)
        theRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        theRequest.addValue("contextualwebsearch-websearch-v1.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        theRequest.addValue(AppConstants.apiKey, forHTTPHeaderField: "x-rapidapi-key")
        theRequest.httpMethod = "GET"
        return theRequest
    }
    fileprivate func session(_ url: URL) -> URLSession {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        var session = URLSession(configuration: config, delegate: nil, delegateQueue: nil)
        if let urlScheme = url.scheme {
            if urlScheme == "https" {
                session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
            }
        }
        return session
    }
    func get(urlString: String,
             completion: @escaping (Bool, [AnyHashable: Any]?, NSError?) -> Void ) {
        if let url = URL(string: urlString) {
            let session = self.session(url)
            session.dataTask(with: self.getRequest(url) as URLRequest,
                             completionHandler: {(data, response, error) in
                                if data != nil {
                                    if let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [AnyHashable: Any] {
                                        if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                                            let (data, error) = self.handleResponse(url, response: json)
                                            if data != nil {
                                                completion(true, data, nil)
                                            } else {
                                                completion(false, nil, error)
                                            }
                                        } else {
                                            completion(false, json, NSError(domain: "error", code: 1, userInfo: [:]))
                                        }
                                    } else {
                                        completion(false, nil, NSError(domain: "error", code: 1, userInfo: [:]))
                                    }
                                } else {
                                    completion(false, nil, NSError(domain: "error", code: 1, userInfo: [:]))
                                }
            }).resume()
        } else {
            completion(false, nil, NSError(domain: "error", code: 1, userInfo: [:]))
        }
    }
    func handleResponse(_ url: URL, response: [AnyHashable: Any]?) -> ([AnyHashable: Any]?, NSError?) {
        fatalError("overrite this function")
    }
    func updateSession(_ url: URL, response: [AnyHashable: Any]?) {
        fatalError("overrite this function")
    }
}
extension RequestManager: URLSessionTaskDelegate {
    public func urlSession(_ session: URLSession,
                           didReceive challenge: URLAuthenticationChallenge,
                           completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        guard challenge.previousFailureCount == 0 else {
            challenge.sender?.cancel(challenge)
            // Inform the user that the user name and password are incorrect
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        let protectSpace = challenge.protectionSpace
        if let sender = challenge.sender {
            if protectSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                //TRUST invalid HTTPS://
                if let trust = protectSpace.serverTrust {
                    let cred = URLCredential(trust: trust)
                    sender.use(cred, for: challenge)
                    completionHandler(.useCredential, cred)
                    return
                }
            }
            sender.performDefaultHandling!(for: challenge)
        }
    }
}

