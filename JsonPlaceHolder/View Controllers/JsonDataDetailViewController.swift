//
//  JsonDataDetailViewController.swift
//  JsonPlaceHolder
//
//  Created by Chun on 2022/10/13.
//

import UIKit

class JsonDataDetailViewController: UIViewController {
  
  @IBOutlet weak var jsonDataDetailImageView: UIImageView!
  @IBOutlet weak var jsonDataDetailIdLabel: UILabel!
  @IBOutlet weak var jsonDataDetailTitleLabel: UILabel!
  
  var dataDetail: JsonData?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print("The \(dataDetail!.id) Data Detail")
    
    self.jsonDataDetailIdLabel.text = "ID:" + "\(self.dataDetail!.id)"
    self.jsonDataDetailTitleLabel.text = "Title" + self.dataDetail!.title
    self.jsonDataDetailImageView.image = nil
    let imageUrl = dataDetail!.url
    JsonController.shared.fetchImage(urlString: imageUrl) { image in
      guard let image = image else { return }
      DispatchQueue.main.async {
        self.jsonDataDetailImageView.image = image
      }
    }

    // Do any additional setup after loading the view.
  }

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // Get the new view controller using segue.destination.
       // Pass the selected object to the new view controller.
   }
   */
}
