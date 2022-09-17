//
//  ViewController.swift
//  JsonPlaceHolder
//
//  Created by Chun on 2022/9/17.
//

import UIKit

class ViewController: UIViewController {
  
  var data = [JsonData]()
  let urlString = "https://jsonplaceholder.typicode.com/photos"

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    JsonController.shared.fetchJsonData(urlString: urlString) { result in
      switch result {
      case.success(let dataList):
        self.updataUI(with: dataList)
        print(dataList.count)
      case.failure(let error):
        self.displayError(error, title: "Faild to Fetch Json Data")
      }
    }
  }
  
  func updataUI(with jsonData: [JsonData]) {
    DispatchQueue.main.async {
      self.data = jsonData
    }
  }
  
  func displayError(_ error: Error, title: String) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let controller = segue.destination as! JsonDataCollectionViewController
    controller.dataList = data
  }


}

