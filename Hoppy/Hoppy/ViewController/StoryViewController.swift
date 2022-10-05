//
//  StoryViewController.swift
//  Hoppy
//
//  Created by Jaehyeok Lim on 2022/10/04.
//

import UIKit

class StoryViewController: UIViewController {
    
    var superViewUIViewList: [UIView] = []
    var scrollViewList: [UIView] = []
    var contentViewList: [UIView] = []

    private let storyViewScrollView: UIScrollView = {
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "취미 스토리"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
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
        label.layer.borderColor = UIColor.searchWindowColor?.cgColor

        return label
    }()
    
    private let contentViewHorizonLine: UILabel = {
        let label = UILabel()

        label.text = ""
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.darkGray.cgColor

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        superViewLayout()
        scrollViewLayout()
        contentViewLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    private func superViewLayout() {
        view.backgroundColor = UIColor.white

        superViewUIViewList = [backViewButton, horizonLine, storyViewScrollView]

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
    
    @objc func backViewButtonAction(_: UIButton) {
        dismiss(animated: true)
    }

    private func scrollViewLayout() {

        scrollViewList = [contentView]

        for uiView in scrollViewList {
            storyViewScrollView.addSubview(uiView)
        }

        storyViewScrollView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(115)
            make.leading.trailing.bottom.equalTo(0)
        }

        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(0)
            make.width.equalTo(storyViewScrollView)
            make.height.equalTo(900)
        }
    }

    private func contentViewLayout() {

        contentViewList = [titleLabel, contentViewHorizonLine]

        for uiView in contentViewList {
            contentView.addSubview(uiView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(40)
            make.leading.equalTo(contentView).offset(25)
        }
        
        contentViewHorizonLine.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalTo(contentView).offset(15)
            make.trailing.equalTo(contentView).offset(-15)
            make.height.equalTo(1)
        }
    }
}
