//
//  DatabaseHelper.swift
//  APIData
//
//  Created by Amey Ranade on 05/05/21.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper
{
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func saveProduct(productId: String){
        
        if let _ = (getProductBy(productId: productId))
        {
            deleteProductById(productId: productId)
        }else
        {
            let entity = NSEntityDescription.insertNewObject(forEntityName: "FavoriteProduct", into: context!) as? FavoriteProduct
            entity?.productId = productId
            do
            {
                try context!.save()
            }catch let error{
                print(error)
            }
    
        }
    }
    func getProductBy(productId: String) -> FavoriteProduct?
    {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteProduct")
        fetchRequest.predicate = NSPredicate(format: "productId == %@", productId)
        
        do{
            let results = try context!.fetch(fetchRequest)
            if (results.count > 0)
            {
                return (results.first) as? FavoriteProduct
            }
            return nil
        }catch let error{
            print(error)
        }
        return nil
    }
    
    func retrieveProductList()
    {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteProduct")
        
        do{
            let results = try context!.fetch(fetchRequest)
            
            for result in results
            {
                print(result)
            }
        }catch let error{
            print(error)
        }
    }
    func deleteProductById(productId: String)
    {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteProduct")
        fetchRequest.predicate = NSPredicate(format: "productId == %@", productId)
        
        do{
            let results = try context!.fetch(fetchRequest)
            
            for id in results
            {
               context!.delete(id)
                
            }
            
            try context!.save()
        }catch let error{
            print(error)
        }
    }
}
