//
//  ViewController.swift
//  ProjectOut
//
//  Created by Consultant on 9/11/19.
//  Copyright © 2019 Mobile Apps Company. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    var titleLabel: UILabel!
    var userName: UITextField!
    var passWord: UITextField!
    var logIn: UIButton!
    var creatAccount: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        loadTitle()
        loadUserName()
        loadPassword()
        loadCreateButton()
        loadLogInButton()
    }
    
    func loadTitle(){
        titleLabel = UILabel()
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100),
            titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 200.00),
            titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 100.00)
            
            ])
        titleLabel.text = "LOG IN"
        titleLabel.backgroundColor = .black
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 38)
    }
    
    func loadUserName(){
        userName = UITextField()
        userName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userName)
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35),
            userName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            userName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            userName.heightAnchor.constraint(equalToConstant: 30)
            ])
        userName.backgroundColor = .white
    }
    func loadPassword(){
        passWord = UITextField()
        passWord.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passWord)
        NSLayoutConstraint.activate([
            passWord.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 25),
            passWord.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            passWord.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            passWord.heightAnchor.constraint(equalToConstant: 30)
            ])
        passWord.backgroundColor = .white
    }
    func loadCreateButton(){
        creatAccount = UIButton()
        view.addSubview(creatAccount)
        creatAccount.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            creatAccount.topAnchor.constraint(equalTo: passWord.bottomAnchor, constant: 35),
            creatAccount.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            creatAccount.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            creatAccount.heightAnchor.constraint(equalToConstant: 30)
            ])
        creatAccount.backgroundColor = .lightGray
        creatAccount.setTitle("Create", for: .normal)
        creatAccount.setTitleColor(.white, for: .normal)
        
    }
    func loadLogInButton(){
        logIn = UIButton()
        logIn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logIn)
        NSLayoutConstraint.activate([
            logIn.topAnchor.constraint(equalTo: passWord.bottomAnchor, constant: 35),
            logIn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            logIn.leftAnchor.constraint(equalTo: creatAccount.rightAnchor, constant: 20),
            logIn.heightAnchor.constraint(equalToConstant: 30)
            ])
        logIn.backgroundColor = .lightGray
        logIn.setTitle("Log In", for: .normal)
        logIn.setTitleColor(.white, for: .normal)
        
    }
}

