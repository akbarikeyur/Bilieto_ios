//
//  ChangeStyleVC.swift
//  Bilieto
//
//  Created by Amisha on 4/4/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit
import SDWebImage

class ChangeStyleVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
   
    @IBOutlet weak var StyleCollectionView: UICollectionView!
    
    var _styles : [StyleModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(dropDownSelection(noti:)), name: NSNotification.Name(rawValue: "DROPDOWN_SELECTION"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(redirectToScanQRCode(noti:)), name: NSNotification.Name(rawValue: "SCAN_QRCODE"), object: nil)
        
        styleData()
        
    }
   
    func styleData()  {
        SettingSevices.shared.serviceCallToGetStyles { (arr) in
            self._styles = arr
            self.StyleCollectionView.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if(_styles == nil){
            collectionView.backgroundView = nil
            return 0
        }
        else if _styles.count > 0
        {
            collectionView.backgroundView = nil
            return 1
        }
        else
        {
            collectionView.backgroundView  = getTableBackgroundViewForNoData(NSLocalizedString("style_not_found", comment: ""),size:collectionView.bounds.size)
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _styles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dict : StyleModel = _styles[indexPath.row]
        let cell = StyleCollectionView.dequeueReusableCell(withReuseIdentifier: "ChangeStyleCVC", for: indexPath) as! ChangeStyleCVC
        cell.StyleLbl.text = dict.styleName
       
        cell.StyleBtnImg.sd_setBackgroundImage(with: URL(string: dict.imageURL), for:UIControl.State.normal,completed: { (image, error, SDImageCacheType, url) in
            if image != nil{
                cell.StyleBtnImg.setBackgroundImage(image, for: .normal)
            }
        })
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {

        let cellH : CGFloat = collectionView.frame.size.height/2.5
        let cellW : CGFloat = collectionView.frame.size.width
        return CGSize(width: cellW, height: cellH)

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PreviewVC")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @objc func dropDownSelection(noti : Notification)
    {
        let vc : UIViewController = UIApplication.topViewController()!
        if (vc is ChangeStyleVC) {
            let dict : [String : Int] = noti.object as! [String : Int]
            if let index : Int = dict["index"]
            {
                if index == 0
                {
                    let vc = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
                    self.navigationController?.pushViewController(vc, animated: false)
                }
                else if index == 1
                {
                    let vc = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "ChangeStyleVC") as! ChangeStyleVC
                    self.navigationController?.pushViewController(vc, animated: false)
                }
                else if index == 2
                {
                    let vc = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "OptionsVC") as! OptionsVC
                    self.navigationController?.pushViewController(vc, animated: false)
                }
                else if index == 3
                {
                    let vc = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
                    self.navigationController?.pushViewController(vc, animated: false)
                }
                else {
                    AppDelegate().sharedDelegate().logout()
                }
            }
        }
    }
    
    
    @objc func redirectToScanQRCode(noti : Notification)
    {
        let vc : UIViewController = UIApplication.topViewController()!
        if (vc is ChangeStyleVC) {
            let vc : MyQRCodeVC = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "MyQRCodeVC") as! MyQRCodeVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
 
}
class ChangeStyleCVC: UICollectionViewCell {
    
    @IBOutlet weak var StyleBtnImg: UIButton!
    @IBOutlet weak var StyleLbl: Label!
    
}
