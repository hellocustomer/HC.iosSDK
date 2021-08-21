//
//  TouchPointService.swift
//  HelloCustomer
//
//  Created by Piotr Bandurski on 01/08/2021.
//

import Foundation


class TouchPointService {
    
    func downloadTouchPointConfig(
        touchPointId: String,
        resultDelegate: @escaping (TouchPointConfigLoadResult) -> Void
    ) {
        URLSession.shared.dataTask(with: URL(string: "http://api.site.com/json")!) { (data, _, error) -> Void in
            if error == nil && data != nil {
                do {
                    let decoder = JSONDecoder()
                    let config = try decoder.decode(TouchpointConfig.self, from: data!)
                    resultDelegate(.success(config))
                } catch {
                    resultDelegate(.error(error))
                }
            }
        }.resume()
    }
    
}

enum TouchPointConfigLoadResult {
    case success(TouchpointConfig)
    case error(Error)
}
