//
//  CustomCell.swift
//  InfoRocketSpaceX
//
//  Created by Егор Куракин on 17.05.2022.
//

import UIKit

class CustomCell: UICollectionViewCell {

    
    private let valueInfo : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "LabGrotesque-Medium", size: 22)
        label.text = "nil"
        return label
    }()
    private let typeInfo : UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont(name: "LabGrotesque-Medium", size: 17)
        label.text = "Ret"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 27/255.0, green: 27/255.0, blue: 27/255.0, alpha: 1.0)
        contentView.layer.cornerRadius = 40
        contentView.addSubview(valueInfo)
        contentView.addSubview(typeInfo)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        valueInfo.frame = CGRect(x: 0,
                                 y: contentView.frame.size.height/6,
                                 width: contentView.frame.size.width,
                                 height: 50)
        typeInfo.frame = CGRect(x: 0,
                                y: contentView.frame.size.height/2.3,
                                width: contentView.frame.size.width,
                                height: 50)

        
    }
    
    public func configure(label: String){
        valueInfo.text = label
    }
    public func configureType(label: String){
        typeInfo.text = label
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueInfo.text = nil
    }

}
