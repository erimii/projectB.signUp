//
//  SecondSignUpViewController.swift
//  SignUP
//
//  Created by 이예림 on 2022/06/25.
//

import UIKit

class SecondSignUpViewController: UIViewController {
    
    //키보드 내리기
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //이전 버튼
    @IBAction func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //취소 버튼
    @IBAction func dismissAllModal() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    //생년월일 레이블 적용
    @IBOutlet weak var dateOfBirth: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker) {
        
        let date: Date = self.datePicker.date
        let dateString: String = self.dateFormatter.string(from: date)
        
        self.dateOfBirth.text = dateString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        let str = formatter.string(from: Date())
        dateOfBirth.text = "\(str)"
        
        //버튼 비활성화
        signUpButton.isUserInteractionEnabled = false
    }
    
    //전화번호 입력 시 가입 버튼 활성화
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    func signUpButtonLayout(isOn:Bool) {
        switch isOn {
        case true:
            signUpButton.isUserInteractionEnabled = true
            signUpButton.setTitleColor(.blue, for: .normal)
            signUpButton.setTitle("가입", for: .normal)
        case false:
            signUpButton.isUserInteractionEnabled = false
            signUpButton.setTitleColor(.gray, for: .normal)
            signUpButton.setTitle("가입", for: .normal)
        }
    }
    
    @IBAction func phoneNumberFieldDidEndEditing (_ sender: UITextField) {
        if sender.text?.isEmpty == true{
            self.signUpButtonLayout(isOn: false)
        } else {
            self.signUpButtonLayout(isOn: true)
        }
    }
    
    //가입 버튼
    @IBAction func finishSignUp() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
        //로그인 페이지로 이동하면 id text field에 아이디 넣고 싶은데 어떻게 하는지 모르곘다.
        UserInformation.shared.realId = UserInformation.shared.id
        print(UserInformation.shared.realId!)
    
    }

}
