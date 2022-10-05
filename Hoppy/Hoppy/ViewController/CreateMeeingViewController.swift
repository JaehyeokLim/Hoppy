//
//  CreateMeeingViewController.swift
//  Hoppy
//
//  Created by Jaehyeok Lim on 2022/09/29.
//

import UIKit
import SnapKit

public var selectedItemNumber: Int = 0

class CreateMeetingViewController: UIViewController {
    
    var superViewUIList: [UIView] = []
    
    private let CreateMeetingViewCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        return collectionView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text  = "모임 카테고리 선택"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text  = "만드시려는 모임에 해당하는 카테고리를 하나 선택해주세요."
        label.textColor = UIColor.alarmButtonColor
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        superViewLayout()
        CollectionViewLayout()
    }
    
    private func superViewLayout() {
        view.backgroundColor = .white
        
        superViewUIList = [CreateMeetingViewCollectionView, titleLabel, subTitleLabel]
        
        for uiView in superViewUIList {
            view.addSubview(uiView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(40)
            make.leading.equalTo(view).offset(25)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalTo(titleLabel)
        }
    }
    
    private func CollectionViewLayout() {
        CreateMeetingViewCollectionView.backgroundColor = UIColor.scrollViewbackgroundColor
        
        self.CreateMeetingViewCollectionView.dataSource = self
        self.CreateMeetingViewCollectionView.delegate = self
        
        self.CreateMeetingViewCollectionView.register(CreateMeetingViewCollectionCell.self, forCellWithReuseIdentifier: "CreateMeetingViewCollectionCell")

        CreateMeetingViewCollectionView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view.snp.top).offset(440)
        }
    }
}


extension CreateMeetingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return logoImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreateMeetingViewCollectionCell", for: indexPath) as? CreateMeetingViewCollectionCell else { return UICollectionViewCell() }
        
        cell.userViewImage.setImage(logoImageList[indexPath.row], for: .normal)
        cell.userViewTitle.text = logoTitleList[indexPath.row]
        
        return cell
    }
    
    @objc func selectedItemAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: CreateMeetingViewCollectionView)
        guard let indexPath = CreateMeetingViewCollectionView.indexPathForItem(at: point) else { return }
        let viewController = WriteMeetingProfileViewController()

        print(indexPath.row)
                
        dismiss(animated: true)
        
        guard let showViewController = self.presentingViewController else { return }

        self.dismiss(animated: true) {
            viewController.modalPresentationStyle = .fullScreen
            showViewController.present(viewController, animated: true, completion: nil)
            
            selectedItemNumber = indexPath.row
        }
    }
}


extension CreateMeetingViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {

            let interval:CGFloat = 3
            let width: CGFloat = ( UIScreen.main.bounds.width - interval * 2 ) / 3
            return CGSize(width: width-20 , height: width-20 )
    }

    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 15
    }

    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 18, left: 18, bottom: 0, right: 18)
    }
}
