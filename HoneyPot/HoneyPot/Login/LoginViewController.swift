//
//  ViewController.swift
//  HoneyPot
//
//  Created by Shawn Miller on 3/14/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import UIKit
import Foundation
import SnapKit
import SVProgressHUD
import TextFieldEffects

class LoginViewController: UIViewController {
//Global Variables and View Controller Instances
    var stackView: UIStackView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginVC()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        //willr add the keyboard observeNotifs using the notification center
        self.observeKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //will remove the keyboard observeNotifs using the notification center
        self.removeObserveKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func setupLoginVC(){
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(tap)
        
        view.backgroundColor = .white
        view.addSubview(logoImageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 150, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        setupStackView()
        NotificationCenter.default.post(name: heartAttackNotificationName, object: nil)

    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.view.endEditing(true)
    }
    
    @objc func setupStackView(){
        stackView = UIStackView(arrangedSubviews: [ emailTextField, passwordTextField,loginButton])
        self.view.addSubview(stackView!)
        stackView?.distribution = .fillEqually
        stackView?.axis = .vertical
        stackView?.spacing = 15.0
                stackView?.anchor(top: self.logoImageView.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 100, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 152)
        self.addForgotPasswordItem()
        
    }
    
    
    fileprivate func addForgotPasswordItem(){
        let midView = UIView()
        midView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(midView)
        NSLayoutConstraint.activateViewConstraints(midView, inSuperView: self.view, withLeading: 0.0, trailing: 0.0, top: nil, bottom: nil, width: nil, height: 20.0)
        _ = NSLayoutConstraint.activateVerticalSpacingConstraint(withFirstView: self.loginButton, secondView:midView , andSeparation: 9.0)
        midView.addSubview(self.forgotPasswordButton)
        self.forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateViewConstraints(self.forgotPasswordButton, inSuperView: midView, withLeading: 6.0, trailing: 6.0, top: 0.0, bottom: 0.0)
        
        
    }
    
    lazy var forgotPasswordButton: UIButton = {
        let forgotPasswordButton = UIButton(type: .system)
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        forgotPasswordButton.setTitleColor(UIColor.black, for: .normal)
        forgotPasswordButton.addTarget(self, action: #selector(handleForgotPasswordTransition), for: .touchUpInside)
        return forgotPasswordButton
    }()
    
    //will open a new ViewController when forgot password button is pressed
    @objc func handleForgotPasswordTransition(){
        print("forgot password tapped")
    }
    
    //simple image view created to contain the picture in each view
    public var logoImageView: UIImageView = {
        let firstImage = UIImageView()
        firstImage.clipsToBounds = true
        firstImage.image = UIImage(named: "honeyPot")?.withRenderingMode(.alwaysOriginal)
        firstImage.translatesAutoresizingMaskIntoConstraints = false
        firstImage.contentMode = .scaleAspectFit
        return firstImage
    }()
    
    
    let emailTextField : HoshiTextField = {
        let textField = HoshiTextField()
        //        textField.placeholderColor = UIColor.logoColor
        textField.placeholderColor = UIColor.black
        textField.placeholder = "Email"
        textField.placeholderFontScale = 0.85
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.borderStyle = .none
        textField.borderInactiveColor = UIColor.black
        textField.borderActiveColor = UIColor.black
        textField.textColor = .black
        return textField
    }()
    
    // creates a UITextField
    let passwordTextField : HoshiTextField = {
        let textField = HoshiTextField()
        //        textField.placeholderColor = UIColor.logoColor
        textField.placeholderColor = UIColor.black
        textField.placeholder = "Password"
        textField.placeholderFontScale = 0.85
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.borderStyle = .none
        textField.borderInactiveColor = UIColor.black
        textField.borderActiveColor = UIColor.black
        textField.textColor = .black
        return textField
    }()
    
    //will be the button the user presses to login
    lazy var loginButton: UIButton  = {
        let button = UIButton(type: .system)
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.backgroundColor = UIColor.rgb(red: 250, green: 191, blue: 18)
        return button
    }()
    
    @objc func handleLogin(){
        print("Attempted to login")
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and a a password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }else{
            SVProgressHUD.show(withStatus: "Logging in...")
            AuthService.signIn(controller: self, email: emailTextField.text!, password: passwordTextField.text!) { [unowned self] (user) in
                guard user != nil else {
                    // look back here
                    
                    print("error: FiRuser dees not exist")
                    return
                }
                //  print("user is signed in")
                UserService.show(forUID: (user?.uid)!) {[unowned self] (user) in
                    if let user = user {
                        User.setCurrent(user, writeToUserDefaults: true)
                        self.finishLoggingIn()
                    }
                    else {
                        print("error: User does not exist!")
                        return
                    }
                }
            }
        }
    }
    
    @objc func finishLoggingIn() {
        print("Finish logging in from LoginController")
        let homeController = HomeViewController()
        self.view.window?.rootViewController = homeController
        self.view.window?.makeKeyAndVisible()
    }
    
    deinit {
        print("login view controller removed from stack")
        self.removeObserveKeyboardNotifications()
    }
    
    fileprivate func  observeKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    fileprivate func  removeObserveKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        if let keyboardSize = (sender.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            UIView.animate(withDuration: 0.2, animations: {
                self.view.frame.origin.y = -keyboardHeight + 150
            })
        }
    }

    // will properly hide keyboard
    @objc func keyboardWillHide(sender: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.frame.origin.y = 0
        })
    }


}

