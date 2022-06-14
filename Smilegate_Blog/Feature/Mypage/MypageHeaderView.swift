//
//  MypageHeaderView.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/11.
//

import UIKit

protocol MypageHeaderViewDelegate: AnyObject {
    func setUserInfo(_ headerView: MypageHeaderView, info: User)
}


class MypageHeaderView: UIView {
    // MARK: - Properties
    weak var delegate: MypageHeaderViewDelegate?
    
    var viewModel: UserViewModel? {
        didSet { updateUI() }
    }
    
    let mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "img_main")
        return iv
    }()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "ic_user-1")
        return iv
    }()
    
    let introduceView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "열정 블로그"
        label.font = UIFont.ndFont(type: .bold38)
        label.textColor = .white
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Heegee Park"
        label.font = UIFont.ndFont(type: .bold16)
        label.textColor = .white
        return label
    }()
    
    let introLabel: UILabel = {
        let label = UILabel()
        label.text = "소개 📝"
        label.font = UIFont.ndFont(type: .bold17)
        label.textColor = .textBlackColor
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "안녕하세요 :)"
        label.font = UIFont.ndFont(type: .regular14)
        label.textColor = .ligthGrayColor
        return label
    }()
    
    lazy var settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "btn_setting"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func settingButtonTapped(sender: UIButton) {
        self.delegate?.setUserInfo(self, info: viewModel!.user!)
    }
    
    // MARK: - Methods
    fileprivate func initUI() {
        let view = UIView()
        
        mainImageView.addSubview(profileImageView)
        mainImageView.addSubview(titleLabel)
        mainImageView.addSubview(nameLabel)
        mainImageView.addSubview(settingButton)
        view.addSubview(mainImageView)
        
        introduceView.addSubview(introLabel)
        introduceView.addSubview(detailLabel)
        view.addSubview(introduceView)
        addSubview(view)
        
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        introLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        introduceView.translatesAutoresizingMaskIntoConstraints = false
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            mainImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            mainImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -65),
            mainImageView.heightAnchor.constraint(equalToConstant: 240),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.heightAnchor.constraint(equalToConstant: 45),
            
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48),
            profileImageView.centerXAnchor.constraint(equalTo: mainImageView.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 9),
            nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            
            settingButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 9),
            settingButton.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            settingButton.widthAnchor.constraint(equalToConstant: 86),
            settingButton.heightAnchor.constraint(equalToConstant: 35),
            
            introduceView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            introduceView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            introduceView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor),
            introduceView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            introduceView.heightAnchor.constraint(equalToConstant: 200),
            
            introLabel.topAnchor.constraint(equalTo: introduceView.topAnchor, constant: 5),
            introLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            introLabel.widthAnchor.constraint(equalToConstant: 86),
            introLabel.heightAnchor.constraint(equalToConstant: 35),
            
            detailLabel.topAnchor.constraint(equalTo: introLabel.bottomAnchor, constant: 3),
            detailLabel.leadingAnchor.constraint(equalTo: introLabel.leadingAnchor),
            detailLabel.widthAnchor.constraint(equalToConstant: 200),
            detailLabel.heightAnchor.constraint(equalToConstant: 17)
        ])
//        settingButton.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
    }
    
    fileprivate func updateUI() {
        guard let userInfo = viewModel else { return }
        nameLabel.text = userInfo.name
        titleLabel.text = userInfo.title
        detailLabel.text = userInfo.introduce
    }
}
