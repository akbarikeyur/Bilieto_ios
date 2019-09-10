//
//  MyBilietoVC.swift
//  Bilieto
//
//  Created by pc1 on 23/07/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit
import SDWebImage

class MyBilietoVC: UIViewController,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tblView: UITableView!
    
     var _publicBoard : [BillBoardModel]!
    
     lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(dropDownSelection(noti:)), name: NSNotification.Name(rawValue: "DROPDOWN_SELECTION"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(redirectToScanQRCode(noti:)), name: NSNotification.Name(rawValue: "SCAN_QRCODE"), object: nil)
        
        tblView.register(UINib(nibName: "MyBoardTVC", bundle: nil), forCellReuseIdentifier: "MyBoardTVC")
        getUserBillBoard()
        self.tblView.addSubview(self.refreshControl)
    }
    
    func getUserBillBoard() {
        let Id : Int = Int(AppModel.shared.currentUser.userID)!
        BilietoService.shared.serviceCallToGetBillBoard(Id) { (UserBillBoard) in
            self._publicBoard = UserBillBoard
            self.tblView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getUserBillBoard()
    }

    //MARK: - TABLEVIEW DELEGATE
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if(_publicBoard == nil){
            tableView.backgroundView = nil
            return 0
        }
        else if _publicBoard.count > 0
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
        return _publicBoard.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "MyBoardTVC", for: indexPath) as! MyBoardTVC
        let dict : BillBoardModel = _publicBoard[indexPath.row]
        
        cell.boardNameLbl.text = dict.boardTitle
        cell.userNameLbl.text = dict.boardUserName
        cell.boardDiscriptionLbl.text = dict.boardDescription
        
        
        if dict.userImageURL != nil {
            cell.boardImgBtn.sd_setBackgroundImage(with: URL(string: dict.userImageURL), for:UIControl.State.normal,completed: { (image, error, SDImageCacheType, url) in
                if image != nil{
                    cell.boardImgBtn.setBackgroundImage(image, for: .normal)
                }
            })
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict : BillBoardModel = _publicBoard[indexPath.row]
        print(dict)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShowPublicBillBoardVC") as! ShowPublicBillBoardVC
        vc.userId = dict.userID
        vc.boardId = dict.boardID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func dropDownSelection(noti : Notification)
    {
        let vc : UIViewController = UIApplication.topViewController()!
        if (vc is MyBilietoVC) {
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
        if (vc is MyBilietoVC) {
            let vc : MyQRCodeVC = STORYBOARD.MYBILIETO.instantiateViewController(withIdentifier: "MyQRCodeVC") as! MyQRCodeVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
