////
////  kakaoAddressSearch.swift
////  Address-Finder
////
////  Created by Daye on 2021/08/16.
////
//
//import Foundation
//import Alamofire
//
//class APICall{
//    
//    let view: SearchView
//    let presenter: AddressSearchPresenter
//    
//    func doSearchAddress(keyword: String) {
//        let headers: HTTPHeaders = [ "Authorization": "KakaoAK 754d4ea04671ab9d7e2add279d718b0e" ]
//        let parameters: [String: Any] = [ "query": keyword ]
//
//        
//        Alamofire.request(
//            "https://dapi.kakao.com/v2/local/search/address.json",
//            method: .get,
//            parameters: parameters,
//            headers: headers
//        ).responseData{ response in
//            switch response.result {
//            case .success(let result):
//                do {
//                    let getInstanceData = try JSONDecoder().decode(APIResponse.self, from: result)
////                    searchSuccess(data: getInstanceData)
//                }
//                catch {
//                    print(error.localizedDescription)
////                    searchFail()
//                }
//            case .failure(let error):
//                print(error)
//            }
////            self.addressTableView.reloadData()
//            self.view.reloadData()
//        }
//    }
//}
