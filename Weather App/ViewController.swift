//
//  ViewController.swift
//  Weather App
//
//  Created by elaheh on 2017-08-15.
//  Copyright © 2017 elaheh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    @IBAction func submitButton(_ sender: UIButton) {
        if let url = URL(string:"http://samples.openweathermap.org/data/2.5/weather?q="+cityNameTextField.text!+",uk&appid=0be097bfa41256b855ccae762207421d"){
            if cityNameTextField.text != "" {
                
                
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        print("error")
                    }else{
                        if let urlContent = data{
                            do{
                                let jasonResult = try JSONSerialization.jsonObject(with: urlContent, options: [])
                                
                                let jsonDictionary = jasonResult as? [AnyHashable:Any]
                                
                                
                                let cityWeather = jsonDictionary?["weather"] as? [[AnyHashable:Any]]
                                
                                for currentDictionary in cityWeather!{
                                    print("************")
                                    let cityDescription = currentDictionary["description"]
                                    
                                    DispatchQueue.main.sync(execute: {
                                        self.resultLabel.text = cityDescription as! String?
                                    })
                                }
                                
                            }catch{
                                print("JSON processing failed")
                            }
                            
                        }
                    }
                }
                task.resume()
                
            }else{
                            print("******+++++*********")
                            resultLabel.text = "couldn't find weather for this city , Enter another city name please!"
            }
        }else{
//            print("******+++++*********")
//            resultLabel.text = "couldn't find weather for this city , Enter another city name please!"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

