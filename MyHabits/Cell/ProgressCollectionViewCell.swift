//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Алексей Потемин on 01.10.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private lazy var everythingWillDone: UILabel = {
        let label = UILabel()
        label.text = "Всё получится!"
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var percent: UILabel = {
        let label = UILabel()
        let value = Int(HabitsStore.shared.todayProgress * 100)
        label.text = "\(value)%"
        label.textColor = .lightGray
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.progressViewStyle = .default
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(everythingWillDone)
        self.contentView.addSubview(percent)
        self.contentView.addSubview(progressView)
        self.upProgress()
        NSLayoutConstraint.activate(setupEverythingWillDone())
        NSLayoutConstraint.activate(setupPercent())
        NSLayoutConstraint.activate(setupProgressView())
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
    
    private func setupProgressView() -> [NSLayoutConstraint] {
        let topAnchor = self.progressView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 38)
        let bottomAnchor = self.progressView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -15)
        let leadingAnchor = self.progressView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12)
        let trailingAnchor = self.progressView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -12)
        return [
            topAnchor, leadingAnchor, bottomAnchor, trailingAnchor
        ]
    }
    
    func upProgress(){
        self.progressView.setProgress(HabitsStore.shared.todayProgress, animated: true)
        self.percent.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
    }
    
}
