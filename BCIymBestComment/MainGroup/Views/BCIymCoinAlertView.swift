//
//  BCIymCoinAlertView.swift
//  BCIymBestComment
//
//  Created by Joe on 2021/12/30.
//

import UIKit


import UIKit

class BCIymCoinAlertView: UIView {
    
    var backBtnClickBlock: (()->Void)?
    var okBtnClickBlock: (()->Void)?
//    var editBtnClickBlock: ((String)->Void)?
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func backBtnClick(sender: UIButton) {
        backBtnClickBlock?()
    }
    
    func setupView() {
        backgroundColor = UIColor.clear
//        //
        var blurEffect = UIBlurEffect(style: .dark)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.frame
        addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
//
        //
        let bgBtn = UIButton(type: .custom)
        bgBtn
            .image(UIImage(named: ""))
            .adhere(toSuperview: self)
        bgBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        bgBtn.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        //
        let contentV = UIView()
            .backgroundColor(UIColor.black.withAlphaComponent(0.8))
            .adhere(toSuperview: self)
        contentV.layer.cornerRadius = 24
        contentV.layer.masksToBounds = true
//        contentV.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
//        contentV.layer.shadowOffset = CGSize(width: 0, height: 0)
//        contentV.layer.shadowRadius = 3
//        contentV.layer.shadowOpacity = 0.8
//        contentV.layer.borderWidth = 2
//        contentV.layer.borderColor = UIColor.black.cgColor
        contentV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalTo(60)
            $0.height.equalTo(214)
//            $0.height.equalTo((UIScreen.width - 60 * 2) * (214/256))
            $0.centerY.equalToSuperview()
        }
        
        //
         
        let coinImgV = UIImageView()
            .image("store_diamond_big")
            .contentMode(.scaleAspectFit)
            .adhere(toSuperview: self)
        coinImgV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(contentV.snp.top).offset(0)
            $0.width.equalTo(96)
            $0.height.equalTo(96)
        }
        
        //
        let titLab = UILabel()
        
            .text("It costs \(InCymCoinManagr.default.coinCostCount) coins to copy the text.")
            .textAlignment(.center)
            .numberOfLines(0)
            .fontName(18, "BodoniSvtyTwoITCTT-Book")
            .color(UIColor(hexString: "#FFFFFF")!)
            .adhere(toSuperview: contentV)
        
        titLab.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(coinImgV.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(28)
            $0.height.greaterThanOrEqualTo(55)
        }
        
        //
//        let contentBgImgV = UIImageView()
//        contentBgImgV.image("popup_pro")
//            .adhere(toSuperview: contentV)
//        contentBgImgV.snp.makeConstraints {
//            $0.left.right.top.bottom.equalToSuperview()
//        }
        
//        //
//
//        let titLab2 = UILabel()
//            .text("Using paid item will cost \(LPymCoinManagr.default.coinCostCount) coins.")
//            .textAlignment(.center)
//            .numberOfLines(0)
//            .fontName(16, "AvenirNext-Regular")
//            .color(UIColor(hexString: "#454D3D")!.withAlphaComponent(0.6))
//            .adhere(toSuperview: contentV)
//
//        titLab2.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(titLab.snp.bottom).offset(10)
//            $0.left.equalToSuperview().offset(50)
//            $0.height.greaterThanOrEqualTo(1)
//        }
        
        //AvenirNext-DemiBold
        
        ///
        //
        let backBtn = UIButton()
        backBtn
            .backgroundColor(UIColor(hexString: "#FFFFFF")!.withAlphaComponent(0.15))
            .titleColor(UIColor.white)
            .title("Cancel")
            .font(14, "Avenir-Light")
            .adhere(toSuperview: contentV)
        backBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(28)
            $0.top.equalTo(titLab.snp.bottom).offset(24)
            $0.right.equalTo(contentV.snp.centerX).offset(-6)
            $0.height.equalTo(40)
        }
        backBtn.layer.cornerRadius = 20
        backBtn.addTarget(self, action: #selector(backBtnClick(sender: )), for: .touchUpInside)
        
        //
        let okBtn = UIButton()
        okBtn.layer.cornerRadius = 20
        okBtn
            .backgroundColor(.white)
            .titleColor(UIColor(hexString: "#000000")!)
            .title("OK")
            .font(14, "Avenir-Light")
            .adhere(toSuperview: contentV)
        okBtn.snp.makeConstraints {
            $0.top.equalTo(backBtn.snp.top).offset(0)
            $0.right.equalToSuperview().offset(-28)
            $0.left.equalTo(contentV.snp.centerX).offset(6)
            $0.height.equalTo(40)
        }
        
        okBtn.addTarget(self, action: #selector(okBtnClick(sender:)), for: .touchUpInside)
        
        //
    }
    @objc func okBtnClick(sender: UIButton) {
        okBtnClickBlock?()
    }
    
//    @objc func editBtnClick(sender: UIButton) {
//        okBtnClickBlock?()
//    }
     
//    @objc func copyBtnClick(sender: UIButton) {
//        okBtnClickBlock?()
//    }
     
    
    
    
    
    
    
  }
