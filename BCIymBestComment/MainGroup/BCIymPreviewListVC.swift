//
//  BCIymPreviewListVC.swift
//  BCIymBestComment
//
//  Created by Joe on 2021/12/30.
//

import UIKit
import ZKProgressHUD
class BCIymPreviewListVC: UIViewController {

    let collectionTopV = UIView()
    var contentList: [String]
    var title1: String
    var title2: String
    var collection: UICollectionView!
    let coinAlertView = BCIymCoinAlertView()
    var currentStr: String = ""
    var currentConfigStr: String = ""
    var topImgStr: String
    
    init(contentList: [String], title1: String, title2: String, topImgStr: String) {
        self.contentList = contentList
        self.title1 = title1
        self.title2 = title2
        self.topImgStr = topImgStr
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCoinAlertView()
    }
    

    

}

extension BCIymPreviewListVC {
    
    func setupCoinAlertView() {
        
        coinAlertView.alpha = 0
        view.addSubview(coinAlertView)
        coinAlertView.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
        
    }

    func showUnlockcoinAlertView() {
        // show coin alert
        
        self.view.bringSubviewToFront(self.coinAlertView)
        
        UIView.animate(withDuration: 0.35) {
            self.coinAlertView.alpha = 1
        }
        
        coinAlertView.okBtnClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            
            if InCymCoinManagr.default.coinCount >= InCymCoinManagr.default.coinCostCount {
                DispatchQueue.main.async {
                     
                    InCymCoinManagr.default.costCoin(coin: InCymCoinManagr.default.coinCostCount)
                    DispatchQueue.main.async {
                        if self.currentConfigStr == "edit" {
                            self.showEditVC(contentStr: self.currentStr)
                        } else {
                            self.copyAction(itemStr: self.currentStr)
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(title: "", message: "Insufficient Coins, please buy first.", buttonTitles: ["OK"], highlightedButtonIndex: 0) { i in
                        DispatchQueue.main.async {
                            [weak self] in
                            guard let `self` = self else {return}
                            self.navigationController?.pushViewController(BCIymStoreVC(), animated: true)
                        }
                    }
                }
            }

            UIView.animate(withDuration: 0.25) {
                self.coinAlertView.alpha = 0
            } completion: { finished in
                if finished {
                    
                }
            }
        }
         
        
        coinAlertView.backBtnClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            UIView.animate(withDuration: 0.25) {
                self.coinAlertView.alpha = 0
            } completion: { finished in
                if finished {
                    
                }
            }
        }
        
    }
    
}

extension BCIymPreviewListVC {
    func setupView() {
        view.backgroundColor(.black)
//        let bgImgV = UIImageView()
//        bgImgV.image("all_bg")
//            .contentMode(.scaleAspectFill)
//            .adhere(toSuperview: view)
//        bgImgV.snp.makeConstraints {
//            $0.left.right.top.bottom.equalToSuperview()
//        }
        view.clipsToBounds()
   // editor-1  editor-2
        let topImgV2 = UIImageView()
        topImgV2.image(topImgStr)
            .contentMode(.scaleAspectFill)
            .adhere(toSuperview: view)
         
        topImgV2.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(222)
        }
        
        //
        let topBanner = UIView()
        topBanner
            .backgroundColor(UIColor.clear)
            .adhere(toSuperview: view)
        topBanner.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(44)
        }
        //
        let backBtn = UIButton()
        backBtn
            .image(UIImage(named: "all_arrow_left"))
            .adhere(toSuperview: topBanner)
        backBtn.addTarget(self, action: #selector(backBtnClick(sender: )), for: .touchUpInside)
        backBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.equalTo(10)
            $0.width.equalTo(44)
            $0.height.equalTo(44)
        }
        
        
        
        // collection
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.layer.masksToBounds = true
        collection.delegate = self
        collection.dataSource = self
        
        view.addSubview(collection)
        collection.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(backBtn.snp.bottom).offset(0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        collection.register(cellWithClass: BCIymContentCell.self)
        collection.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        
        
        collectionTopV.backgroundColor(UIColor.clear)
        collectionTopV
            .adhere(toSuperview: collection)
        collectionTopV.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 120)
        let iconLabel = UILabel()
        iconLabel.fontName(22, "BodoniSvtyTwoITCTT-Book")
            .color(.white)
            .text(title1)
            .textAlignment(.center)
            .adhere(toSuperview: collectionTopV)
        iconLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(collectionTopV.snp.centerY).offset(0)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        let iconLabel2 = UILabel()
        iconLabel2.fontName(14, "Avenir-Light")
            .color(.white)
            .text(title2)
            .textAlignment(.center)
            .adhere(toSuperview: collectionTopV)
        iconLabel2.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(collectionTopV.snp.centerY).offset(4)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        
        
        
        
        
    }
    
    func showEditVC(contentStr: String) {
        let vc = BCIymEditVC(contentStr: contentStr)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func copyAction(itemStr: String) {
        UIPasteboard.general.string = itemStr
        ZKProgressHUD.showSuccess("Copy successfully!", maskStyle: nil, onlyOnceFont: nil, autoDismissDelay: 1.5, completion: nil)
    }
    
}

extension BCIymPreviewListVC {
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}

extension BCIymPreviewListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: BCIymContentCell.self, for: indexPath)
        cell.layer.cornerRadius = 16
        cell.layer.masksToBounds = true
        if indexPath.item == 0 {
            cell.contentImgV.image("editor_item1")
            cell.editBtn.backgroundImage(UIImage(named: "all_btn_color1"))
            cell.copyBtn.backgroundImage(UIImage(named: "all_btn_color1"))
        } else if indexPath.item == 1 {
            cell.contentImgV.image("editor_item2")
            cell.editBtn.backgroundImage(UIImage(named: "all_btn_color2"))
            cell.copyBtn.backgroundImage(UIImage(named: "all_btn_color2"))
        } else if indexPath.item == 2 {
            cell.contentImgV.image("editor_item3")
            cell.editBtn.backgroundImage(UIImage(named: "all_btn_color3"))
            cell.copyBtn.backgroundImage(UIImage(named: "all_btn_color3"))
        } else {
            cell.contentImgV.image("editor_item4")
            cell.editBtn.backgroundImage(UIImage(named: "all_btn"))
            cell.copyBtn.backgroundImage(UIImage(named: "all_btn"))
        }
        if indexPath.item == 0 {
            cell.proImgV.isHidden = true
        } else {
            cell.proImgV.isHidden = false
        }
        
        let item = contentList[indexPath.item]
        cell.nameLabel.text(item)
        cell.editBtnClickBlock = {
            [weak self] str in
            guard let `self` = self else {return}
            self.currentStr = str
            DispatchQueue.main.async {
                if indexPath.item == 0 {
                    self.showEditVC(contentStr: item)
                } else {
                    self.currentConfigStr = "edit"
                    self.showUnlockcoinAlertView()
                }
                
            }
        }
        cell.copyBtnClickBlock = {
            [weak self] str in
            guard let `self` = self else {return}
            self.currentStr = str
            DispatchQueue.main.async {
                if indexPath.item == 0 {
                    self.copyAction(itemStr: item)
                } else {
                    self.currentConfigStr = "copy"
                    self.showUnlockcoinAlertView()
                }
            }
            
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension BCIymPreviewListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let left: CGFloat = 15
        let cellwidth: CGFloat = (UIScreen.main.bounds.width - left * 2 - 1)
        let str = contentList[indexPath.item]
        let strAttr = NSAttributedString(string: str, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)])
        let strSize = strAttr.boundingRect(with: CGSize(width: (cellwidth - 16 * 2), height: CGFloat.infinity), options: .usesLineFragmentOrigin, context: nil).size
        var cellHeight: CGFloat = strSize.height + 120
        if indexPath.item <= 2 {
            cellHeight = strSize.height + 160
        }
        
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
 
        return UIEdgeInsets(top: 20, left: 15, bottom: 50, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        let cellwidth: CGFloat ÷reen.main.bounds.width - cellwidth - 1) / 2
        return 15 //left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let cellwidth: CGFloat = 343
        let left: CGFloat = (UIScreen.main.bounds.width - cellwidth - 1) / 2
        return 15 //left
    }
    
//    referenceSizeForHeaderInSection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: UIScreen.width, height: 120)
//        return CGSize(width: UIScreen.width, height: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath)
            
            return view
        }
        return UICollectionReusableView()
    }
    
}

extension BCIymPreviewListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = contentList[indexPath.item]
        if indexPath.item == 0 {
            self.showEditVC(contentStr: item)
        } else {
            currentConfigStr = "edit"
            currentStr = item
            showUnlockcoinAlertView()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
     
    
}



class BCIymContentCell: UICollectionViewCell {
    let contentImgV = UIImageView()
    let nameLabel = UILabel()
    let editBtn = UIButton()
    let copyBtn = UIButton()
    var editBtnClickBlock: ((String)->Void)?
    var copyBtnClickBlock: ((String)->Void)?
    var proImgV = UIImageView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        contentView.backgroundColor(UIColor.clear)
        
        contentImgV.contentMode = .scaleAspectFill
        contentImgV.clipsToBounds = true
        contentView.addSubview(contentImgV)
        contentImgV.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
        
        //
        nameLabel
//            .font(18)
            .fontName(18, "BodoniSvtyTwoITCTT-Book")
            .color(.white)
            .numberOfLines(0)
            .textAlignment(.left)
            .adhere(toSuperview: contentView)
        nameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(25)
            $0.right.equalToSuperview().offset(-25)
            $0.bottom.equalToSuperview().offset(-80)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        //
        editBtn.backgroundImage(UIImage(named: "all_btn"))
            .title("Edit")
            .font(14, "Avenir-Light")
            .titleColor(.white)
            .adhere(toSuperview: contentView)
        editBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-16)
            $0.right.equalToSuperview().offset(-120)
            $0.width.equalTo(96)
            $0.height.equalTo(40)
        }
        editBtn.addTarget(self, action: #selector(editBtnClick(sender: )), for: .touchUpInside)
        
        
        //
        copyBtn.backgroundImage(UIImage(named: "all_btn"))
            .title("Copy")
            .font(14, "Avenir-Light")
            .titleColor(.white)
            .adhere(toSuperview: contentView)
        copyBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-16)
            $0.right.equalToSuperview().offset(-16)
            $0.width.equalTo(96)
            $0.height.equalTo(40)
        }
        copyBtn.addTarget(self, action: #selector(copyBtnClick(sender: )), for: .touchUpInside)
        
        //
        proImgV.image("editor_pro")
            .adhere(toSuperview: contentView)
        proImgV.snp.makeConstraints {
            $0.top.right.equalToSuperview()
            $0.width.equalTo(58)
            $0.height.equalTo(28)
        }
        
    }
    
    
    @objc func editBtnClick(sender: UIButton) {
        editBtnClickBlock?(nameLabel.text ?? "")
        
    }
    
    @objc func copyBtnClick(sender: UIButton) {
        copyBtnClickBlock?(nameLabel.text ?? "")
    }
    
    
    
    
    
}






