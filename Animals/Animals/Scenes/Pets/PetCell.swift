//
//  PetCell.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 25/04/23.
//

import UIKit
import SnapKit

final class PetCell: ReusableTableViewCell {
    struct ViewData {
        let name: String
    }
    
    private(set) lazy var petImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.layer.borderColor = Theme.Color.green500.cgColor
        image.layer.borderWidth = 2
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var petName: UILabel = {
        let label = UILabel()
        label.textColor = Theme.Color.white
        label.font = .boldSystemFont(ofSize: Theme.Size.mid)
        return label
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = Theme.Size.small
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Theme.Color.gray800
        selectionStyle = .none
        
        horizontalStack.addArrangedSubview(petImage)
        horizontalStack.addArrangedSubview(petName)
        contentView.addSubview(horizontalStack)
        
        petImage.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        
        horizontalStack.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(Theme.Size.small)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-Theme.Size.small)
            $0.leading.equalTo(contentView.snp.leading).offset(Theme.Size.mid)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-Theme.Size.mid)
        }
    }
    
    required init?(coder: NSCoder) { nil }
    
    func configure(_ viewData: ViewData) {
        petName.text = viewData.name
    }
}
