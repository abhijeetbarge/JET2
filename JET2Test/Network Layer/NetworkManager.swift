//
//  NetworkManager.swift
//  JET2Test
//
//  Created by Abhijeet Barge on 14/07/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import Foundation
import UIKit

struct Networking {

    func performNetworkTask<T: Codable>(endpoint: JET2API,
                                        type: T.Type,
                                        completion: ((_ response: T) -> Void)?) {
        let urlString = endpoint.baseURL.appendingPathComponent(endpoint.path).absoluteString.removingPercentEncoding
        print("Url : \(String(describing: urlString))")
        guard let urlRequest = URL(string: urlString ?? "") else { return }
        
        let progressView = ProgressView(text: "Fetching Data")
        let window = UIApplication.shared.keyWindow!
        window.addSubview(progressView)
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            DispatchQueue.main.async {
                progressView.removeFromSuperview()
            }
            if let _ = error {
                return
            }
            guard let data = data else {
                return
            }
            let response = Response(data: data)
            guard let decoded = response.decode(type) else {
                return
            }
            completion?(decoded)
        }
        urlSession.resume()
    }

}
