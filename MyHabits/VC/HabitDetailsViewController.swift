//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Алексей Потемин on 02.10.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    var habit: Habit!
    var arrayDates: [Date] = []
    var nameTitleHabit: String = ""
    var index: Int = 0
    var chek: String = ""
    
    
    func calculateDates(from fromDate: Date){
            var date = fromDate
            while date <= Date() {
                arrayDates.append(date)
                guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
                date = newDate
            }
        }
    
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .lightGray
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private lazy var editButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        button.setTitle("Править", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editHabit), for: .touchUpInside)
        return button
    }()
    
    @objc private func editHabit() {
        let VC = HabitViewController(hideDeleteButton: false, nameHabit: habit.name, colorButton: habit.color)
        VC.index = self.index
        VC.modalPresentationStyle = .fullScreen
        print("touchButton index \(index)")
        navigationController?.pushViewController(VC, animated: true)
    }
    
    let imageChek:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "checkmark")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        self.view.backgroundColor = .lightGray
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = nameTitleHabit
        print("viewDidLoad HabitDetailsViewController")
        calculateDates(from: habit.date)
        NSLayoutConstraint.activate(setupTableVIew())
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear HabitDetailsViewController")
    }
    
    
    private func setupTableVIew() -> [NSLayoutConstraint] {
        let topAnchor = self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingAnchor = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomAnchor = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        return [
            topAnchor, leadingAnchor, trailingAnchor, bottomAnchor
        ]
        
    }
    
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentDate = DateFormatter()
        currentDate.dateStyle = .medium
        currentDate.doesRelativeDateFormatting = true
        currentDate.string(from: arrayDates[indexPath.row])
        let cell = UITableViewCell()
        let active:UILabel = {
            let label = UILabel()
            label.text = "\(currentDate.string(from: arrayDates[indexPath.row]))"
            label.font = .systemFont(ofSize: 17)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        cell.backgroundColor = .white
        if habit.isAlreadyTakenToday {
            cell.addSubview(self.imageChek)
            NSLayoutConstraint.activate([
                self.imageChek.topAnchor.constraint(equalTo: cell.topAnchor),
                self.imageChek.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
                self.imageChek.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -14),
            ])
        }
        cell.addSubview(active)
        NSLayoutConstraint.activate([
            active.topAnchor.constraint(equalTo: cell.topAnchor, constant: 11),
            active.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -11),
            active.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 16),
        ])
        return cell
    }

}
                  
