//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Алексей Потемин on 01.10.2022.
//

import UIKit

//protocol ProgressDelegate: AnyObject {
//    func upProgress()
//}

class ProgressCollectionViewCell: UICollectionViewCell {
    
    var delegate: TrackerDelegate?
    
    private lazy var everythingWillDone:UILabel = {
        let label = UILabel()
        label.text = "Всё получится!"
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var percent:UILabel = {
        let label = UILabel()
        let value = Int(HabitsStore.shared.todayProgress * 100)
        label.text = "\(value)%"
        label.textColor = .lightGray
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stripProgressEmpty:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stripProgressFull:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "AccentColor")
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(everythingWillDone)
        self.contentView.addSubview(percent)
        self.contentView.addSubview(stripProgressEmpty)
        self.contentView.addSubview(stripProgressFull)
        NSLayoutConstraint.activate(setupEverythingWillDone())
        NSLayoutConstraint.activate(setupPercent())
        NSLayoutConstraint.activate(setupStripProgressEmpty())
        NSLayoutConstraint.activate(setupStripProgressFull())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        private func setupEverythingWillDone() -> [NSLayoutConstraint] {
            let topAnchor = self.everythingWillDone.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10)
            let bottomAnchor = self.everythingWillDone.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -32)
            let leadingAnchor = self.everythingWillDone.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12)
            return [
                topAnchor, leadingAnchor, bottomAnchor
            ]
        }
    
    private func setupPercent() -> [NSLayoutConstraint] {
        let topAnchor = self.percent.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10)
        let bottomAnchor = self.percent.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -32)
        let trailingAnchor = self.percent.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -12)
        
        return [
            topAnchor, bottomAnchor, trailingAnchor
        ]
    }
    
    private func setupStripProgressFull() -> [NSLayoutConstraint] {
        let topAnchor = self.stripProgressFull.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 38)
        let bottomAnchor = self.stripProgressFull.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -15)
        let leadingAnchor = self.stripProgressFull.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12)
        let widthAnchor = self.stripProgressFull.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 57) * CGFloat(HabitsStore.shared.todayProgress))
        
        return [
            topAnchor, leadingAnchor, bottomAnchor, widthAnchor
        ]
    }
    
    private func setupStripProgressEmpty() -> [NSLayoutConstraint] {
        let topAnchor = self.stripProgressEmpty.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 38)
        let bottomAnchor = self.stripProgressEmpty.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -15)
        let leadingAnchor = self.stripProgressEmpty.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12)
        let trailingAnchor = self.stripProgressEmpty.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -12)
        return [
            topAnchor, leadingAnchor, bottomAnchor, trailingAnchor
        ]
    }
}
