//
//  WitoutPetCell.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 26/04/23.
//

import UIKit
import SnapKit
import Iconic

final class WitoutPetCell: ReusableTableViewCell {
    
    private lazy var noPetsImage: UIImageView = {
        let image = FontAwesomeIcon.plusIcon.image(
            ofSize: .init(width: 80, height: 80),
            color: Theme.Color.gray300
        )
        let iv = UIImageView(image: image)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Voce ainda nao possui pets cadatrados"
        label.textColor = Theme.Color.gray300
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        configureStyle()
        configureHierarchy()
        configureContraints()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func configureStyle() {
        backgroundColor = Theme.Color.gray800
    }
    
    private func configureHierarchy() {
        verticalStack.addArrangedSubview(noPetsImage)
        verticalStack.addArrangedSubview(descriptionLabel)
        contentView.addSubview(verticalStack)
    }
    
    private func configureContraints() {
        verticalStack.snp.makeConstraints {
            $0.center.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(16)
            $0.trailing.equalTo(contentView).offset(-16)
        }
    }
}
