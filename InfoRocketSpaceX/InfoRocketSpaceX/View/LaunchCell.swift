//
//  LaunchCell.swift
//  InfoRocketSpaceX
//
//  Created by Егор Куракин on 19.06.2022.
//

import UIKit

class LaunchCell: UICollectionViewCell {
    private let valueInfo : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "LabGrotesque-Medium", size: 22)
        label.text = "nil"
        return label
    }()
    private let typeInfo : UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont(name: "LabGrotesque-Medium", size: 17)
        label.text = "Ret"
        return label
    }()
    private let imgRocket : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "rocketLogo")
        img.setImageColor(color: .red)
        return img
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 27/255.0, green: 27/255.0, blue: 27/255.0, alpha: 1.0)
        contentView.layer.cornerRadius = 25
        contentView.addSubview(imgRocket)
        contentView.addSubview(valueInfo)
        contentView.addSubview(typeInfo)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        valueInfo.frame = CGRect(x: 15,
                                 y: contentView.frame.size.height/6,
                                 width: contentView.frame.size.width,
                                 height: 50)
        typeInfo.frame = CGRect(x: 15,
                                y: contentView.frame.size.height/2.3,
                                width: contentView.frame.size.width,
                                height: 50)
        imgRocket.frame = CGRect(x: contentView.frame.size.width/1.3,
                                 y: 30,
                                 width: 50,
                                 height: 50)

        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueInfo.text = nil
    }
    public func configure(label: String){
        valueInfo.text = label
    }
    public func configureType(label: String){
        typeInfo.text = label
    }
    public func launchSucces(){
        imgRocket.setImageColor(color: .green)
    }
}
extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
