//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Алексей Потемин on 27.09.2022.
//

import UIKit

class HabitViewController: UIViewController {
    
    var index: Int?
    
    private lazy var saveButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        button.setTitle("Сохранить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveHabit), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteHabitButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(.red, for: .normal)
        button.setTitle("Удалить привычку", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameLabel:UILabel = {
        let today = UILabel()
        today.font = .systemFont(ofSize: 13)
        today.textColor = .black
        today.text = "НАЗВАНИЕ"
        today.translatesAutoresizingMaskIntoConstraints = false
        return today
    }()
    
    private lazy var colorLabel:UILabel = {
        let today = UILabel()
        today.font = .systemFont(ofSize: 13)
        today.textColor = .black
        today.text = "Цвет"
        today.translatesAutoresizingMaskIntoConstraints = false
        return today
    }()
    
    private lazy var nameHabit:UITextField = {
        let name = UITextField()
        name.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        name.font = .systemFont(ofSize: 17, weight: .regular)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var timeLabel:UILabel = {
        let today = UILabel()
        today.font = .systemFont(ofSize: 13)
        today.textColor = .black
        today.text = "ВРЕМЯ"
        today.translatesAutoresizingMaskIntoConstraints = false
        return today
    }()
    
    private lazy var everyDayLabel:UILabel = {
        let today = UILabel()
        today.font = .systemFont(ofSize: 17)
        today.textColor = .black
        today.text = "Каждый день в "
        today.translatesAutoresizingMaskIntoConstraints = false
        return today
    }()
    
    private lazy var timeDateLabel:UILabel = {
        let time = UILabel()
        time.font = .systemFont(ofSize: 17)
        time.textColor = UIColor(named: "AccentColor")
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH:mm a"
        time.text = "\(dateFormat.string(from: self.timePicker.date))"
        time.translatesAutoresizingMaskIntoConstraints = false
        return time
    }()
    
    private lazy var colorButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editColorButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var timePicker:UIDatePicker = {
        var time = UIDatePicker()
        time.preferredDatePickerStyle = .wheels
        time.datePickerMode = UIDatePicker.Mode.time
        time.translatesAutoresizingMaskIntoConstraints = false
        time.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        return time
    }()
    
    @objc private func changeDate() {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH:mm a"
        self.timeDateLabel.text = "\(dateFormat.string(from: self.timePicker.date))"
    }
    
    @objc private func deleteHabit() {
        
            let alertInfo = UIAlertController(
                title: "End of quest",
                message: "Вы хотите удалить привычку ",
                preferredStyle: .alert
               
            )
            
            let okAction = UIAlertAction(
                title: "Sure",
                style: .default) {
                    _ in
                    HabitsStore.shared.habits.remove(at: self.index!)
                    print ("Delete habit index \(self.index!)")
                    self.navigationController?.popToRootViewController(animated: true)
                    }
            
            let cancelAlert = UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil)
            
            alertInfo.addAction(okAction)
            alertInfo.addAction(cancelAlert)
            self.present(alertInfo, animated: true, completion: nil)
        }
    
    
    @objc private func editColorButton() {
        
        let picker = UIColorPickerViewController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    
    }
    
    @objc private func saveHabit() {
        
        let newHabit = Habit(name: nameHabit.text ?? "",
                             date: Date(),
                             color: colorButton.backgroundColor ?? .systemBackground)
        let store = HabitsStore.shared
        
        if deleteHabitButton.isHidden == true {
            
            store.habits.append(newHabit)
     
            print("add \(newHabit.isAlreadyTakenToday)")
            
            dismiss(animated: true, completion: nil)
            
        } else {
           
            store.habits[index!] = newHabit
            print("Replace index \(index!)")
            navigationController?.popToRootViewController(animated: true)
//            dismiss(animated: true, completion: nil)
        }
    }
        
    private lazy var cancelButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        button.setTitle("Отменить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backVC), for: .touchUpInside)
        return button
    }()
    
    @objc private func backVC() {
        
        if deleteHabitButton.isHidden == true {
            
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(nameLabel)
        self.view.addSubview(nameHabit)
        self.view.addSubview(colorLabel)
        self.view.addSubview(colorButton)
        self.view.addSubview(timeLabel)
        self.view.addSubview(everyDayLabel)
        self.view.addSubview(timeDateLabel)
        self.view.addSubview(timePicker)
        self.view.addSubview(deleteHabitButton)
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: cancelButton)
        self.navigationItem.title = "Создать"
        NSLayoutConstraint.activate(setupNameLabel())
        NSLayoutConstraint.activate(setupNameHabit())
        NSLayoutConstraint.activate(setupСolorLabel())
        NSLayoutConstraint.activate(setupСolorButton())
        NSLayoutConstraint.activate(setupTimeLabel())
        NSLayoutConstraint.activate(setupEveryDay())
        NSLayoutConstraint.activate(setupDeleteHabitButton())
        NSLayoutConstraint.activate(setupTimePicker())
        NSLayoutConstraint.activate(setupTimeDateLabel())
    }
    
    private func setupNameLabel() -> [NSLayoutConstraint] {
        let topAnchor = self.nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 21)
        let leadingAnchor = self.nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        let heightAnchor = self.nameLabel.heightAnchor.constraint(equalToConstant: 18)
        return [
            topAnchor, leadingAnchor, heightAnchor
        ]
    }
    
    private func setupNameHabit() -> [NSLayoutConstraint] {
        let topAnchor = self.nameHabit.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 46)
        let leadingAnchor = self.nameHabit.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15)
        let heightAnchor = self.nameHabit.heightAnchor.constraint(equalToConstant: 22)
        return [
            topAnchor, leadingAnchor, heightAnchor
        ]
    }
    
    private func setupDeleteHabitButton() -> [NSLayoutConstraint] {
        let centerXAnchor = self.deleteHabitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let bottomAnchor = self.deleteHabitButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -18)
//        let heightAnchor = self.deleteHabitButton.heightAnchor.constraint(equalToConstant: 22)
        return [
            bottomAnchor, centerXAnchor
        ]
    }
    
    private func setupTimePicker() -> [NSLayoutConstraint] {
        let topAnchor = self.timePicker.topAnchor.constraint(equalTo: self.everyDayLabel.bottomAnchor,constant: 15)
        let leadingAnchor = self.timePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = self.timePicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let heightAnchor = self.timePicker.heightAnchor.constraint(equalToConstant: 216)
        return [
            topAnchor, leadingAnchor, trailingAnchor, heightAnchor
        ]
    }
    
    private func setupСolorLabel() -> [NSLayoutConstraint] {
        let topAnchor = self.colorLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 83)
        let leadingAnchor = self.colorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        let heightAnchor = self.colorLabel.heightAnchor.constraint(equalToConstant: 18)
        return [
            topAnchor, leadingAnchor, heightAnchor
        ]
    }
    
    private func setupСolorButton() -> [NSLayoutConstraint] {
        let topAnchor = self.colorButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 108)
        let leadingAnchor = self.colorButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        let heightAnchor = self.colorButton.heightAnchor.constraint(equalToConstant: 30)
        return [
            topAnchor, leadingAnchor, heightAnchor
        ]
    }
    
    private func setupTimeLabel() -> [NSLayoutConstraint] {
        let topAnchor = self.timeLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 153)
        let leadingAnchor = self.timeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        let heightAnchor = self.timeLabel.heightAnchor.constraint(equalToConstant: 18)
        return [
            topAnchor, leadingAnchor, heightAnchor
        ]
    }
    
    private func setupEveryDay() -> [NSLayoutConstraint] {
        let topAnchor = self.everyDayLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 178)
        let leadingAnchor = self.everyDayLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        let heightAnchor = self.everyDayLabel.heightAnchor.constraint(equalToConstant: 22)
        return [
            topAnchor, leadingAnchor, heightAnchor
        ]
    }
    
    private func setupTimeDateLabel() -> [NSLayoutConstraint] {
        let topAnchor = self.timeDateLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 178)
        let leadingAnchor = self.timeDateLabel.leadingAnchor.constraint(equalTo: self.everyDayLabel.trailingAnchor, constant: 2)
        let heightAnchor = self.timeDateLabel.heightAnchor.constraint(equalToConstant: 22)
        return [
            topAnchor, leadingAnchor, heightAnchor
        ]
    }

    init(hideDeleteButton: Bool, nameHabit: String, colorButton: UIColor) {
        
        super.init(nibName: nil, bundle: nil)
        self.deleteHabitButton.isHidden = hideDeleteButton
        self.nameHabit.text = nameHabit
        self.colorButton.backgroundColor = colorButton
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    //  Called once you have finished picking the color.
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.colorButton.backgroundColor = viewController.selectedColor
        
    }
    
    //  Called on every color selection done in the picker.
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
            self.colorButton.backgroundColor = viewController.selectedColor
    }
}

