//
//  ProductViewController.swift
//  APIData
//
//  Created by Amey Ranade on 04/05/21.
//

import UIKit

extension UIImageView {
    func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage1(from url: URL) {
        getImageData(from: url) {
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
class ProductDetailViewController: UIViewController {
    let dataHlper = DatabaseHelper()
    let userDefaults = UserDefaults.standard
    var link : ProductListViewController?
    var objDetails = ProductDetails()
    var responseItem : Product?
    var responseItemDetails: Product?
   
    @IBOutlet weak var descLbl: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var productWeight: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var orignalPrice: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var skuLbl: UILabel!
    @IBOutlet weak var imageViewLbl: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
        changeButtonOnClick()
        guard let url  = URL(string: (self.responseItem?.thumbnail.medium)!)
        else{
            return
        }
        self.imageViewLbl .downloadImage1(from: url)
        favButton.setImage(UIImage(named: "fav_star"), for: .normal)
        favButton.addTarget(self, action: #selector(onMarkAsFavorite), for: .touchUpInside)
    }
    
    
    func changeButtonOnClick()
    {
        if let productId = responseItem?.id
        {
          if let _ = dataHlper.getProductBy(productId: productId)
          {
            self.favButton.tintColor = .blue
          }
            else
          {
            self.favButton.tintColor = .gray
          }
        }
        else
        {
            self.favButton.tintColor = .gray
        }
    
    }
    
    @objc func onMarkAsFavorite()
    {
        
        if let productId = responseItem?.id
        {
            dataHlper.saveProduct(productId: productId)
        }
        changeButtonOnClick()
    }
    
    func requestData()
    {
        objDetails.productDetails(id: responseItem!.id, resultType: Product?.self) { [self]
            (responseData) in
            DispatchQueue.main.async {
                self.responseItemDetails = responseData
                skuLbl.text = "SKU : " + self.responseItemDetails!.sku
                priceLbl.text = "price : " + String(self.responseItemDetails!.price)
                orignalPrice.text = "orignalPrie : " + String(self.responseItemDetails!.originalPrice)
                descLbl.text = "Description : " + self.responseItemDetails!.description
                productName.text = "Name : " + self.responseItemDetails!.name
                productWeight.text = "Weight : " + String(self.responseItemDetails!.weight!)
                
            }
            
        }
    }
    
    
    
    
    
}



