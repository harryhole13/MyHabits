//
//  InfoTableViewCell.swift
//  MyHabits
//
//  Created by Алексей Потемин on 26.09.2022.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    let textInfo:UILabel = {
        let string = UILabel()
        string.numberOfLines = 0
        string.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        string.textColor = .black
        string.backgroundColor = .white
        string.translatesAutoresizingMaskIntoConstraints = false
        return string
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(textInfo)
        NSLayoutConstraint.activate(setupCell())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() -> [NSLayoutConstraint] {
        let topAnchor = self.textInfo.topAnchor.constraint(equalTo: self.topAnchor,constant: 12)
        let leadingAnchor = self.textInfo.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16)
        let trailingAnchor = self.textInfo.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -16)
        let bottomAnchor = self.textInfo.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -12)
        return [
            topAnchor, leadingAnchor, trailingAnchor, bottomAnchor
        ]
    }
    
    func setup(with model: ModelInfo) {
        self.textInfo.text = model.text
        }
}
