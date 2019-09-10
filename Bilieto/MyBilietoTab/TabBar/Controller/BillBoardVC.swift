//
//  BillBoardVC.swift
//  Bilieto
//
//  Created by pc1 on 23/07/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit
import HMSegmentedControl

class BillBoardVC: UIViewController,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var segmentView: UISegmentedControl!
    @IBOutlet var tblView: UITableView!
    
    var _board : [BillBoardModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentView.selectedSegmentIndex = 0
    
        NotificationCenter.default.addObserver(self, selector: #selector(dropDownSelection(noti:)), name: NSNotification.Name(rawValue: "DROPDOWN_SELECTION"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(redirectToScanQRCode(noti:)), name: NSNotification.Name(rawValue: "SCAN_QRCODE"), object: nil)
        
        tblView.register(UINib(nibName: "MyBoardTVC", bundle: nil), forCellReuseIdentifier: "MyBoardTVC")

        
    }
    //MARK: - TABLEVIEW DELEGATE
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if(_board == nil){
            tableView.backgroundView = nil
            return 0
        }
        else if _board.count > 0
        {
            tableView.backgroundView = nil
            return 1
        }
        else
        {
            tableView.backgroundView  = getTableBackgroundViewForNoData(NSLocalizedString("my_bilboards_not_found", comment: ""),size:tableView.bounds.size)
            return 0
        }
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _board.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentView.selectedSegmentIndex == 0 {
            let cell = tblView.dequeueReusableCell(withIdentifier: "MyBoardTVC", for: indexPath) as! MyBoardTVC
            
            return cell
        }
        else {
            let cell = tblView.dequeueReusableCell(withIdentifier: "MyBoardTVC", for: indexPath) as! MyBoardTVC
        
            return cell
        }
    }
   
    @objc func dropDownSelection(noti : Notification)
    {
        let vc : UIViewController = UIApplication.topViewController()!
        if (vc is BillBoardVC) {
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
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else if index == 2
                {
                    let vc = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "OptionsVC") as! OptionsVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else if index == 3
                {
                    let vc = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
                    self.navigationController?.pushViewController(vc, animated: true)
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
        if (vc is BillBoardVC) {
            let vc : MyQRCodeVC = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "MyQRCodeVC") as! MyQRCodeVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    //MARK: - SEGMENT ACTION
    @IBAction func clickToSegment(_ sender: Any) {
        tblView.reloadData()
    }
    
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
        
        
    }
    
}
