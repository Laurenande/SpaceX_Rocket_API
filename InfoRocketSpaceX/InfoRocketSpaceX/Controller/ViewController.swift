//
//  ViewController.swift
//  InfoRocketSpaceX
//
//  Created by Егор Куракин on 14.04.2022.
//

import UIKit


class ViewController: UIViewController{
    
    //api
    var rocket: Rocket?
    
    //fullscreen scroll
    var myScrollView = UIScrollView()
    
    //scroll rocket value and type
    var scrollInfoRocket = UIScrollView()
    
    //black container info remove
    var content = UIView()
    
    //cell info in scroll InfoRocket
    var myCollectionView: UICollectionView?
    
    //hide navigation bar in first vc
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    //show navigation bar in all other vc
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let img = self.view.bounds
        
        ApiManager.shared.getInfo { RocketInf in
            self.rocket = RocketInf
            DispatchQueue.main.async {
                self.addImgBackgroung(paramImg: 0, paramFrame: img)
                self.addContentView()
                self.addLabel()
                self.scrollInfo()
                self.buttonSettings()
                self.createTableInfo()
                self.createContentInfoRocket()
                self.rocketLaunch()
                self.myCollectionView?.reloadData()
                
            }
        }
        
        createCollection()

        //createscroll
        let scrollViewRect = self.view.bounds
        let cg = CGRect(x: 0,
                        y: self.view.bounds.origin.y - 50 ,
                        width: self.view.bounds.width,
                        height: self.view.bounds.height + 50)
        myScrollView = UIScrollView(frame: cg)
        myScrollView.isPagingEnabled = false
        myScrollView.bounces = false
        myScrollView.contentInset.top = 0
        myScrollView.contentSize = CGSize(width: scrollViewRect.size.width,
                                          height: scrollViewRect.size.height * 1.4)
        self.view.addSubview(myScrollView)

    }
    

    
    //add button setting value
    func buttonSettings(){
        let button = UIButton(frame: CGRect(x: 350,
                                            y: 50,
                                            width: 40,
                                            height: 40))
        button.tintColor = .white
        button.setBackgroundImage(UIImage(systemName: "gearshape"), for: .normal)
        button.addTarget(self, action: #selector(viewSettings) , for: .touchUpInside)
        self.content.addSubview(button)
    }
    @objc func viewSettings(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "Settings") as! SettingsVC
        self.present(settingsVC, animated: true, completion: nil)
    }
    
    //add img to background
    func addImgBackgroung(paramImg: Int, paramFrame: CGRect){
        
        if let model = rocket{
            let url = URL(string:model[paramImg].flickr_images![0])
            if let data = try? Data(contentsOf: url!)
            {
                let cg = self.view.bounds
                let result = UIImageView(frame: cg)
                result.contentMode = .scaleAspectFit
                result.image = UIImage(data: data)
                result.contentMode = .top
                
                self.myScrollView.addSubview(result)
            }
        }
        else {
            print("No value")
        }
    }
    
    //add contentView or all label and button
    func addContentView(){
        let cg = CGRect(x: 0,
                        y: 330,
                        width: self.view.bounds.width,
                        height: 1000)
        self.content = UIView(frame: cg)
        self.content.layer.cornerRadius = 30
        self.content.contentMode = .scaleAspectFit
        self.content.backgroundColor = .black
        self.myScrollView.addSubview(self.content)
    }
    
    //add label name rocket
    func addLabel(){
        if let model = rocket{
            let cg = CGRect(x: 30,
                            y: 50,
                            width: 200,
                            height: 50)
            let nameRocket = UILabel(frame: cg)
            nameRocket.text = model[0].name
            nameRocket.textColor = .white
            nameRocket.font = UIFont(name: "LabGrotesque-Medium", size: 40)
            self.content.addSubview(nameRocket)
        }
        else {
            print("No value")
        }
    }
    
    //add a scrollView of info block rocket data
    func scrollInfo(){
        let cg = CGRect(x: 0,
                        y: 120,
                        width: self.view.bounds.width,
                        height: 120)
        scrollInfoRocket.frame = cg
        scrollInfoRocket.bounces = false
        scrollInfoRocket.isPagingEnabled = false
        scrollInfoRocket.contentOffset.y = 0
        scrollInfoRocket.contentSize.width = scrollInfoRocket.frame.size.width * CGFloat(1.2)
        scrollInfoRocket.contentSize.height = 1
        self.content.addSubview(scrollInfoRocket)
    }
    
    //add a collection of information block about the rocket
    func createCollection(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: 110, height: 110)
        
        let cg = CGRect(x: self.scrollInfoRocket.bounds.origin.x,
                        y: self.scrollInfoRocket.bounds.origin.y,
                        width: 480,
                        height: 130)
        myCollectionView = UICollectionView(frame: cg, collectionViewLayout: layout)
        myCollectionView?.register(CustomCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView?.backgroundColor = UIColor.clear
        myCollectionView?.dataSource = self
         
        self.scrollInfoRocket.addSubview(myCollectionView ?? UICollectionView())
        
    }
    
    func createContentInfoRocket(){
        //create vertical stackview
        let cg = CGRect(x: 0,
                        y: 280,
                        width: self.content.bounds.width - 40,
                        height: 130)
        let infoContent = UIStackView(frame: cg)
        infoContent.center.x = content.center.x
        infoContent.axis = .vertical
        infoContent.distribution = .equalSpacing
        self.content.addSubview(infoContent)
        
        //create horizontal stackview
        let labelStack = UIStackView(frame: infoContent.bounds)
        let labelStack2 = UIStackView(frame: infoContent.bounds)
        let labelStack3 = UIStackView(frame: infoContent.bounds)
        let stacks : [UIStackView] = [labelStack,labelStack2,labelStack3]
        for id in 0...stacks.count - 1 {
            stacks[id].axis = .horizontal
            stacks[id].distribution = .equalSpacing
            infoContent.addArrangedSubview(stacks[id])
        }
        
        //create title label
        let lb = UILabel(frame: infoContent.bounds)
        let lb2 = UILabel(frame: infoContent.bounds)
        let lb3 = UILabel(frame: infoContent.bounds)
        let labels : [UILabel] = [lb,lb2,lb3]
        
        for id in 0...labels.count - 1 {
            labels[id].textColor = .lightGray
            labels[id].textAlignment = .center
            labels[id].autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
            labels[id].font = UIFont(name: "LabGrotesque-Medium", size: 19)
            switch id {
            case 0:
                labels[id].text = "Первый запуск"
            case 1:
                labels[id].text = "Страна"
            case 2:
                labels[id].text = "Стоимость запуска"
            default:
                break
            }
            stacks[id].addArrangedSubview(labels[id])
        }
        //add label value
        let labelValue = UILabel(frame: infoContent.bounds)
        let labelValue2 = UILabel(frame: infoContent.bounds)
        let labelValue3 = UILabel(frame: infoContent.bounds)
        let labelsValue : [UILabel] = [labelValue,labelValue2,labelValue3]
        if let model = rocket{
            for id in 0...labelsValue.count - 1 {
                labelsValue[id].textColor = .white
                labelsValue[id].textAlignment = .center
                labels[id].autoresizingMask = [.flexibleRightMargin, .flexibleTopMargin]
                labelsValue[id].font = UIFont(name: "LabGrotesque-Medium", size: 19)
                switch id {
                case 0:
                    labelsValue[id].text = model[0].first_flight
                case 1:
                    labelsValue[id].text = model[0].country
                case 2:
                    labelsValue[id].text = "$" + String((model[0].cost_per_launch)! / 1000000) + " млн"
                default:
                    break
                }
                stacks[id].addArrangedSubview(labelsValue[id])
            }
        }
    }
    
    //add a table of information block about the stage rocket
    func createTableInfo(){
        let table = UITableView()
        let cg = CGRect(x: 0,
                        y: self.content.frame.origin.y + 130,
                        width: self.content.frame.width,
                        height: 540)
        table.frame = cg
        table.register(UINib(nibName: "TableCell", bundle: nil), forCellReuseIdentifier: "tableCell")
        table.delegate = self
        table.dataSource = self
        table.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        table.backgroundColor = .clear
        table.allowsSelection = false
    
        self.content.addSubview(table)
    }
    
    func rocketLaunch(){
        let cg = CGRect(x: 0,
                        y: 860,
                        width: self.content.bounds.width - 50,
                        height: 70)
        let launch = UIButton(frame: cg)
        launch.center.x = content.center.x
        launch.layer.cornerRadius = 10
        launch.setTitle("Посмотреть запуски", for: .normal)
        launch.setTitleColor(.white, for: .normal)
        launch.titleLabel?.font = UIFont(name: "LabGrotesque-Medium", size: 22)
        launch.backgroundColor = UIColor(red: 27/255.0, green: 27/255.0, blue: 27/255.0, alpha: 1.0)
        launch.addTarget(self, action: #selector(viewLauch) , for: .touchUpInside)
        self.content.addSubview(launch)
    }
    
    @objc func viewLauch(){
        //open vc Segue ID
        performSegue(withIdentifier: "goLaunch", sender: nil)
    }

}
//MARK: Extension Collection
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomCell
        if let model = rocket{
            switch indexPath.row {
            case 0:
                if ApiManager.shared.isHeightM
                {
                    myCell.configure(label: String((model[0].height?.meters)!))
                }else{
                    myCell.configure(label: String((model[0].height?.feet)!))
                }
                
                myCell.configureType(label: ApiManager.shared.isHeightM ? "Высота, m" : "Высота, ft")
            case 1:
                if ApiManager.shared.isDiameterM
                {
                    myCell.configure(label: String((model[0].diameter?.meters)!))
                }else{
                    myCell.configure(label: String((model[0].diameter?.feet)!))
                }
                myCell.configureType(label: ApiManager.shared.isDiameterM ? "Диаметр, m" : "Диаметр, ft")
            case 2:
                if ApiManager.shared.isWeightKg
                {
                    myCell.configure(label: String((model[0].mass?.kg)!))
                }else{
                    myCell.configure(label: String((model[0].mass?.lb)!))
                }
                myCell.configureType(label: ApiManager.shared.isWeightKg ? "Масса, kg" : "Масса, lb")
            case 3:
                if ApiManager.shared.isLoadKg
                {
                    myCell.configure(label: String((model[0].payload_weights?[0].kg)!))
                }else{
                    myCell.configure(label: String((model[0].payload_weights?[0].lb)!))
                }

                myCell.configureType(label: ApiManager.shared.isLoadKg ? "Нагрузка, kg" : "Нагрузка, lb")
            default:
                break
            }
        }
        myCollectionView?.reloadData()
        return myCell
    }
}



//MARK: Extencion Table
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableCell
        cell.backgroundColor = .clear
        var eng : String = ""
        var fuel : String = ""
        var combustion : String = ""
        
        if let model = rocket{
            switch indexPath.row {
            case 0:
                eng = String((model[0].first_stage?.engines)!)
                fuel = String((model[0].first_stage?.fuel_amount_tons)!)
                combustion = String((model[0].first_stage?.burn_time_sec)!)
                cell.config(titleRow: 1,value: (eng: eng, fuel: fuel, combustion: combustion))

            case 1:
                eng = String((model[0].second_stage?.engines)!)
                fuel = String((model[0].second_stage?.fuel_amount_tons)!)
                combustion = String((model[0].second_stage?.burn_time_sec)!)
                cell.config(titleRow: 2,value: (eng: eng, fuel: fuel, combustion: combustion))
            default:
                break
            }
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}


