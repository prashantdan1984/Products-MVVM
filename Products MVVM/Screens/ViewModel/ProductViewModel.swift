//
//  ProductViewModel.swift
//  Products MVVM
//
//  Created by Prashantdan on 27/01/24.
//

import Foundation
import Alamofire

final class ProductViewModel {
    var product: [Product] = []
    var eventHandler: ((_ event: Events) -> Void)? //Data binding Closer
    
    func fetchproducts() {
        self.eventHandler?(.loading)
        APIHelper.shared.request(
            modelType: [Product].self,
            type: EndPointItem.products) { response in
                self.eventHandler?(.stopLoading)
                switch response{
                case .success(let products):
                    self.eventHandler?(.dataLoaded)
                    print(products)
                    self.product = products
                case .failure(let error):
                    print(error)
                    self.eventHandler?(.error(error))
                }
            }
    }
//    func fetchproducts() {
//        self.eventHandler?(.loading)
//        APIHelper.shared.fetchProduct { response in
//            self.eventHandler?(.stopLoading)
//            switch response{
//            case .success(let products):
//                self.eventHandler?(.dataLoaded)
//                print(products)
//                self.product = products
//            case .failure(let error):
//                print(error)
//                self.eventHandler?(.error(error))
//            }
//        }
//    }
}

extension ProductViewModel {
    enum Events {
        case loading
        case stopLoading
        case dataLoaded
        case error(_ error: Error?)
    }
}
