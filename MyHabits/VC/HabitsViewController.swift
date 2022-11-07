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

    lazy var coollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .lightGray
        collection.dataSource = self
        collection.delegate = self
        collection.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "Habit")
        collection.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "Progress")
        return collection
    }()

    private lazy var addButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showPostModal), for: .touchUpInside)

        return button
    }()
    
    @objc private func showPostModal() {
        let edit = UINavigationController(rootViewController: HabitViewController(hideDeleteButton: true, nameHabit: "", colorButton: .blue) )
        edit.modalPresentationStyle = .fullScreen
        print("touchButton")
        self.present(edit, animated: true)  //modalno
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        self.navigationItem.title = today.text
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.addSubview(coollectionView)
        NSLayoutConstraint.activate(setupCollectionVIew())
        print(HabitsStore.shared.todayProgress)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.coollectionView.reloadData()
        print("viewWillAppear  HabitsViewController ")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear HabitsViewController")
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

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TrackerDelegate {
    
    func updateProgressCollectionCell () {
        let cell = self.coollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? ProgressCollectionViewCell
        cell?.upProgress()
    }
    
    func trackerIsReady(cell: UICollectionViewCell) {
        coollectionView.reloadData()
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
            print("render progress")
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            cell.upProgress()
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Habit", for: indexPath) as? HabitCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            let habit = HabitsStore.shared.habits[indexPath.row - 1]
            cell.habbit = habit
            cell.setupCell()
            cell.delegate_tracker = self
            print("render \(indexPath.row - 1)")
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            let edit1 = HabitDetailsViewController()
            edit1.habit = HabitsStore.shared.habits[indexPath.row - 1]
            edit1.index = indexPath.row - 1
            edit1.chek = HabitsStore.shared.habits[indexPath.row - 1].name
            edit1.nameTitleHabit = HabitsStore.shared.habits[indexPath.row - 1].name
            print("didSelect navigationController?.pushViewController(edit1, animated: true) ")
            navigationController?.pushViewController(edit1, animated: true) // YАш VC
        }
    }
}

