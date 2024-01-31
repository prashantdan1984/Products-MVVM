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
            type: ProductEndPoint.products) { response in
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
    func addProduct(parameters: AddProduct) {
        APIHelper.shared.request(modelType: AddProduct.self,
                                 type: ProductEndPoint.addProduct(product: parameters)) { results in
            switch results {
            case .success(let product):
                self.eventHandler?(.newProductAdded(product: product))
            case .failure(let error):
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
        case error(Error?)
        case newProductAdded(product: AddProduct)
    }
}
