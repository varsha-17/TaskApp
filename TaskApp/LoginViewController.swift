//
//  LoginViewController.swift
//  TaskApp
//
//  Created by Varsha Sharma on 12/04/26.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var forgotLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var createLabel: UILabel!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailIconView: UIView!
    @IBOutlet weak var emailIconImg: UIImageView!
    
    @IBOutlet weak var passwordIconView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordIconImg: UIImageView!
    
    @IBOutlet weak var eyeIconBtn: UIButton!
    @IBOutlet weak var createLabelView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func setupUI() {
        
        let primaryPink = UIColor(red: 0.95, green: 0.60, blue: 0.65, alpha: 1.0)
        let softGray = UIColor.darkGray
        
        titleLabel.textColor = .black
        signInLabel.textColor = softGray
        
        loginLabel.textColor = .black
        loginLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.08
        cardView.layer.shadowOffset = CGSize(width: 0, height: 5)
        cardView.layer.shadowRadius = 10
        
        styleInputView(emailView)
        styleInputView(passwordView)
        
        emailField.backgroundColor = .clear
        passwordField.backgroundColor = .clear
        
        emailField.borderStyle = .none
        passwordField.borderStyle = .none
        
        forgotLabel.textColor = primaryPink
        
        loginBtn.backgroundColor = primaryPink
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.layer.cornerRadius = 12
        
        let fullText = "Don't have an account? Create"
        let attributed = NSMutableAttributedString(string: fullText)

        if let range = fullText.range(of: "Create") {
            let nsRange = NSRange(range, in: fullText)
            attributed.addAttribute(.foregroundColor, value: primaryPink, range: nsRange)
            attributed.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .semibold), range: nsRange)
        }

        createLabel.attributedText = attributed
        
        emailIconImg.tintColor = primaryPink
        passwordIconImg.tintColor = primaryPink
        
        emailIconImg.image = emailIconImg.image?.withRenderingMode(.alwaysTemplate)
        passwordIconImg.image = passwordIconImg.image?.withRenderingMode(.alwaysTemplate)
        
        eyeIconBtn.tintColor = primaryPink
        passwordField.isSecureTextEntry = true
        eyeIconBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func styleInputView(_ view: UIView) {
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 0
        view.clipsToBounds = true
    }
    
    @IBAction func loginBtnTap(_ sender: Any) {
        
        let email = emailField.text
        let password = passwordField.text
        
        if email == nil || email == "" {
            showAlert(message: "Please enter email")
            return
        }
        
        if !isValidEmail(email!) {
             showAlert(message: "Please enter valid email")
             return
         }
         
        
        if password == nil || password == "" {
            showAlert(message: "Please enter password")
            return
        }
        
        navigateToDashboard()
    }
    
    @IBAction func eyeIconTapped(_ sender: UIButton) {
        passwordField.isSecureTextEntry.toggle()
        let imageName = passwordField.isSecureTextEntry ? "eye.slash" : "eye"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func navigateToDashboard(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let dashboardVC = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController {
            navigationController?.pushViewController(dashboardVC, animated: true)
        }
    }
}
