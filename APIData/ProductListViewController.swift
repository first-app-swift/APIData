//
//  ViewController.swift
//  APIData
//
//  Created by Amey Ranade on 28/04/21.
//

import UIKit
import CoreData
//MARK:- URLData to Image
extension UIImageView {
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
   func downloadImage(from url: URL) {
      getData(from: url) {
         data, response, error in
         guard let data = data else {
            return
         }
         DispatchQueue.main.async() {
            self.image = UIImage(data: data)
         }
      }
   }
}
var loginData : LoginDetails?
var changeProductData : Product?

class ProductListViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let dataChecker = DatabaseHelper()
    
    var responseData : ResponseItems?
    var objApi = ApiUtilities()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.requestToken()
    }
    
    func requestToken()
    {
        let registerURL = URL(string: RequestURL.login.rawValue)
        objApi.postApiData(requestUrl: registerURL!, resultType: LoginDetails.self) { (loginDetails) in
                self.getProducts(loginDetails: loginDetails.accessToken)
            
            loginData = loginDetails
            
        }

    }
//MARK:- GetProducts
    func getProducts(loginDetails: String)
    {
        let tokenData = loginDetails
        let responseURL = URL(string: RequestURL.products.rawValue )
        let encoder = JSONEncoder()
        let parseData = ProductsRequestData(order: "Descending", orderBy: "ModifiedDate", facetsCriteria: [])
        let newData = try! encoder.encode(parseData)
            objApi.postBodyApiData(requestUrl: responseURL!, requestBody: newData, token: tokenData, resultType: ResponseItems.self) { ( responseItems ) in
                DispatchQueue.main.async {
                    self.responseData = responseItems
                    self.collectionView.reloadData()
              }
            }
    }
   
   
    }
    


//MARK:- Extension of dataSource
extension  ProductListViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = self.responseData?.items.items.count{
            return count
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)  as! ProductCell
        if let data = self.responseData?.items.items[indexPath.row].name {
            cell.productLbl.text = data
        }
        if let imageURL = URL(string: (self.responseData?.items.items[indexPath.row].thumbnail.medium)!)
        {
        cell.productImageView.downloadImage(from: imageURL)
        }
        
        cell.favButton.setImage(UIImage(named: "fav_star"), for: .normal)
        
//        cell.favButton.addTarget(self, action: #selector(onTapChange), for: .touchUpOutside)
       
       
//            if let productId = self.responseData?.items.items[indexPath.row].id
//            {
//                dataChecker.saveProduct(productId: productId)
//            }
       
    return cell
    }
    
   
    // MARK:-  ProductViewScreeData
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let dataSending = storyboard?.instantiateViewController(identifier: "ProductViewController") as? ProductDetailViewController
        dataSending?.link = self
        dataSending?.responseItem = (self.responseData?.items.items[indexPath.row])!
        self.navigationController?.pushViewController(dataSending!, animated: true)
    }
    
}







