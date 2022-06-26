//
//  SignUpViewController.swift
//  SignUP
//
//  Created by 이예림 on 2022/06/25.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate{
    
    
    //이미지 선택하기
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        return picker
    }()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func imageViewTapped(_ sender: UITapGestureRecognizer) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //imageView 클릭 가능하도록 설정
        self.imageView.isUserInteractionEnabled = true
        
        //버튼 비활성화
        nextButton.isUserInteractionEnabled = false
        
        self.idField.delegate = self
        self.passwordField.delegate = self
        self.checkpasswordField.delegate = self
        self.textView.delegate = self
        
        textView.text = ""
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage : UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imageView.image = editedImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //키보드 내리기 + 싱글톤에 아이디 저장
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
        UserInformation.shared.id = idField.text
    }
    
    //취소 버튼
    @IBAction func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //조건에 따라 버튼 활성화 및 비활성화
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextButtonLayout(isOn:Bool) {
        switch isOn {
        case true:
            nextButton.isUserInteractionEnabled = true
            nextButton.setTitleColor(.blue, for: .normal)
            nextButton.setTitle("다음", for: .normal)
        case false:
            nextButton.isUserInteractionEnabled = false
            nextButton.setTitleColor(.gray, for: .normal)
            nextButton.setTitle("다음", for: .normal)
        }
    }
    
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var checkpasswordField: UITextField!
    @IBOutlet weak var textView: UITextView!

    
//    @IBAction func textFieldDidEndEditing(_ sender: UITextField) {
//        guard let str0 = self.idField?.text, ((self.idField?.text?.isEmpty) != nil) else { return }
//        guard let str1 = self.passwordField?.text, ((self.passwordField?.text?.isEmpty) != nil) else { return }
//        guard let str2 = self.checkpasswordField?.text, ((self.checkpasswordField?.text?.isEmpty) != nil) else { return }
//        if str0 != "", str1 != "", str1 == str2{
//            self.nextButtonLayout(isOn: true)
//        } else {
//            self.nextButtonLayout(isOn: false)
//        }
//    }
    
    
    internal func textFieldDidEndEditing(_ sender:UITextField) {
        guard let str0 = self.idField?.text, ((self.idField?.text?.isEmpty) != nil) else { return }
        guard let str1 = self.passwordField?.text, ((self.passwordField?.text?.isEmpty) != nil) else { return }
        guard let str2 = self.checkpasswordField?.text, ((self.checkpasswordField?.text?.isEmpty) != nil) else { return }
        if str0 != "", str1 != "", str1 == str2, textView.text != "" {
            self.nextButtonLayout(isOn: true)
        } else {
            self.nextButtonLayout(isOn: false)
        }
    }
    
    @objc func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty{
            textView.text=""
            self.nextButtonLayout(isOn: false)
        } else if idField.text != "", passwordField.text != "", checkpasswordField.text != ""{
            self.nextButtonLayout(isOn: true)
        }
    }

}
