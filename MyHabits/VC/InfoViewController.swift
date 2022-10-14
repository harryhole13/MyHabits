//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Алексей Потемин on 22.09.2022.
// Отображения информации о привычках

import UIKit

class InfoViewController: UIViewController {

    lazy private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: "Info")
        tableView.backgroundColor = .white
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        self.navigationItem.title = "Информация"
        self.navigationController?.navigationBar.backgroundColor = UIColor(cgColor: CGColor(red: 249, green: 249, blue: 249, alpha: 0.94))
        
        NSLayoutConstraint.activate(setupTableVIew())
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

extension InfoViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return textInfoHabits.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = UITableViewCell()
            
            let textInfo:UILabel = {
                let string = UILabel()
                string.text = "Привычка за 21 день"
                string.numberOfLines = 0
                string.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                string.textColor = .black
                string.backgroundColor = .white
                string.translatesAutoresizingMaskIntoConstraints = false
                return string
            }()
            cell.addSubview(textInfo)
            NSLayoutConstraint.activate([
            textInfo.topAnchor.constraint(equalTo: cell.topAnchor, constant: 22),
            textInfo.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -16),
            textInfo.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -16),
            textInfo.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 16)
            ])
    
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Info", for: indexPath) as? InfoTableViewCell else { return UITableViewCell() }
            let infoPost = textInfoHabits[indexPath.row]
            cell.setup(with: infoPost)
            return cell
        }
    }
}


