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
    var link : ViewController?
    var objDetails = ProductDetails()
    var responseItem : Item?
    var responseItemDetails: Item?
    @IBOutlet weak var detailsLbl: UILabel!
    
    @IBOutlet weak var imgLbl: UIImageView!
    
    @IBOutlet weak var skuLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var orignalPriceLbl: UILabel!
    
    @IBOutlet weak var favBuotton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
        changeButtonOnClick()
        skuLbl.text = self.responseItemDetails?.sku
        descriptionLbl.text = responseItemDetails?.description
        
        guard let url  = URL(string: (self.responseItem?.thumbnail.medium)!)
        else{
            return
        }
        self.imgLbl.downloadImage1(from: url)
        favBuotton.setImage(UIImage(named: "fav_star"), for: .normal)
        favBuotton.addTarget(self, action: #selector(onMarkAsFavorite), for: .touchUpInside)
    }
    
    func changeButtonOnClick()
    {
        if let productId = responseItem?.id
        {
          if let _ = dataHlper.getProductBy(productId: productId)
          {
            self.favBuotton.tintColor = .blue
          }
            else
          {
            self.favBuotton.tintColor = .gray
          }
        }
        else
        {
            self.favBuotton.tintColor = .gray
        }
    
    }
    
    @objc func onMarkAsFavorite()
    {
       
       link?.doSomethingAfterCall(data: responseItem!)
        
        if let productId = responseItem?.id
        {
            dataHlper.saveProduct(productId: productId)
        }
        changeButtonOnClick()
    }
    
    func requestData()
    {
        objDetails.productDetails(id: responseItem!.id, resultType: Item.self) { [self]
            (responseData) in
            DispatchQueue.main.async {
                self.responseItemDetails = responseData
                skuLbl.text = self.responseItemDetails?.sku
                priceLbl.text = String(self.responseItemDetails!.price)
                orignalPriceLbl.text = String(self.responseItemDetails!.originalPrice)
                descriptionLbl.text = responseItemDetails?.description
                
            }
            
        }
    }
    
    
    
    
    
}



