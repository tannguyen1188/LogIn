//
//  ViewController.swift
//  ProjectOut
//
//  Created by Consultant on 9/11/19.
//  Copyright © 2019 Mobile Apps Company. All rights reserved.
//

import UIKit

struct KeyChainConfiguration {
    static let serviceName = "ProjectOut"
    static let accessGroup: String? = nil
}
class LogInViewController: UIViewController {
    var titleLabel: UILabel!
    var userName: UITextField!
    var passWord: UITextField!
    var logIn: UIButton!
    var creatAccount: UIButton!
    var biometricButton: UIButton!
    var biometric = BioMetricAuth()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        loadTitle()
        loadUserName()
        loadPassword()
        loadCreateButton()
        loadLogInButton()
        loadBiometricButton()
    }
    
    func loadTitle(){
        titleLabel = UILabel()
        self.view.addSubview(titleLabel)
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
        titleLabel.font = UIFont.init(name: "Menlo", size: 38.0)
    }
    
    func loadUserName(){
        userName = UITextField()
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.resignFirstResponder()
        userName.autocapitalizationType = .none
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
        passWord.isSecureTextEntry = true
        passWord.resignFirstResponder()
        passWord.autocapitalizationType = .none
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
        creatAccount.addTarget(self, action: #selector (createAccount), for: .touchUpInside)
        
    }
    @objc func createAccount () {
        
        let newUserName = userName.text
        let newPassWord = passWord.text!
        if ((!newUserName!.isEmpty) && (!newPassWord.isEmpty)){
            let hasLogInKey = UserDefaults.standard.bool(forKey: "hasLogInKey")
            if !hasLogInKey && userName.hasText {
                UserDefaults.standard.setValue(newUserName, forKey: "username")
            }
            do {
                let passwordItem = KeychainPasswordItem(service: KeyChainConfiguration.serviceName, account: newUserName!, accessGroup: KeyChainConfiguration.accessGroup)
                try passwordItem.savePassword(newPassWord)
            } catch {
                fatalError("Error to update keychain: \(error)")
            }
            let vc = TabBarViewController()
            present(vc, animated: true)
        } else {
            showCreateAlert()
        }
        
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
        logIn.addTarget(self, action: #selector(loadLogIn), for: .touchUpInside)
        
    }
    @objc func loadLogIn(){
        
        guard userName.text == UserDefaults.standard.value(forKey: "username") as? String else {
            showLogInAlert()
            return
        }
        do {
            let passwordItem = KeychainPasswordItem(service: KeyChainConfiguration.serviceName, account: userName.text!, accessGroup: KeyChainConfiguration.accessGroup)
            let keychainPassword = try passwordItem.readPassword()
            if (keychainPassword == passWord.text) {
                let vc = TabBarViewController()
                present(vc, animated: true)
            }
            else {
                showLogInAlert()
            }
        } catch {
            fatalError("Error reading password in Keychain: \(error) ")
        }
    }
    func loadBiometricButton(){
        biometricButton = UIButton()
        view.addSubview(biometricButton)
        biometricButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            biometricButton.topAnchor.constraint(equalTo: creatAccount.bottomAnchor, constant: 50),
            biometricButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70),
            biometricButton.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor),
            biometricButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: 50)
            ])
        switch biometric.biometricType() {
        case .faceID:
            biometricButton.setImage(UIImage(named: "FaceIcon"), for: .normal)
        case .touchID:
            biometricButton.setImage(UIImage(named: "Touch-icon-lg"), for: .normal)
        case .none:
            biometricButton.isHidden = true
        }
        biometricButton.addTarget(self, action: #selector(dismissLogIn), for: .touchUpInside)
    }
    @objc func dismissLogIn() {
        biometric.authenticateUser() {[unowned self] message in
            if let message = message {
                let alertView = UIAlertController(title: "Error",
                                                  message: message,
                                                  preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Fail", style: .default)
                alertView.addAction(okAction)
            } else {
            let vc = TabBarViewController()
                self.present(vc, animated: true)
        }
    }
    }
    func showLogInAlert (){
        let alertView = UIAlertController(title: "Log In Fail", message: "Wrong UserName/PassWord", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Try Again", style: .default)
        alertView.addAction(alertAction)
        present(alertView, animated: true)
    }
    func showCreateAlert(){
        let alertView = UIAlertController(title: "Fail creating account", message: "Please fill in username and password", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Try again", style: .default)
        alertView.addAction(alertAction)
        present(alertView, animated:  true)
    }
}

