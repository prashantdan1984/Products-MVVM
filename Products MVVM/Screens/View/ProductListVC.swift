//
//  ProductListVC.swift
//  Products MVVM
//
//  Created by Prashantdan on 22/01/24.
//

import UIKit

class ProductListVC: UIViewController {

    @IBOutlet weak var productTableview: UITableView!
    private var viewModel = ProductViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        productTableview.delegate = self
//        productTableview.dataSource = self
        configuration()
    }
    
    // MARK: -
    @IBAction func addProductButtonTapped(_ sender: UIBarButtonItem) {
        let product = AddProduct(title: "iPhone")
        viewModel.addProduct(parameters: product)
    }
}
extension ProductListVC {
    func configuration() {
        
        productTableview.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        initViewModel()
        observerEvent()
    }
    
    func initViewModel () {
        viewModel.fetchproducts()
    }
    // Data Binding event observer for communication
    func observerEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self = self else {return}
            switch event {
            case .loading:
                //indicator show here.
                print("data loading ...")
            case .stopLoading:
                //indicator hide here.
                print("data stop loading ...")
            case .dataLoaded:
                print("data loaded ...")
                print("in the data load \(self.viewModel.product)")
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.05) {
                    //ui works well in main DispatchQueue
                    self.productTableview.reloadData()
                }
            case .error(let error):
                print(error)
            case .newProductAdded(let newProduct):
                print(newProduct)
            }
        }
    }
}

extension ProductListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.product.count)
        return viewModel.product.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        let product = viewModel.product[indexPath.row]
        cell.product = product
        return cell
    }
}
