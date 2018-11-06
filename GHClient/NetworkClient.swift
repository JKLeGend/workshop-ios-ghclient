//
//  File.swift
//  GHClient
//
//  Created by Jukai Zhang on 2018/11/6.
//  Copyright © 2018 com.thoughtworks.workshop. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkClient {
    func get(url: URL, header: [String: String]?, completion: @escaping (Any?, Error?) -> Void)
}

class AlamofireNetworkClient:NetworkClient {
    func get(url: URL, header: [String: String]?, completion: @escaping (Any?, Error?) -> Void) {
        Alamofire.request(url, method: .get, parameters: nil, headers: header).responseJSON { dataResponse in
            print("dataResponse.value=====================")
            print(dataResponse.value)
            if (dataResponse.error != nil) {
              completion(nil, dataResponse.error)
                return
            }
        }
    }
}
