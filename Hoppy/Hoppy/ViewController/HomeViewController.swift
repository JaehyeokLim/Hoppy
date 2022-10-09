//
//  ViewController.swift
//  Hoppy
//
//  Created by Jaehyeok Lim on 2022/09/01.
//

public extension UIColor {
    static let homeViewBackgroundColor = UIColor(named: "homeViewBackgroundColor")
    static let homeViewCommonTextColor = UIColor(named: "homeViewCommonTextColor")
    static let homeViewTextColor = UIColor(named: "homeViewTextColor")
    static let searchWindowColor = UIColor(named: "SearchWindowColor")
    static let horizonLineColor = UIColor(named: "HorizonLineColor")
    static let alarmButtonColor = UIColor(named: "AlarmButtonColor")
    static let sideMenuButtonColor = UIColor(named: "SideMenuButtonColor")
    static let hobbyCellBorderColor = UIColor(named: "HobbyCellBorderColor")
    static let magnifyingglassButtonColor = UIColor(named: "MagnifyingglassButtonColor")
    static let scrollViewbackgroundColor = UIColor(named: "ScrollViewbackgroundColor")
    static let hobbyCellBackgroundColor = UIColor(named: "HobbyCellBackgroundColor")
    static let hobbyCellInsideTextColor = UIColor(named: "HobbyCellInsideTextColor")
    static let hobbyCellInsideButtonColor = UIColor(named: "HobbyCellInsideButtonColor")
    static let contentViewBackgroundColor = UIColor(named: "ContentVIewBackgroundColor")
}

public var logoImageList: [UIImage] = []
public var logoTitleList: [String] = ["운동", "공예", "음악", "일상", "음식", "일상"]

import UIKit
import SnapKit
import SideMenu

class HomeViewController: UIViewController {
    
    var superViewList: [UIView] = []
    var scrollViewList: [UIView] = []
    var contentViewList: [UIView] = []
    
    let homeViewSearchTextFieldBox: UIButton = {
        let box = UIButton()
        
        box.layer.borderWidth = 1
        box.layer.borderColor = UIColor.homeViewBackgroundColor?.cgColor
        box.backgroundColor = UIColor.homeViewBackgroundColor
        box.layer.cornerRadius = 20
        
        return box
    }()
    
    let homeViewlogoImageButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "HoppyLogoImage"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    let homeViewSideMenuImageButton: UIButton = {
        let button = UIButton()
        
//        button.setImage(UIImage(named: "SideMenuLogoImage"), for: .normal)
        button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.layer.borderWidth = 1
        button.tintColor = UIColor.alarmButtonColor
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 5
//        button.tintColor = UIColor.white
        
        return button
    }()
    
    let homeViewAlramImageButton: UIButton = {
        let button = UIButton()
        
//        button.setImage(UIImage(named: "AlramImage"), for: .normal)
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = UIColor.alarmButtonColor
//        button.tintColor = UIColor.white
        
        return button
    }()
    
    private let homeViewScrollView: UIScrollView = {
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
    
    private let homeViewSearchTextField: UITextField = {
        let textField = UITextField()
        
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.searchWindowColor?.cgColor
        textField.layer.cornerRadius = 4
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.contentViewBackgroundColor
        textField.placeholder = "찾으시는 취미를 검색해보세요!"
        
        return textField
    }()
    
    private let magnifyingGlassButton: UIButton = {
        let button = UIButton()
            
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = UIColor.magnifyingglassButtonColor
        
        return button
    }()
    
    private let homeViewCategoryLabel: UILabel = {
        let label = UILabel()
        
        label.text = "취미 카테고리"
        label.textColor = UIColor.homeViewTextColor
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    private let homeViewCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        return collectionView
    }()
    
    private let sideMenuNavigationController: SideMenuNavigationController = {
        let sideMenu = SideMenuNavigationController(rootViewController: SideMenuViewController())
       
        sideMenu.leftSide = true
        sideMenu.presentationStyle = .menuSlideIn
        
        return sideMenu
    }()
    
    private let horizonLine: UILabel = {
        let label = UILabel()
        
        label.text = ""
        label.layer.borderWidth = 1
//        label.layer.borderColor = UIColor.horizonLineColor?.cgColor
        label.layer.borderColor = UIColor.searchWindowColor?.cgColor
        
        return label
    }()
    
    private let homeViewCreateGatheringLabel: UILabel = {
        let label = UILabel()
        
        label.text = "취미를 함께 할 사람들을 찾아보세요"
        label.textColor = UIColor.homeViewTextColor
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    private let homeViewHobbyStoryLabel: UILabel = {
        let label = UILabel()
        
        label.text = "취미를 기록하고 공유해보세요"
        label.textColor = UIColor.homeViewTextColor
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    private let homeViewCreateGatheringCell: UILabel = {
        let cell = UILabel()
        
        cell.text = ""
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.hobbyCellBorderColor?.cgColor
        cell.layer.cornerRadius = 10
        
        return cell
    }()
    
    private let homeViewHobbyStoryCell: UILabel = {
        let cell = UILabel()
        
        cell.text = ""
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.hobbyCellBorderColor?.cgColor
        cell.layer.cornerRadius = 10
        
        return cell
    }()
    
    private let homeViewCreateGatheringCellInsideLabel: UILabel = {
        let label = UILabel()
        
        label.text = "취미 모임"
        label.textColor = UIColor.hobbyCellInsideTextColor
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    private let homeViewHobbyStoryCellInsideLabel: UILabel = {
        let label = UILabel()
        
        label.text = "일상을 기록하는"
        label.textColor = UIColor.hobbyCellInsideTextColor
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    private let homeViewCreateGatheringCellInsideButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("모임 만들기", for: .normal)
        button.backgroundColor = UIColor.hobbyCellInsideButtonColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.titleLabel?.textColor = UIColor.darkGray
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.hobbyCellInsideButtonColor?.cgColor
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    private let homeViewHobbyStoryCellInsideButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("취미 스토리", for: .normal)
        button.backgroundColor = UIColor.hobbyCellInsideButtonColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.titleLabel?.textColor = UIColor.darkGray
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.hobbyCellInsideButtonColor?.cgColor
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    private let homeViewCreateGatheringCellInsideImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "CreateGatheringCellImage")
        
        return imageView
    }()
    
    private let homeViewHobbyStoryCellInsideImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "HobbyStoryCellImage")
        
        return imageView
    }()
    
    private let copylightSymbol: UIImageView = {
        let imageView = UIImageView()
       
        imageView.image = UIImage(systemName: "c.circle")
        imageView.tintColor = UIColor.black
        
        return imageView
    }()
    
    private let copylightLabel: UILabel = {
        let label = UILabel()
        
        label.text = "hoppy Project"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        homeViewSearchTextField.delegate = self
        
        HomeViewLayout()
        ScrollViewLayout()
        ContentViewLayout()
        CollectionViewLayout()
    }
    
    private func HomeViewLayout() {
        view.backgroundColor = UIColor.white
        
        superViewList = [homeViewlogoImageButton, homeViewSideMenuImageButton, homeViewAlramImageButton, homeViewScrollView, horizonLine]
        
        for listName in superViewList {
            view.addSubview(listName)
        }
        
        homeViewlogoImageButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(35)
            make.leading.equalTo(view).offset(112)
            make.size.equalTo(CGSize(width: 170, height: 90))
        }
        
        homeViewSideMenuImageButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(68)
            make.leading.equalTo(view).offset(20)
//            make.size.equalTo(CGSize(width: 35, height: 35))
            make.size.equalTo(CGSize(width: 35, height: 28))
        }
        
        homeViewAlramImageButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(63.5)
            make.trailing.equalTo(view).offset(-20)
            make.size.equalTo(CGSize(width: 33, height: 33))
        }
        
        horizonLine.snp.makeConstraints { make in
            make.top.equalTo(view).offset(114)
            make.width.equalTo(view)
            make.height.equalTo(1)
        }
        
        homeViewSideMenuImageButton.addTarget(self, action: #selector(homeViewCategoryImageButtonAction), for: .touchUpInside)
    }
    
    @objc private func homeViewCategoryImageButtonAction(_: UIButton) {
        present(sideMenuNavigationController, animated: true, completion: nil)
        print("hello")
    }
    
    private func ScrollViewLayout() {
        scrollViewList = [contentView]
        
        for listName in scrollViewList {
            homeViewScrollView.addSubview(listName)
        }
        
        homeViewScrollView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(115)
            make.leading.trailing.bottom.equalTo(0)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(0)
            make.width.equalTo(homeViewScrollView)
            make.height.equalTo(900)
//            contentView.snp.contentHuggingVerticalPriority = 250
//            contentView.snp.contentHuggingVerticalPriority = 250
        }
    }
    
    private func ContentViewLayout() {
        contentView.backgroundColor = UIColor.contentViewBackgroundColor

        contentViewList = [homeViewCategoryLabel, homeViewCollectionView, homeViewCreateGatheringLabel, homeViewCreateGatheringCell, homeViewHobbyStoryLabel, homeViewHobbyStoryCell, homeViewCreateGatheringCellInsideLabel, homeViewHobbyStoryCellInsideLabel, homeViewCreateGatheringCellInsideButton, homeViewHobbyStoryCellInsideButton, homeViewCreateGatheringCellInsideImage, homeViewHobbyStoryCellInsideImage, copylightSymbol, copylightLabel]
        
        for listName in contentViewList {
            contentView.addSubview(listName)
        }
        
        contentView.insertSubview(homeViewSearchTextFieldBox, at: 0)
        contentView.insertSubview(homeViewSearchTextField, at: 1)
        contentView.insertSubview(magnifyingGlassButton, at: 2)
        
//        homeViewSearchTextFieldBox.snp.makeConstraints { make in
//            make.top.equalTo(contentView).offset(-1045)
//            make.width.equalTo(contentView)
//            make.height.equalTo(1100)
//
//        }

        homeViewSearchTextField.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(30)
            make.leading.equalTo(contentView).offset(15)
            make.size.equalTo(CGSize(width: 360, height: 40))
        }
        
        homeViewCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(homeViewSearchTextField.snp.bottom).offset(30)
            make.leading.equalTo(homeViewSearchTextField).offset(10)
        }
        
        magnifyingGlassButton.snp.makeConstraints { make in
            make.top.equalTo(homeViewSearchTextField).offset(9.5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-23)
            make.size.equalTo(CGSize(width: 22, height: 20))
        }
    
        homeViewCreateGatheringLabel.snp.makeConstraints { make in
            make.top.equalTo(homeViewCollectionView.snp.bottom).offset(40)
            make.leading.equalTo(homeViewCategoryLabel)
        }
        
        homeViewCreateGatheringCell.snp.makeConstraints { make in
            make.top.equalTo(homeViewCreateGatheringLabel.snp.bottom).offset(20)
            make.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).offset(-20)
//            make.size.equalTo(CGSize(width: 300, height: 200))
            make.height.equalTo(140)
        }
        
        homeViewHobbyStoryLabel.snp.makeConstraints { make in
            make.top.equalTo(homeViewCreateGatheringCell.snp.bottom).offset(40)
            make.leading.equalTo(homeViewCategoryLabel)
        }
        
        homeViewHobbyStoryCell.snp.makeConstraints { make in
            make.top.equalTo(homeViewHobbyStoryLabel.snp.bottom).offset(20)
            make.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).offset(-20)
//            make.size.equalTo(CGSize(width: 300, height: 200))
            make.height.equalTo(140)
        }
        
        homeViewCreateGatheringCellInsideLabel.snp.makeConstraints { make in
            make.top.equalTo(homeViewCreateGatheringCell).offset(33)
            make.leading.equalTo(homeViewCreateGatheringCell).offset(70)
        }
        
        homeViewHobbyStoryCellInsideLabel.snp.makeConstraints { make in
            make.top.equalTo(homeViewHobbyStoryCell).offset(33)
            make.leading.equalTo(homeViewHobbyStoryCell).offset(44)
        }
        
        homeViewCreateGatheringCellInsideButton.snp.makeConstraints { make in
            make.top.equalTo(homeViewCreateGatheringCellInsideLabel.snp.bottom).offset(10)
            make.leading.equalTo(homeViewCreateGatheringCell).offset(40)
            make.width.equalTo(130)
            make.height.equalTo(40)
        }
        
        homeViewHobbyStoryCellInsideButton.snp.makeConstraints { make in
            make.top.equalTo(homeViewHobbyStoryCellInsideLabel.snp.bottom).offset(10)
            make.leading.equalTo(homeViewHobbyStoryCell).offset(40)
            make.width.equalTo(130)
            make.height.equalTo(40)
        }
        
        homeViewCreateGatheringCellInsideImage.snp.makeConstraints { make in
            make.top.equalTo(homeViewCreateGatheringCell).offset(6)
            make.leading.equalTo(homeViewCreateGatheringCellInsideButton.snp.trailing).offset(35)
            make.size.equalTo(CGSize(width: 130, height: 130))
        }
        
        homeViewHobbyStoryCellInsideImage.snp.makeConstraints { make in
            make.top.equalTo(homeViewHobbyStoryCell).offset(12)
            make.leading.equalTo(homeViewHobbyStoryCellInsideButton.snp.trailing).offset(40)
            make.size.equalTo(CGSize(width: 115, height: 115))
        }
        
        copylightSymbol.snp.makeConstraints { make in
            make.bottom.equalTo(contentView)
            make.leading.equalTo(contentView).offset(135)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        copylightLabel.snp.makeConstraints { make in
            make.bottom.equalTo(copylightSymbol).offset(-0.5)
            make.leading.equalTo(copylightSymbol.snp.trailing).offset(2)
        }
        
        homeViewCreateGatheringCellInsideButton.addTarget(self, action: #selector(createMeetingButtonAction), for: .touchUpInside)
        homeViewHobbyStoryCellInsideButton.addTarget(self, action: #selector(showStoryViewButtonAction), for: .touchUpInside)
    }
    
    @objc func createMeetingButtonAction() {
        let viewController = CreateMeetingViewController()
 
        let nav = UINavigationController(rootViewController: viewController)
        
        nav.modalPresentationStyle = .pageSheet

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .medium()]
        }

        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func showStoryViewButtonAction() {
        let viewController = StoryViewController()
 
        viewController.modalPresentationStyle = .fullScreen
//        viewController.modalTransitionStyle = .crossDissolve

        self.present(viewController, animated: true, completion: nil)
    }
    
    private func CollectionViewLayout() {
        homeViewCollectionView.backgroundColor = UIColor.contentViewBackgroundColor
        
        self.homeViewCollectionView.dataSource = self
        self.homeViewCollectionView.delegate = self
        
        self.homeViewCollectionView.register(HomeViewCollectionCell.self, forCellWithReuseIdentifier: "HomeViewCollectionCell")

        homeViewCollectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(120)
            make.leading.equalTo(contentView)
            make.right.equalTo(contentView)
            make.bottom.equalTo(contentView.snp.top).offset(398)
        }
        
        logoImageList.append(UIImage(named: "ExerciseLogoImage")!)
        logoImageList.append(UIImage(named: "CraftsLogoImage")!)
        logoImageList.append(UIImage(named: "MusicLogoImage")!)
        logoImageList.append(UIImage(named: "DailyLogoImage")!)
        logoImageList.append(UIImage(named: "FoodLogoImage")!)
        logoImageList.append(UIImage(named: "TripLogoImage")!)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return logoImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCollectionCell", for: indexPath) as? HomeViewCollectionCell else { return UICollectionViewCell() }
        
        cell.userViewImage.image = logoImageList[indexPath.row]
        cell.userViewTitle.text = logoTitleList[indexPath.row]
        
        return cell
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {

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

//extension UIView {
//    func setViewShadow(backView: UIView) {
//        backView.layer.masksToBounds = true
//        backView.layer.cornerRadius = 10
//        backView.layer.borderWidth = 1
//
//        layer.masksToBounds = false
//        layer.shadowOpacity = 0.8
//        layer.shadowOffset = CGSize(width: -2, height: 2)
//        layer.shadowRadius = 3
//    }
//}

extension HomeViewController: SideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        self.view.mask = UIView(frame: view.frame)
        self.view.mask?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        print("SideMenu Appearing! (animated: \(animated))")
    }

    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }

    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        self.view.mask = UIView(frame: view.frame)
        self.view.mask?.backgroundColor = UIColor.black.withAlphaComponent(1)
        print("SideMenu Disappearing! (animated: \(animated))")
    }

    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
}

extension HomeViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.contentView.endEditing(true)
        self.homeViewScrollView.endEditing(true)
    }
}

