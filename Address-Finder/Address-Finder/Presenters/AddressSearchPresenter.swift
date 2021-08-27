//
//  AddressSearchPresenter.swift
//  Address-Finder
//
//  Created by Daye on 2021/08/17.
//

import Foundation
import UIKit
import Alamofire

protocol SearchAddressPresenterDelegate: AnyObject{
    func presentAddress(result: [Documents])
}

class SearchAddressPresenter: SearchAddressPresenterDelegate{
    var delegate: SearchAddressPresenterDelegate?

    func presentAddress(result: [Documents]) {
        print("hello?")
    }
        
    func doSearchAddress(keyword: String) {
        let headers: HTTPHeaders = [ "Authorization": "KakaoAK 754d4ea04671ab9d7e2add279d718b0e" ]
        let parameters: [String: Any] = [ "query": keyword ]
        
        Alamofire.request(
            "https://dapi.kakao.com/v2/local/search/address.json",
            method: .get,
            parameters: parameters,
            headers: headers
        ).responseData{ response in
            switch response.result {
            case .success(let result):
                do {
                    let getInstanceData = try JSONDecoder().decode(APIResponse.self, from: result)
                    self.delegate?.presentAddress(result: getInstanceData.documents)
                }
                catch {
                    print(error.localizedDescription)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func setViewDelegate(delegate: SearchAddressPresenterDelegate & UIViewController){
        self.delegate = delegate
    }
}
