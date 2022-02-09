//
//  BCIymEditVC.swift
//  BCIymBestComment
//
//  Created by Joe on 2021/12/30.
//

import UIKit
import ZKProgressHUD

class BCIymEditVC: UIViewController {
    var contentStr: String
    let textInputV = UITextView()
    
    
    init(contentStr: String) {
        self.contentStr = contentStr
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        view.backgroundColor(.white)
        let bgImgV = UIImageView()
        bgImgV.image("all_bg")
            .contentMode(.scaleAspectFill)
            .adhere(toSuperview: view)
        bgImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        //
        let backBtn = UIButton()
        view.addSubview(backBtn)
        backBtn.setImage(UIImage(named: "all_arrow_left"), for: .normal)
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.equalTo(10)
            $0.width.height.equalTo(44)
        }
        backBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        
        //
        
        let bgContentV = UIView()
        bgContentV.backgroundColor(UIColor.white.withAlphaComponent(0.15))
            .adhere(toSuperview: view)
        bgContentV.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.top.equalTo(backBtn.snp.bottom).offset(10)
            $0.height.equalTo(270)
        }
        bgContentV.layer.cornerRadius = 16
        bgContentV.layer.masksToBounds = true
        //
        
//        textInputV.delegate = self
        textInputV.text = contentStr
        textInputV.backgroundColor(.clear)
        textInputV.textColor = UIColor.white
//        textInputV.font = UIFont.systemFont(ofSize: 22)
        textInputV.font = UIFont(name: "BodoniSvtyTwoITCTT-Book", size: 18)
        textInputV.adhere(toSuperview: bgContentV)
        textInputV.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(24)
            $0.center.equalToSuperview()
        }
        textInputV.becomeFirstResponder()
        
        //
        let copyBtn = UIButton()
        copyBtn.adhere(toSuperview: view)
            .backgroundImage(UIImage(named: "all_btn"))
            .title("Copy")
            .titleColor(.white)
            .font(14, "Avenir-Light")
        copyBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bgContentV.snp.bottom).offset(16)
            $0.width.equalTo(96)
            $0.height.equalTo(40)
        }
        copyBtn.addTarget(self, action: #selector(copyBtnClick(sender: )), for: .touchUpInside)
        
        
    }
    
    
    

}

extension BCIymEditVC {
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController == nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController()
        }
        textInputV.resignFirstResponder()
    }
    
    @objc func copyBtnClick(sender: UIButton) {
        copyAction()
    }

    func copyAction() {
        UIPasteboard.general.string = textInputV.text
        ZKProgressHUD.showSuccess("Copy successfully!", maskStyle: nil, onlyOnceFont: nil, autoDismissDelay: 1.5, completion: nil)
    }
}



