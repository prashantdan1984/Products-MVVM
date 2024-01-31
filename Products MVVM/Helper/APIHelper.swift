//
//  APIHelper.swift
//  Products MVVM
//
//  Created by Prashantdan on 20/01/24.
//

import Foundation

//Singleton Design Pattern Caps "S" object not allowed to create out of the class
// final keyword will help to manage restrict inheritans of singaleton class
enum Dataerror: Error {
    case invalidresponse
    case invalidurl
    case invaliddata
    case network(Error?)
}
//typealias Handler = (Result<[Product], Dataerror>) -> Void
typealias Handler<T> = (Result<T, Dataerror>) -> Void


final class APIHelper {
    
    static let shared = APIHelper()
    //var arrproduct = []
    private init() {}
    
    func request<T: Codable>(
        modelType: T.Type,
        type: EndPointType,
        completion: @escaping Handler<T>) {
            
            guard let url = type.url else {
                completion(.failure(.invalidurl))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = type.method.rawValue
            
            if let parameterts = type.body {
    
                print(parameterts)
               // var temp = parameterts
                request.httpBody = try? JSONEncoder().encode(type.body as! AddProduct)
                
                //var product: AddProduct = parameterts as! AddProduct
                //product.title
                //request.httpBody = try? JSONEncoder().encode(product)
               // var temp = try? JSONEncoder().encode(parameterts)//(AddProduct(title: "BMW Car"))
              //  request.httpBody = try? JSONEncoder().encode(AddProduct(title: "BMW Car"))//(type.body)
            }
            request.allHTTPHeaderFields = type.headers
            
            //Background Task
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else{
                    completion(.failure(.invaliddata))
                    return
                }
    
                guard let response = response as? HTTPURLResponse,
                      200 ... 299 ~= response.statusCode else {
                          completion(.failure(.invalidresponse))
                          return
                      }
    
                // Jsondecoder is converting data to model
                do{
                    let products = try JSONDecoder().decode(modelType, from: data)
                    completion(.success(products))
                }catch{
                    completion(.failure(.network(error)))
                }
    
            }.resume()
        }
    static var commonheader: [String: String] {
        return[
            "Content-Type": "application/json"
        ]
    }
//    func fetchProduct(completion: @escaping Handler) {
//        guard let url = URL(string: Constant.API.productURL) else {
//            completion(.failure(.invalidurl))
//            return
//        }
//        //Background Task
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else{
//                completion(.failure(.invaliddata))
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse,
//                  200 ... 299 ~= response.statusCode else {
//                      completion(.failure(.invalidresponse))
//                      return
//                  }
//
//            // Jsondecoder is converting data to model
//            do{
//                let products = try JSONDecoder().decode([Product].self, from: data)
//                completion(.success(products))
//            }catch{
//                completion(.failure(.network(error)))
//            }
//
//        }.resume()
//
//    }
}

// singleton Design Pattern Small "s" allow create object out side the class

/*class APIHelper2 {
    static let shared2 = APIHelper2()
    init() {}
    func temp2(){
        
    }
} */

/*class A: APIHelper2{
    func configration() {
        let manager = APIHelper2()
        //let sessions = URLSession() // example of the "s" singleton class
        manager.temp2()
        //APIHelper2.temp2()
        APIHelper2.shared2.temp2()
        
        // example method
        func fetchProduct() async {
            guard let url = URL(string: Constant.API.productURL) else {
                return
            }
            print(url)
            
            let task = URLSession.shared.dataTask(with: url) {data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
            }
           URLSession.shared.dataTask(with: url) {(data, response, error) in
               
               if error == nil{
                   if let data = data{
                       do{
                          // let userResponse = try JSONDecoder().decode(, from: data)
                       }catch {
                           print(error.localizedDescription)
                       }
                   }
                   
               }else {
                   print(error?.localizedDescription ?? "some error")
               }
    //            guard let data else {
    //                return
    //            }
    //            guard let response = response else {
    //                return
    //            }

                
            }.resume()
        }
    }
} */
