//
//  StoryViewController.swift
//  Hoppy
//
//  Created by Jaehyeok Lim on 2022/10/04.
//

import UIKit
import MaterialComponents.MaterialButtons

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
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.backgroundColor = UIColor.contentViewBackgroundColor
        view.register(StoryViewCollectionCell.self, forCellWithReuseIdentifier: "StoryViewCollectionCell")
        
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
    
    private let writeStoryFloatingButton: MDCFloatingButton = {
        let button = MDCFloatingButton()
        
//        button.imageView?.image = UIImage(systemName: "plus")
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.hobbyCellBackgroundColor
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        superViewLayout()
        scrollViewLayout()
        contentViewLayout()
        
//        collectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        collectionView.reloadData()
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
            make.height.equalTo(700)
        }
    }

    private func contentViewLayout() {

        contentViewList = [titleLabel, contentViewHorizonLine, collectionView, writeStoryFloatingButton]

        for uiView in contentViewList {
            contentView.addSubview(uiView)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(15)
            make.leading.equalTo(contentView).offset(25)
        }
        
        contentViewHorizonLine.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalTo(contentView).offset(15)
            make.trailing.equalTo(contentView).offset(-15)
            make.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentViewHorizonLine).offset(30)
            make.width.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
        
        writeStoryFloatingButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-20)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        writeStoryFloatingButton.addTarget(self, action: #selector(writeStoryFloatingButtonAction), for: .touchUpInside)
    }
    
    @objc func writeStoryFloatingButtonAction() {
        let viewController = WriteStoryViewController()
        
        viewController.modalPresentationStyle = .fullScreen
        
        present(viewController, animated: true)
    }
}

extension StoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StoryDetailDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryViewCollectionCell", for: indexPath) as? StoryViewCollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.storyCellUsername.text = StoryDetailDataList[indexPath.row].username

        cell.storyCellCreatedDate.text = StoryDetailDataList[indexPath.row].createDate
        
        cell.storyCellTitleLabel.text = StoryDetailDataList[indexPath.row].title
        
        cell.storyCellMainTextLabel.text = StoryDetailDataList[indexPath.row].content
        
        if StoryDetailDataList[indexPath.row].profileUrl == "null" {
            cell.storyCellProfileImage.image = UIImage()
        } else {
            let url = URL(string: StoryDetailDataList[indexPath.row].profileUrl!)
            cell.storyCellProfileImage.load(url: url!)
        }
        
        if StoryDetailDataList[indexPath.row].filename != "" {
            let mainImageUrl = URL(string:  StoryDetailDataList[indexPath.row].filename!)
            cell.storyCellMainImage.load(url: (mainImageUrl!))
            cell.storyCellMainImage.backgroundColor = UIColor.black
            cell.storyCellMainImage.isHidden = false
        } else {
            cell.storyCellMainImage.image = UIImage()
            cell.storyCellMainImage.backgroundColor = UIColor.white
            cell.storyCellMainImage.isHidden = true
        }
        
        return cell
    }
}

extension StoryViewController: UICollectionViewDelegateFlowLayout {

    // 위 아래 간격
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
        ) -> CGFloat {
        return 15
    }

    // 옆 간격
    func collectionView(
      _ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      minimumInteritemSpacingForSectionAt section: Int
      ) -> CGFloat {
          return 0
      }

    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(
      _ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      sizeForItemAt indexPath: IndexPath
      ) -> CGSize {

          if StoryDetailDataList[indexPath.row].filename == "" {
              return CGSize(width: 370, height: 120)
          } else {
              return CGSize(width: 370, height: 500)
          }
    }
}


