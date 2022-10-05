//
//  WriteMeetingProfileViewController.swift
//  Hoppy
//
//  Created by Jaehyeok Lim on 2022/10/04.
//

import UIKit
import SnapKit

public extension UIColor {
    static let textFieldBorderColor = UIColor(named: "TextFieldBorderColor")
    static let textFieldBackgroundColor = UIColor(named: "TextFieldBackgroundColor")
}

class WriteMeetingProfileViewController: UIViewController {
    
    var superViewUIViewList: [UIView] = []
    var scrollViewList: [UIView] = []
    var contentViewList: [UIView] = []
    
    private let writeMeetingProfileViewScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.backgroundColor = UIColor.contentViewBackgroundColor
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false

        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.contentViewBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let backViewButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = UIColor.alarmButtonColor
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    private let horizonLine: UILabel = {
        let label = UILabel()
        
        label.text = ""
        label.layer.borderWidth = 1
//        label.layer.borderColor = UIColor.horizonLineColor?.cgColor
        label.layer.borderColor = UIColor.searchWindowColor?.cgColor
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "취미 모임 만들기"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        
//        imageView.image = logoImageList[selectedItemNumber!]
        
        return imageView
    }()
    
    private let categoryTitleTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "모임의 이름을 입력해주세요"
        textField.textColor = UIColor.black
        textField.backgroundColor = UIColor.textFieldBackgroundColor
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.layer.borderColor = UIColor.textFieldBorderColor?.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.2
//        textView.textContainerInset = UIEdgeInsets(top: 16, left: 18, bottom: 16, right: 18)
        textField.addLeftPadding()
        
        return textField
    }()
    
    private let maximumPersonTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "정원을 입력해주세요."
        textField.textColor = UIColor.black
        textField.backgroundColor = UIColor.textFieldBackgroundColor
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.layer.borderColor = UIColor.textFieldBorderColor?.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.2
//        textView.textContainerInset = UIEdgeInsets(top: 16, left: 18, bottom: 16, right: 18)
        textField.addLeftPadding()
        
        return textField
    }()
    
    private let mainTextView: UITextView = {
        let textView = UITextView()
        
        textView.textColor = UIColor.black
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.backgroundColor = UIColor.textFieldBackgroundColor
        textView.layer.borderColor = UIColor.textFieldBorderColor?.cgColor
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1.2
        
        return textView
    }()
    private let mainImageAppendButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("대표 사진 등록하기", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.borderColor = UIColor.textFieldBorderColor?.cgColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.2
        
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("글 올리기", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.borderColor = UIColor.textFieldBorderColor?.cgColor
        button.backgroundColor = UIColor.hobbyCellInsideButtonColor
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1.2
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        superViewLayout()
        scrollViewLayout()
        contentViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        categoryImageView.image = logoImageList[selectedItemNumber]
    }
    
    private func superViewLayout() {
        view.backgroundColor = UIColor.white
        
        superViewUIViewList = [backViewButton, horizonLine, writeMeetingProfileViewScrollView]
        
        for uiView in superViewUIViewList {
            view.addSubview(uiView)
        }
        
        backViewButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(70)
            make.leading.equalTo(view).offset(25)
            make.size.equalTo(CGSize(width: 25, height: 30))
        }
        
        horizonLine.snp.makeConstraints { make in
            make.top.equalTo(view).offset(114)
            make.width.equalTo(view)
            make.height.equalTo(1)
        }

        backViewButton.addTarget(self, action: #selector(backViewButtonAction), for: .touchUpInside)
    }
    
    private func scrollViewLayout() {
        
        scrollViewList = [contentView]
        
        for uiView in scrollViewList {
            writeMeetingProfileViewScrollView.addSubview(uiView)
        }
        
        writeMeetingProfileViewScrollView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(115)
            make.leading.trailing.bottom.equalTo(0)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(0)
            make.width.equalTo(writeMeetingProfileViewScrollView)
            make.height.equalTo(900)
        }
    }
    
    private func contentViewLayout() {
        
        contentViewList = [titleLabel, categoryImageView, categoryTitleTextField, maximumPersonTextField, mainImageAppendButton, mainTextView, saveButton]
        
        for uiView in contentViewList {
            contentView.addSubview(uiView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(40)
            make.leading.equalTo(contentView).offset(25)
        }
        
        categoryImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalTo(titleLabel)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        
        categoryTitleTextField.snp.makeConstraints { make in
            make.top.equalTo(categoryImageView)
            make.leading.equalTo(categoryImageView.snp.trailing).offset(15)
            make.trailing.equalTo(-15)
            make.height.equalTo(45)
        }
        
        maximumPersonTextField.snp.makeConstraints { make in
            make.top.equalTo(categoryTitleTextField.snp.bottom).offset(15)
            make.leading.equalTo(contentView).offset(15)
            make.trailing.equalTo(-15)
            make.height.equalTo(45)
        }
        
        mainImageAppendButton.snp.makeConstraints{ make in
            make.top.equalTo(maximumPersonTextField.snp.bottom).offset(15)
            make.leading.equalTo(contentView).offset(15)
            make.trailing.equalTo(-15)
            make.height.equalTo(45)
        }
        
        mainTextView.snp.makeConstraints{ make in
            make.top.equalTo(mainImageAppendButton.snp.bottom).offset(15)
            make.leading.equalTo(contentView).offset(15)
            make.trailing.equalTo(-15)
            make.height.equalTo(300)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(mainTextView.snp.bottom).offset(35)
            make.leading.equalTo(contentView).offset(130)
            make.trailing.equalTo(-130)
            make.height.equalTo(45)
        }
    }
    
    @objc func backViewButtonAction(_: UIButton) {
        dismiss(animated: true)
    }
}

extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
