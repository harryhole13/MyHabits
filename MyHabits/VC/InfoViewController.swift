//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Алексей Потемин on 22.09.2022.
// Отображения информации о привычках

import UIKit

class InfoViewController: UIViewController {
    
    lazy private var scrollView = UIScrollView()
    
    lazy private var contentView = UIView()
    
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
    
    lazy private var post: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        label.backgroundColor = .white
        label.text = """
Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:\n1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.\n2. Выдержать 2 дня в прежнем состоянии самоконтроля.\n3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.\n4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.\n5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.\n6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся     
"""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.navigationController?.navigationBar.backgroundColor = UIColor(cgColor: CGColor(red: 249, green: 249, blue: 249, alpha: 0.94))
        self.navigationItem.title = "Информация"
        self.contentView.addSubview(textInfo)
        self.contentView.addSubview(post)

        NSLayoutConstraint.activate(setupScrollView())
        NSLayoutConstraint.activate(setupPost())
        NSLayoutConstraint.activate(setupTextInfo())
        
    }
    
    private func setupScrollView() -> [NSLayoutConstraint] {
        let topAnchor = self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingAnchor = self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomAnchor = self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        let topAnchorContent = self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor)
        let leadingAnchorContent = self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor)
        let widthAnchor = self.contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width)
        let bottomAnchorContent = self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        
        return [
            topAnchor, leadingAnchor, trailingAnchor, bottomAnchor,
            topAnchorContent, leadingAnchorContent, widthAnchor, bottomAnchorContent
        ]
    }
    
    private func setupTextInfo() -> [NSLayoutConstraint] {
        
        let topAnchor = self.textInfo.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 12)
        let leadingAnchor = self.textInfo.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 16)
      
        return [
            topAnchor, leadingAnchor,
        ]
    }
    
    private func setupPost() -> [NSLayoutConstraint] {
        
        let topAnchor = self.post.topAnchor.constraint(equalTo: self.textInfo.bottomAnchor,constant: 12)
        let leadingAnchor = self.post.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 16)
        let trailingAnchor = self.post.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -16)
        let bottomAnchor = self.post.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -12)
        return [
            topAnchor, leadingAnchor, trailingAnchor, bottomAnchor
        ]
    }
}
