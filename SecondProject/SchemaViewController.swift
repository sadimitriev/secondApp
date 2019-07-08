//
//  SchemaViewController.swift
//  SecondProject
//
//  Created by Sergey Dimitriev on 05/07/2019.
//  Copyright © 2019 Sergey Dimitriev. All rights reserved.
//

import UIKit

class SchemaViewController: UITableViewController {
    
    var storedOffsets = [Int: CGFloat]()
    
    let breeds = ["affenpinscher","african","airedale","akita","appenzeller","basenji","beagle","bluetick","borzoi","bouvier","boxer","brabancon","briard"]
    
    var fullArr : [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var arr : [[String]] = []
        
        for breed in self.breeds {
            let url = NSURL(string: "https://dog.ceo/api/breed/\(breed)/images")
            URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
                
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    
                    if let heroeArray = jsonObj!.value(forKey: "message") as? NSArray {
                        
                        var test = Array<String>()
                        
                        for heroe in heroeArray{
                            test.append(heroe as! String)
                        }
                        arr.append(test)
                    }
                }
            }).resume()
        }
        DispatchQueue.main.async {
            self.fullArr = arr
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        return cell
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? TableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? TableViewCell else { return }
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
}
extension SchemaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (fullArr.count != 0) {
            return fullArr[collectionView.tag].count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        let defaultName = "spinner-of-dots.png"
        cell.tag = indexPath.row
        cell.image.image = UIImage(named: defaultName)
        
        if (fullArr.count != 0) {
            let url = URL(string: (fullArr[collectionView.tag][indexPath.row]) ?? "")
            if (url != nil) {
                let filename = (url)!.lastPathComponent
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url!){
                        DispatchQueue.main.async {
                            if(cell.tag == indexPath.row) {
                                let cellImage = UIImage(data: data)
                                cell.image.image = cellImage
                                cell.image.contentMode = .scaleToFill
                                
                                let myImageView = UIImageView(image: cellImage)
                                let imageData = myImageView.image!.pngData()
                                
                                UserDefaults.standard.set(imageData, forKey: filename)
                            }
                        }
                    }
                }
                if let data:NSData = UserDefaults.standard.object(forKey: filename) as? NSData {
                    let imageView = UIImage(data: data as Data)
                    
                    cell.image.image = imageView
                    cell.image.contentMode = .scaleToFill
                    return cell
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}
