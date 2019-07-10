//
//  SchemaViewController.swift
//  SecondProject
//
//  Created by Sergey Dimitriev on 05/07/2019.
//  Copyright © 2019 Sergey Dimitriev. All rights reserved.
//

import UIKit

class SchemaViewController: UITableViewController {
    
    let globalPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    var cacheFoler: Int = 0
    
    var storedOffsets = [Int: CGFloat]()
    
    let breeds = ["affenpinscher","african","airedale","akita","appenzeller","basenji","beagle","bluetick","borzoi","bouvier","boxer","brabancon","briard"]
    
    var fullArr : [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkCache()
        
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
                } else {
                    print("error jsonObj")
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
    
    func createFolder(folder: String, inCache: Bool = false) {
        let fileManager = FileManager.default
        let url = URL(fileURLWithPath: globalPath)
        var newDirectory = url.appendingPathComponent(folder)
        if inCache {
            newDirectory = url.appendingPathComponent("cache").appendingPathComponent(folder)
        }
        try? fileManager.createDirectory(at: newDirectory, withIntermediateDirectories: false, attributes: nil)
    }
    func createFolderCache() {
        let url = URL(fileURLWithPath: globalPath)
        let filePath = url.appendingPathComponent("cache").path
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: filePath) {
            createFolder(folder: "cache")
        }
    }
    func checkCache() {
        let ticks = NSDate().timeIntervalSince1970
        let cacheFolder = String(format:"%.f", ticks)
        createFolderCache()
        let url = URL(fileURLWithPath: globalPath)
        let filePath = url.appendingPathComponent("cache").path
        let enumerator = try! FileManager.default.enumerator(atPath: filePath)
        
        while let filename = enumerator?.nextObject() as? String {
            if (filename == ".DS_Store") {
                continue
            }
            let cacheId = Int(filename)
            if (cacheId! < Int(cacheFolder)!+86400) {
                self.cacheFoler = cacheId!
                return
            }
        }
        self.cacheFoler = Int(cacheFolder)!
        createFolder(folder: cacheFolder, inCache: true)
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
        
        if (fullArr.count != 0) {
            let url = URL(string: (fullArr[collectionView.tag][indexPath.row]) ?? "")
            if (url != nil) {
                let filename = (url)!.lastPathComponent
                let cacheId = String(self.cacheFoler)
                
                let urlSearch = URL(fileURLWithPath: globalPath)
                let pathCustom = "cache/" + cacheId + "/" + filename
                var filePath = urlSearch.appendingPathComponent(pathCustom).path
                
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: filePath) {
                    cell.image.image = UIImage(named: self.globalPath + "/cache/" + cacheId + "/" + filename)
                    cell.image.contentMode = .scaleToFill
                    return cell
                } else {
                    cell.image.image = UIImage(named: defaultName)
                    cell.image.contentMode = .scaleToFill
                }
                
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url!){
                        DispatchQueue.main.async {
                            if(cell.tag == indexPath.row) {
                                let cellImage = UIImage(data: data)

                                let myImageView = UIImageView(image: cellImage)
                                let imageData = myImageView.image!.pngData()

                                let url = URL(fileURLWithPath: self.globalPath)

                                let urlFilename = url.appendingPathComponent("cache").appendingPathComponent(cacheId).appendingPathComponent(filename)
                                try! imageData!.write(to: urlFilename)

                                cell.image.image = UIImage(named: self.globalPath + "/cache/" + cacheId + "/" + filename)
                                cell.image.contentMode = .scaleToFill
                            }
                        }
                    }
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}
