//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Алексей Потемин on 24.09.2022.
// Контроллер отображения привычек

import UIKit

class HabitsViewController: UIViewController {
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 17)
        layout.minimumInteritemSpacing = 8
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 33, height: 60)
        layout.scrollDirection = .vertical
        return layout
    }()

    private lazy var coollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .lightGray
        collection.dataSource = self
        collection.delegate = self
        collection.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "Habit")
        collection.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "Progress")
        return collection
    }()
    
//    lazy private var coll: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .insetGrouped)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
////        tableView.delegate = self
//        tableView.dataSource = self
////        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: "Info")
//        tableView.backgroundColor = .white
//        return tableView
//    }()
    
    private lazy var addButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showPostModal), for: .touchUpInside)
//        button.imageView?.contentMode = .scaleAspectFit
//        button.contentVerticalAlignment = .fill
//        button.contentHorizontalAlignment = .fill
//        button.backgroundColor = .s
//        button.imageView?.frame = .init(x: 0, y: 0, width: 344, height: 344)
        return button
    }()
    
    @objc private func showPostModal() {
        let edit = UINavigationController(rootViewController: HabitViewController(hideDeleteButton: true, nameHabit: "", colorButton: .blue) )
//        let edit1 = HabitViewController()
        edit.modalPresentationStyle = .fullScreen
        print("touchButton")
        self.present(edit, animated: true)  //modalno
//        self.navigationController?.pushViewController(edit1, animated: true)
    }
    
    private lazy var today:UILabel = {
        let today = UILabel()
        today.font = .boldSystemFont(ofSize: 34)
        today.textColor = .black
        today.text = "Сегодня"
        today.translatesAutoresizingMaskIntoConstraints = false
        return today
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        self.view.addSubview(addButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        self.navigationItem.title = today.text
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.addSubview(coollectionView)
        NSLayoutConstraint.activate(setupCollectionVIew())
        print("viewdidload")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.coollectionView.reloadData()
        print("Reload Collection")
//        collectionView(coollectionView, cellForItemAt: IndexPath)
        print("viewWillAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }

    private func setupCollectionVIew() -> [NSLayoutConstraint] {
        let topAnchor = self.coollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingAnchor = self.coollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = self.coollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomAnchor = self.coollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        
        return [
            topAnchor, leadingAnchor, trailingAnchor, bottomAnchor
        ]
    }
    

}

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MyFirstDelegate {
    
    func trackerIsReady(cell: UICollectionViewCell) {
        guard let indexPath = self.coollectionView.indexPath(for: cell) else {
                return
            }
        HabitsStore.shared.track(HabitsStore.shared.habits[indexPath.row - 1])
        self.coollectionView.reloadData()
        print("Reload Collection")
            print("addCurrent Date in cell \(indexPath.row)")
        }
    
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = HabitsStore.shared.habits.count + 1
        print("numberofitem \(count)")
        print(HabitsStore.shared)
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Progress", for: indexPath) as? ProgressCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            print("render 1 cell")
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Habit", for: indexPath) as? HabitCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            let habit = HabitsStore.shared.habits[indexPath.row - 1]
            cell.setupCell(with: habit)
            print(indexPath.row)
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            let edit1 = HabitDetailsViewController()
            
            edit1.habit = HabitsStore.shared.habits[indexPath.row - 1]
            print("press habit \(indexPath) ")
            print("press \(HabitsStore.shared.habits[indexPath.row - 1].name)")
            edit1.index = indexPath.row - 1
            
            edit1.chek = HabitsStore.shared.habits[indexPath.row - 1].name
            edit1.nameTitleHabit = HabitsStore.shared.habits[indexPath.row - 1].name
            
            print("didSelect")
            navigationController?.pushViewController(edit1, animated: true) // YАш VC
        }
    }
}


