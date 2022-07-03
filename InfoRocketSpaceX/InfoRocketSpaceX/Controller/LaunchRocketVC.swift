//
//  LaunchRocketVC.swift
//  InfoRocketSpaceX
//
//  Created by Егор Куракин on 26.05.2022.
//

import UIKit
import Alamofire

class LaunchRocketVC: UIViewController{

    var launchCollection: UICollectionView?
    var array = [Launch]()
    let getUrl = "https://api.spacexdata.com/v4/launches"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getLaunch(url: getUrl)
        view.backgroundColor = .black
        createCollection()
    }
    //request api
    func getLaunch(url: String){
        AF.request(url).responseDecodable(of: [Launch].self){ (response) in
            guard let data = response.data else {
                return}
            do{
                let cont = try JSONDecoder().decode([Launch].self, from: data)
                self.updateLaunch(json: cont)

            }catch{
                //print(error.localizedDescription)
            }
        }
    }
    //safe responce api
    func updateLaunch(json:[Launch]){
        for valuer in json{
            if valuer.rocket! == "5e9d0d95eda69955f709d1eb"{
                self.array.append(valuer)
                print(self.array.count)
            }
        }
        launchCollection?.reloadData()
    }
    //Create colletction launch rocket
    func createCollection(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: 360, height: 110)
        
        let cg = CGRect(x: self.view.bounds.origin.x,
                        y: 100,
                        width: self.view.bounds.width,
                        height: self.view.bounds.height)
        launchCollection = UICollectionView(frame: cg, collectionViewLayout: layout)
        launchCollection?.backgroundColor = .blue
        launchCollection?.register(LaunchCell.self, forCellWithReuseIdentifier: "LaunchCell")
        launchCollection?.backgroundColor = UIColor.clear
        launchCollection?.dataSource = self
         
        self.view.addSubview(launchCollection ?? UICollectionView())
    }
    //convert date
    func getFormattedDate(string: String) -> String{
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMMM dd, yyyy"
        
            let date: Date? = dateFormatterGet.date(from: string)
            return dateFormatterPrint.string(from: date!);
        }
}
//MARK: - UICollectionViewDataSourceb

extension LaunchRocketVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LaunchCell", for: indexPath) as! LaunchCell
        
        let launch = array[indexPath.row]
        myCell.configure(label: launch.name ?? "lox")
        let date = getFormattedDate(string: launch.date_local!)
        myCell.configureType(label: date)
        if launch.success!{
            myCell.launchSucces()
        }
        return myCell
    }
    
    
}

