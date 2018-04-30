//
//  AuthService.swift
//  HoneyPot
//
//  Created by Shawn Miller on 3/16/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import SVProgressHUD
import Firebase

class AuthService {
    //will sign in an authenticated user
    static func signIn(controller : UIViewController, email: String, password: String, completion: @escaping (FIRUser?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: "Errpr Signing In")
                
                //loginErrors(error: error, controller: controller)
                return completion(nil)
            }
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //take this out for now this is here for push notifs that may or may not be used somewhere down the line
            UserService.updateDeviceToken(deviceToken: appDelegate.strDeviceToken, userId: (user?.uid)!)
            return completion(user)
        }
    }
    
    
    static func presentLogOut(viewController : UIViewController){
        let alertController = UIAlertController(title: "Are You Sure You Want To Log Out?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let logoutAction = UIAlertAction(title: "Log Out", style: .default){_ in
            logUserOut()
        }
        alertController.addAction(logoutAction)
        
        viewController.present(alertController, animated: true)
    }
    
    
    static func logUserOut(){
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            assertionFailure("Error signing out: \(error.localizedDescription)")
        }
        
    }
    
    //will allow user to return to login controller after they logout
    
    static func authListener(viewController view : UIViewController) -> AuthStateDidChangeListenerHandle {
        let authHandle = Auth.auth().addStateDidChangeListener() { (auth, user) in
            guard user == nil else { return }
            
            let loginViewController = LoginViewController()
            view.view.window?.rootViewController = loginViewController
            view.view.window?.makeKeyAndVisible()
        }
        return authHandle
    }
    
    //use this to confirm user has logged out
    static func removeAuthListener(authHandle : AuthStateDidChangeListenerHandle?){
        if let authHandle = authHandle {
            Auth.auth().removeStateDidChangeListener(authHandle)
        }
    }
    
    
    static func resetUserPassword(controller: UIViewController,for email: String?, completion: @escaping (Bool) -> Void){
        //send email for user to reset password
        if let userEmail = email {
            Auth.auth().sendPasswordReset(withEmail: userEmail) { (error) in
                if let errors = error {
                    print(errors)
                    //show some error in regards to password reset
                    resetErrors(error: error!, controller: controller)
                    return completion(false)
                }
                //success
                print("Sent password reset to \(String(describing: email))")
                completion(true)
                //show completion of password reset action
                
            }
        }
    }
    
    
    private static func loginErrors(error : Error, controller : UIViewController){
        switch (error.localizedDescription) {
        case "The email address is badly formatted.":
            let invalidEmailAlert = UIAlertController(title: "Invalid Email", message:
                "It seems like you have put in an invalid email.", preferredStyle: UIAlertControllerStyle.alert)
            invalidEmailAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            controller.present(invalidEmailAlert, animated: true, completion: nil)
            break;
        case "The password is invalid or the user does not have a password.":
            let wrongPasswordAlert = UIAlertController(title: "Wrong Password", message:
                "It seems like you have entered the wrong password.", preferredStyle: UIAlertControllerStyle.alert)
            wrongPasswordAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            controller.present(wrongPasswordAlert, animated: true, completion: nil)
            break;
        case "There is no user record corresponding to this identifier. The user may have been deleted.":
            let wrongPasswordAlert = UIAlertController(title: "No Account Found", message:
                "We couldn't find an account that corresponds to that email. Do you want to create an account?", preferredStyle: UIAlertControllerStyle.alert)
            wrongPasswordAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            controller.present(wrongPasswordAlert, animated: true, completion: nil)
            break;
        default:
            let loginFailedAlert = UIAlertController(title: "Error Logging In", message:
                "There was an error logging you in. Please try again soon.", preferredStyle: UIAlertControllerStyle.alert)
            loginFailedAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            controller.present(loginFailedAlert, animated: true, completion: nil)
            break;
        }
    }
    
    
    private static func resetErrors(error: Error, controller: UIViewController){
        print(error.localizedDescription)
        
        switch error.localizedDescription{
        case "There is no user record corresponding to this identifier. The user may have been deleted." :
            let invalidEmail = UIAlertController(title: "There is no user record corresponding to this email", message:
                "Please enter the email connected to your account..", preferredStyle: UIAlertControllerStyle.alert)
            invalidEmail.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            controller.present(invalidEmail, animated: true, completion: nil)
            
            break;
            
        default :
            let generalErrorAlert = UIAlertController(title: "We are having trouble processing your password reset request.", message:
                "We are having trouble processing your password reset request, please try again soon.", preferredStyle: UIAlertControllerStyle.alert)
            generalErrorAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            controller.present(generalErrorAlert, animated: true, completion: nil)
            break;
        }
        
    }
    
    
}
