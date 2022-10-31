//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Алексей Потемин on 01.10.2022.
//

import UIKit

protocol TrackerDelegate: AnyObject {
    func trackerIsReady(cell: UICollectionViewCell)
}

class HabitCollectionViewCell: UICollectionViewCell {
    
//    var delegate: HabitsViewController? // тоже самое только без протокола
    var delegate_tracker: TrackerDelegate?
    
    
    private lazy var nameHabit:UILabel = {
        let label = UILabel()
        label.text = "Название привычки"
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var everyDayInTime:UILabel = {
        let label = UILabel()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH:mm a"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countLabel:UILabel = {
        let label = UILabel()
        label.text = "Счётчик: 0"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    lazy var tracker:UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(systemName: "circle")

        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(nameHabit)
        self.contentView.addSubview(everyDayInTime)
        self.contentView.addSubview(countLabel)
        self.contentView.addSubview(tracker)
        self.setupGestureCircle()
        NSLayoutConstraint.activate(setupEveryDayInTime())
        NSLayoutConstraint.activate(setupNameHabit())
        NSLayoutConstraint.activate(setupCountLabel())
        NSLayoutConstraint.activate(setupTracker())
    }
    
    private func setupNameHabit() -> [NSLayoutConstraint] {
        let topAnchor = self.nameHabit.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 20)
        let bottomAnchor = self.nameHabit.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -88)
        let leadingAnchor = self.nameHabit.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 20)
        return [
            topAnchor, leadingAnchor, bottomAnchor
        ]
    }
    
    private func setupEveryDayInTime() -> [NSLayoutConstraint] {
        let topAnchor = self.everyDayInTime.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 46)
        let bottomAnchor = self.everyDayInTime.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -68)
        let leadingAnchor = self.everyDayInTime.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 20)
        return [
            topAnchor, leadingAnchor, bottomAnchor
        ]
    }
    
    private func setupCountLabel() -> [NSLayoutConstraint] {
        let topAnchor = self.countLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 92)
        let bottomAnchor = self.countLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -20)
        let leadingAnchor = self.countLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 20)
        return [
            topAnchor, leadingAnchor, bottomAnchor
        ]
    }
    
    private func setupTracker() -> [NSLayoutConstraint] {
        let topAnchor = self.tracker.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 47)
        let widthAnchor = self.tracker.widthAnchor.constraint(equalToConstant: 36)
        let heightAnchor = self.tracker.heightAnchor.constraint(equalToConstant: 36)
        let trailingAnchor = self.tracker.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -26)
        return [
            topAnchor, trailingAnchor, widthAnchor, heightAnchor
        ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupGestureCircle() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(tapAction))
        self.tracker.isUserInteractionEnabled = true
        self.tracker.addGestureRecognizer(tapGesture)
        print("setupGesture HabitCollectionViewCell")
    }

    @objc func tapAction() {
        delegate_tracker?.trackerIsReady(cell: self)
        
        print("@Objc tapAction ")
        
    }
    
    func setupCell(with habit: Habit) {
        self.nameHabit.text = habit.name
        self.tracker.tintColor = habit.color
        self.everyDayInTime.text = habit.dateString
        if habit.isAlreadyTakenToday {
            self.tracker.image = UIImage(systemName: "checkmark.circle.fill")
        }
    }
}
