//
//  ViewController.swift
//  AlamofireAndSwiftyJson
//
//  Created by Active Mac05 on 15/04/16.
//  Copyright © 2016 techactive. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDataUsingAlamofire()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getDataUsingAlamofire(){
        let urlString = "http://shopapi.furnishzone.com/api/mobileAPI/mobile_api.php?req=getCategories&json=%7B%7D"
        let todosEndpoint: String = "http://shopapi.furnishzone.com/api/mobileAPI/mobile_api.php?"
        let newTodo = ["req": "getCategories", "json": "{}"]
        Alamofire.request(.POST, todosEndpoint, parameters: newTodo, encoding: .JSON)
            .responseJSON { response in
                print("response in post method = \(response)")
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling POST on /todos/1")
                    print(response.result.error!)
                    return
                }
                
                if let value = response.result.value {
                    let todo = JSON(value)
                    print("The todo is: " + todo.description)
                }
        }
//        
        Alamofire.request(.GET, urlString)    //using alamofire
            .responseJSON { response in
                print("response in get method = \(response)")
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling POST on /todos/1")
                    print(response.result.error!)
                    return
                }
            let json = JSON(response.result.value!)  // using swiftyJSON
            print("Response JSON dictionary = \(json)")
            print("outer most array is = \(json["results"].arrayValue)")
                let jsonCategoriesArray = json["categories"].arrayValue
                var categoiesArray = [GeneralCategory]()
                var tempCategory = GeneralCategory()
                for category in jsonCategoriesArray {
                    tempCategory.brand_id = category["brand_id"].stringValue
                    tempCategory.category_id = category["category_id"].stringValue
                    tempCategory.category_name = category["category_name"].stringValue
                    tempCategory.imag_url = category["imag_url"].stringValue
                    tempCategory.offer_text = category["offer_text"].stringValue
                    tempCategory.title = category["title"].stringValue
                    categoiesArray.append(tempCategory)
                    tempCategory = GeneralCategory()
                }
            let array = json["results"].arrayValue
                for val in array {
                    print("insde each array login details are = \(val["login"])")
                    print("insde each login user name is = \(val["login"]["username"])")
                }
        }
    }
}


class GeneralCategory: NSObject {
    var brand_id = ""
    var category_id = ""
    var category_name = ""
    var imag_url = ""
    var offer_text = ""
    var title = ""
}
