//
//  AddProductViewController.swift
//  Products MVVM
//
//  Created by Prashantdan on 30/01/24.
//

import UIKit

//struct ProductRespone: Decodable{
//    let id: Int? = nil
//    let title: String
//}

class AddProductViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addProduct()
        // Do any additional setup after loading the view.
    }

    // MARK: - function addProduct
    func addProduct() {
        
        guard let url = URL(string: "https://dummyjson.com/products/add") else {
            return
        }
        let parameters = AddProduct(title: "BMW Car")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //convert Modal to Data Convert (JSONEncoder +Encodable)
        request.httpBody = try? JSONEncoder().encode(parameters)
        request.allHTTPHeaderFields = [
            "Content-Type":"application/json" //with, use multipal headers
        ]
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {return}
            do{
                print(data)
                let productResponse = try JSONDecoder().decode(AddProduct.self, from:data)
                print(productResponse)
            }catch {
                print(error)
            }
        }.resume()
    }
}
