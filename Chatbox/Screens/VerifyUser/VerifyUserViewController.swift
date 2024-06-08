//
//  VerifyUserViewController.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 25/01/2024.
//

import UIKit

class VerifyUserViewController: UIViewController {

    var viewModel: VerifyUserViewModel!
    var number = ""
    
    @IBOutlet weak var checkBitton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var code1TextField: UITextField!
    @IBOutlet weak var code2TextField: UITextField!
    @IBOutlet weak var code3TextField: UITextField!
    @IBOutlet weak var code4TextField: UITextField!
    @IBOutlet weak var code5TextField: UITextField!
    @IBOutlet weak var code6TextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        observeEvent()

    }
    
    @IBAction func CheckButtonClick(_ sender: Any) {
        
        if checkValidation() {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            checkBitton.alpha = 0.25
            viewModel.requestVerifyCode(code: getCode(), number: number)
            
        }
        
    }
    
    func observeEvent() {
        viewModel.output = { [weak self] event in
            guard let self else { return }
            switch event {
                
            case .verified:
                print("Verified")
            case .failToVerify:
                errorLabel.isHidden = false
                activityIndicator.isHidden = true
                activityIndicator.stopAnimating()
                checkBitton.alpha = 1.0
                print("failedToVerify")
            }
        }
    }
    
    func checkValidation() -> Bool {
        if code1TextField.text != "" && code2TextField.text != "" && code3TextField.text != "" && code4TextField.text != "" && code5TextField.text != "" && code6TextField.text != "" {
            return true
        }
        return false
    }
    
    func getCode() -> String{
        if code1TextField.text != "" && code2TextField.text != "" && code3TextField.text != "" && code4TextField.text != "" && code5TextField.text != "" && code6TextField.text != "" {
            let code1 = code1TextField.text ?? "0"
            let code2 = code2TextField.text ?? "0"
            let code3 = code3TextField.text ?? "0"
            let code4 = code4TextField.text ?? "0"
            let code5 = code5TextField.text ?? "0"
            let code6 = code6TextField.text ?? "0"
            return (code1 + code2 + code3 + code4 + code5 + code6)
        }
        return "000000"
    }
}
