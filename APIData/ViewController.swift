//
//  ViewController.swift
//  APIData
//
//  Created by Amey Ranade on 28/04/21.
//

import UIKit
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

class ViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
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
            }

    }
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
    



extension  ViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = self.responseData?.items.items.count{
            return count
        }
        return 0
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)  as! ProductDetailsViews
        if let data = self.responseData?.items.items[indexPath.row].name {
            cell.productLbl.text = data
        }
        if let imageURL = URL(string: (self.responseData?.items.items[indexPath.row].thumbnail.medium)!)
        {
        cell.productImageView.downloadImage(from: imageURL)
        }
        return cell
    }
    
}
//extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layoutcollectionViewLayout: UICollectionViewLayout, sizeForItemAtindexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 200)
//    }
//}




