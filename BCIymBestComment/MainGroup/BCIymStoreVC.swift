//
//  BCIymStoreVC.swift
//  BCIymBestComment
//
//  Created by Joe on 2021/12/30.
//



import UIKit
import NoticeObserveKit
import ZKProgressHUD

class BCIymStoreVC: UIViewController {
    private var pool = Notice.ObserverPool()
    let topCoinLabel = UILabel()
    var collection: UICollectionView!
    let backBtn = UIButton(type: .custom)
    var topBanner: UIView = UIView()
//    let collectionTopV = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addNotificationObserver()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addNotificationObserver() {
        
        NotificationCenter.default.nok.observe(name: .pi_noti_coinChange) {[weak self] _ in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.topCoinLabel.text = ( "\(InCymCoinManagr.default.coinCount)")
            }
        }
        .invalidated(by: pool)
        
    }

}

extension BCIymStoreVC {
    func setupView() {
        view.backgroundColor(.white)
        let bgImgV = UIImageView()
        bgImgV.image("all_bg")
            .contentMode(.scaleAspectFill)
            .adhere(toSuperview: view)
        bgImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
         
        view.clipsToBounds()
        //
//        let topBgV = UIView()
//        topBgV.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: 280)
//        topBgV.backgroundColor(UIColor(hexString: "#FF6A00")!)
//            .adhere(toSuperview: view)
//        topBgV.roundCorners([.bottomLeft, .bottomRight], radius: 24)
        
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
        //
//        let topTitleLabel = UILabel()
//        topTitleLabel
//            .fontName(16, "Comfortaa")
//            .color(UIColor(hexString: "#000000")!)
//            .text("Store")
//            .adhere(toSuperview: topBanner)
//        topTitleLabel.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.centerY.equalTo(backBtn.snp.centerY)
//            $0.width.height.greaterThanOrEqualTo(1)
//        }
        
        //
        
//        collectionTopV.backgroundColor(UIColor.clear)
            
        
        //
        
        
        //
        let topCoinImgV = UIImageView()
        topCoinImgV
            .image("store_diamond_big")
            .adhere(toSuperview: view)
        topCoinImgV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(backBtn.snp.bottom).offset(24)
            $0.width.greaterThanOrEqualTo(96)
            $0.height.greaterThanOrEqualTo(96)
        }
        
        //
        topCoinLabel
            .fontName(22, "BodoniSvtyTwoITCTT-Book")
            .color(UIColor.white)
            .adhere(toSuperview: view)
        topCoinLabel.text = ( "\(InCymCoinManagr.default.coinCount)")
        topCoinLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(topCoinImgV.snp.bottom).offset(4)
            $0.width.greaterThanOrEqualTo(1)
            $0.height.equalTo(35)
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
//        collection.bounces = false
        
        view.addSubview(collection)
        collection.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(topCoinLabel.snp.bottom).offset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        collection.register(cellWithClass: PCoymStoreCell.self)
        collection.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        
        //
//        collectionTopV
//            .adhere(toSuperview: collection)
//        collectionTopV.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 220)
        
        //
//        let bottomM = UIView()
//        bottomM
//            .backgroundColor(.white)
//            .adhere(toSuperview: view)
//        bottomM.snp.makeConstraints {
//            $0.left.right.bottom.equalToSuperview()
//            $0.top.equalTo(collection.snp.bottom)
//        }
        
//        collection.addSubview(collectionTopV)
//        collectionTopV.snp.makeConstraints {
//            $0.width
//        }
        
    }
    
}

extension BCIymStoreVC {
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
     
    @objc func topCoinBtnClick(sender: UIButton) {
        self.navigationController?.pushViewController(BCIymStoreVC(), animated: true)
    }
}



extension BCIymStoreVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: PCoymStoreCell.self, for: indexPath)
        cell.layer.cornerRadius = 56/2
        cell.layer.masksToBounds = true
        let item = InCymCoinManagr.default.coinIpaItemList[indexPath.item]
        cell.coinCountLabel.text = "\(item.coin)"
        if let localPrice = item.localPrice {
            cell.priceLabel.text = item.localPrice
        } else {
            cell.priceLabel.text = "$\(item.price)"
//            let str = "$\(item.price)"
//            let att = NSMutableAttributedString(string: str, attributes: [NSAttributedString.Key.font : UIFont(name: "MarkerFelt-Wide", size: 16) ?? UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor.black])
//            let ran1 = str.range(of: "$")
//            let ran1n = "".nsRange(from: ran1!)
//            att.addAttributes([NSAttributedString.Key.font : UIFont(name: "MarkerFelt-Wide", size: 32) ?? UIFont.systemFont(ofSize: 16)], range: ran1n)
//            cell.priceLabel.attributedText = att
            
        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return InCymCoinManagr.default.coinIpaItemList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension BCIymStoreVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let left: CGFloat = 15
        let padding: CGFloat = 15
        
        let cellwidth: CGFloat = (UIScreen.main.bounds.width - left * 2 - padding - 1) / 2
        let cellHeight: CGFloat = 56
        
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let cellwidth: CGFloat = 343
//        let left: CGFloat = (UIScreen.main.bounds.width - cellwidth - 1) / 2
        
        
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
        
//        return CGSize(width: UIScreen.width, height: 152)
        return CGSize(width: UIScreen.width, height: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath)
            
            return view
        }
        return UICollectionReusableView()
    }
    
}

extension BCIymStoreVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = InCymCoinManagr.default.coinIpaItemList[safe: indexPath.item] {
            selectCoinItem(item: item)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func selectCoinItem(item: InCyStoreItem) {
        // core
        
        InCyPurchaseManagerLink.default.purchaseIapId(item: item) { (success, errorString) in
            
            if success {
                ZKProgressHUD.showSuccess("Purchase successful.")
            } else {
                ZKProgressHUD.showError("Purchase failed.")
            }
        }
    }
    
}

class PCoymStoreCell: UICollectionViewCell {
    
    var bgView: UIView = UIView()
    
    var iconImageV: UIImageView = UIImageView()
    var coverImageV: UIImageView = UIImageView()
    var coinCountLabel: UILabel = UILabel()
    var priceLabel: UILabel = UILabel()
    var priceBgImgV: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        backgroundColor =  UIColor.white.withAlphaComponent(0.15)
        let bgImgV = UIImageView()
        bgImgV.image("store_diamond")
            .contentMode(.scaleAspectFit)
            .adhere(toSuperview: contentView)
        bgImgV.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(4)
            $0.width.height.equalTo(48)
        }
        
//        layer.cornerRadius = 12
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.black.cgColor
        //
//        iconImageV.backgroundColor = .clear
//        iconImageV.contentMode = .scaleAspectFit
//        iconImageV.image = UIImage(named: "coins_big_pic")
//        contentView.addSubview(iconImageV)
//        iconImageV.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.left.equalTo(contentView.snp.left).offset(34)
//            $0.width.equalTo(64)
//            $0.height.equalTo(64)
//
//        }
         
        //
        coinCountLabel.adjustsFontSizeToFitWidth = true
        coinCountLabel
            .color(UIColor(hexString: "#FFFFFF")!)
            .numberOfLines(1)
            .fontName(18, "BodoniSvtyTwoITCTT-Book")
            .textAlignment(.left)
            .adhere(toSuperview: contentView)
        coinCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(bgImgV.snp.centerY)
            $0.left.equalTo(bgImgV.snp.right).offset(4)
            $0.width.height.greaterThanOrEqualTo(28)
        }
        
        let priceBgV = UIView()
        priceBgV
//            .backgroundColor(UIColor(hexString: "#47D2FF")!)
            .adhere(toSuperview: contentView)
        priceBgV.layer.cornerRadius = 20
        //
        priceBgImgV.image("")
            .adhere(toSuperview: priceBgV)
        priceBgImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalTo(priceBgV)
        }
        //
        priceLabel.textColor = UIColor.white
        priceLabel.font = UIFont(name: "Avenir-Light", size: 14)
        priceLabel.textAlignment = .right
        contentView.addSubview(priceLabel)
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(bgImgV.snp.centerY)
            $0.right.equalToSuperview().offset(-16)
            $0.height.greaterThanOrEqualTo(40)
            $0.width.greaterThanOrEqualTo(50)
        }
        
        priceBgV.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.top).offset(0)
            $0.left.equalTo(priceLabel.snp.left).offset(-0)
            $0.bottom.equalTo(priceLabel.snp.bottom).offset(0)
            $0.right.equalTo(priceLabel.snp.right).offset(0)
        }
        
        
        
    }
     
}





