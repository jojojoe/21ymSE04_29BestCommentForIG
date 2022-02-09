//
//  BCIymMainVC.swift
//  BCIymBestComment
//
//  Created by Joe on 2021/12/30.
//

import UIKit
import SnapKit

class BCIymMainVC: UIViewController {

    let commentBtn = UIButton()
    
    let captionBtn = UIButton()
    
    let comboBtn = UIButton()
    
    let settingBtn = UIButton()
    
    let storeBtn = UIButton()
    
    let commentLabel = UILabel()
    let commentLabel2 = UILabel()
    let captionLabel = UILabel()
    let captionLabel2 = UILabel()
    let comboLabel = UILabel()
    let comboLabel2 = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AFlyerLibManage.event_LaunchApp()
        setupView()
        
    }
    

    func setupView() {
        view.backgroundColor(.white)
        let commentBgV = UIView()
        commentBgV.adhere(toSuperview: view)
        commentBgV.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(UIScreen.height / 3)
        }
        //
        let commentImgV = UIImageView()
        commentImgV.image("homepage_img1")
            .contentMode(.scaleAspectFill)
            .clipsToBounds()
            .adhere(toSuperview: commentBgV)
        commentImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        //
        commentBtn.addTarget(self, action: #selector(commentBtnClick(sender: )), for: .touchUpInside)
        commentBtn.adhere(toSuperview: commentBgV)
        commentBtn.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        //
        
        commentLabel.fontName(22, "BodoniSvtyTwoITCTT-Book")
            .color(.white)
            .text("Best Comment for IG")
            .textAlignment(.center)
            .adhere(toSuperview: commentBgV)
        commentLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(commentBgV.snp.centerY)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        commentLabel2.fontName(14, "Avenir-Light")
            .color(.white)
            .text("- Most Popular -")
            .textAlignment(.center)
            .adhere(toSuperview: commentBgV)
        commentLabel2.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(commentBgV.snp.centerY)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        //
        let captionBgV = UIView()
        captionBgV.adhere(toSuperview: view)
        captionBgV.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(commentBgV.snp.bottom)
            $0.height.equalTo(UIScreen.height / 3)
        }
        //
        let captionImgV = UIImageView()
        captionImgV.image("homepage_img2")
            .clipsToBounds()
            .contentMode(.scaleAspectFill)
            .adhere(toSuperview: captionBgV)
        captionImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        //
        captionBtn.addTarget(self, action: #selector(captionBtnClick(sender: )), for: .touchUpInside)
        captionBtn.adhere(toSuperview: captionBgV)
        captionBtn.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        //
        
        captionLabel.fontName(22, "BodoniSvtyTwoITCTT-Book")
            .color(.white)
            .text("Hottest Caption for IG")
            .adhere(toSuperview: captionBgV)
            .textAlignment(.center)
        captionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(captionBgV.snp.centerY)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        captionLabel2.fontName(14, "Avenir-Light")
            .color(.white)
            .text("- Best Caption -")
            .adhere(toSuperview: captionBgV)
            .textAlignment(.center)
        captionLabel2.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(captionBgV.snp.centerY)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        //
        let comboBgV = UIView()
        comboBgV.adhere(toSuperview: view)
        comboBgV.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalTo(view.snp.centerX)
            $0.top.equalTo(captionBgV.snp.bottom)
            $0.height.equalTo(UIScreen.height / 3)
        }
        //
        let comboImgV = UIImageView()
        comboImgV.image("homepage_img3")
            .clipsToBounds()
            .contentMode(.scaleAspectFill)
            .adhere(toSuperview: comboBgV)
        comboImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        //
        comboBtn.addTarget(self, action: #selector(comboBtnClick(sender: )), for: .touchUpInside)
        comboBtn.adhere(toSuperview: comboBgV)
        comboBtn.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        //
        
        comboLabel.fontName(22, "BodoniSvtyTwoITCTT-Book")
            .color(.white)
            .numberOfLines(2)
            .textAlignment(.center)
            .text("Popularity Emoji Combo")
            .adhere(toSuperview: comboBgV)
        comboLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(comboBgV.snp.centerY)
            $0.height.greaterThanOrEqualTo(1)
            $0.left.equalTo(44)
        }
        
        comboLabel2.fontName(14, "Avenir-Light")
            .color(.white)
            .numberOfLines(2)
            .textAlignment(.center)
            .text("- The Hottest -")
            .adhere(toSuperview: comboBgV)
        comboLabel2.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(comboBgV.snp.centerY)
            $0.height.greaterThanOrEqualTo(1)
            $0.left.equalTo(44)
        }
        
        //
        let settingBgV = UIView()
        settingBgV.adhere(toSuperview: view)
        settingBgV.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.left.equalTo(view.snp.centerX)
            $0.top.equalTo(captionBgV.snp.bottom)
            $0.height.equalTo(UIScreen.height / 3 / 2)
        }
        //
        let settingImgV = UIImageView()
        settingImgV.image("homepage_img4")
            .clipsToBounds()
            .contentMode(.scaleAspectFill)
            .adhere(toSuperview: settingBgV)
        settingImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        //
        settingBtn.addTarget(self, action: #selector(settingBtnClick(sender: )), for: .touchUpInside)
        settingBtn.adhere(toSuperview: settingBgV)
        settingBtn.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        //
        let settingLabel = UILabel()
        settingLabel.fontName(22, "BodoniSvtyTwoITCTT-Book")
            .color(.white)
            .numberOfLines(2)
            .text("Setting")
            .textAlignment(.center)
            .adhere(toSuperview: settingBgV)
        settingLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(settingBgV.snp.centerY)
            $0.height.greaterThanOrEqualTo(1)
            $0.left.equalTo(44)
        }
        
        
        
        let storeBgV = UIView()
        storeBgV.adhere(toSuperview: view)
        storeBgV.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.left.equalTo(view.snp.centerX)
            $0.top.equalTo(settingBgV.snp.bottom)
            $0.height.equalTo(UIScreen.height / 3 / 2)
        }
        //
        let storeImgV = UIImageView()
        storeImgV.image("homepage_img5")
            .clipsToBounds()
            .contentMode(.scaleAspectFill)
            .adhere(toSuperview: storeBgV)
        storeImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        //
        storeBtn.addTarget(self, action: #selector(storeBtnClick(sender: )), for: .touchUpInside)
        storeBtn.adhere(toSuperview: storeBgV)
        storeBtn.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        let storeLabel = UILabel()
        storeLabel.fontName(22, "BodoniSvtyTwoITCTT-Book")
            .color(.white)
            .textAlignment(.center)
            .numberOfLines(2)
            .text("Store")
            .adhere(toSuperview: storeBgV)
        storeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(storeBgV.snp.centerY)
            $0.height.greaterThanOrEqualTo(1)
            $0.left.equalTo(44)
        }
        
    }

}

extension BCIymMainVC {
    
    @objc func commentBtnClick(sender: UIButton) {
        let vc = BCIymPreviewListVC(contentList: BCiymDataManager.default.commentList, title1: "Best Comment for IG" ?? "", title2: "2021 Most Popular Comment List" ?? "", topImgStr: "editor")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func captionBtnClick(sender: UIButton) {
        let vc = BCIymPreviewListVC(contentList: BCiymDataManager.default.captionList, title1: "Hottest Caption for IG" ?? "", title2: "2021 Best Caption for Profile" ?? "", topImgStr: "editor-1")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func comboBtnClick(sender: UIButton) {
        let vc = BCIymPreviewListVC(contentList: BCiymDataManager.default.comboList, title1: "Popularity Emoji Combo" ?? "", title2: "The Hottest Emoji Combo of 2021" ?? "", topImgStr: "editor-2")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func settingBtnClick(sender: UIButton) {
        let vc = BCIymSettingVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func storeBtnClick(sender: UIButton) {
        let vc = BCIymStoreVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
