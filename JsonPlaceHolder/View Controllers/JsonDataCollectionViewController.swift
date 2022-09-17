//
//  JsonDataCollectionViewController.swift
//  JsonPlaceHolder
//
//  Created by Chun on 2022/10/6.
//

import UIKit

class JsonDataCollectionViewController: UICollectionViewController {
  
  var dataList = [JsonData]()
  
  let urlString = "https://jsonplaceholder.typicode.com/photos"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCellSize()
    
    print("Loading \(dataList.count) Data")

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false

    // Register cell classes
    /*
    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "\(JsonDataCollectionViewCell.self)")
     */

    // Do any additional setup after loading the view.
  }

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // Get the new view controller using [segue destinationViewController].
       // Pass the selected object to the new view controller.
   }
   */

  // MARK: UICollectionViewDataSource

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    return dataList.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(JsonDataCollectionViewCell.self)", for: indexPath) as! JsonDataCollectionViewCell
    cell.jsonDataIdLabel.text = "\(dataList[indexPath.row].id)"
    cell.jsonDataTitleLabel.text = dataList[indexPath.row].title
    cell.jsonDataImageView.image = nil
    let imageUrl = dataList[indexPath.row].thumbnailUrl
    JsonController.shared.fetchImage(urlString: imageUrl) { image in
      guard let image = image else { return }
      DispatchQueue.main.async {
        cell.jsonDataImageView.image = image
      }
    }
    
    // Configure the cell

    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("點了第\(indexPath.row + 1)個Cell")
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let cell = sender as! UICollectionViewCell
    if let indexPath = collectionView.indexPath(for: cell) {
      let dataDetail = dataList[indexPath.row]
      let dataList = segue.destination as! JsonDataDetailViewController
      dataList.dataDetail = dataDetail
    }
  }
  
   
  
  
  func configureCellSize() {
    let flowlayout = collectionViewLayout as? UICollectionViewFlowLayout
    let width = collectionView.frame.width / 4
    flowlayout?.itemSize = CGSize(width: width, height: 95)
    flowlayout?.estimatedItemSize = .zero
    flowlayout?.minimumInteritemSpacing = 0
    flowlayout?.minimumLineSpacing = 0
  }

  // MARK: UICollectionViewDelegate

  /*
   // Uncomment this method to specify if the specified item should be highlighted during tracking
   override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
       return true
   }
   */

  /*
   // Uncomment this method to specify if the specified item should be selected
   override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
       return true
   }
   */

  /*
   // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
   override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
       return false
   }

   override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
       return false
   }

   override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {

   }
   */
}
