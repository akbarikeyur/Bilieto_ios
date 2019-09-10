//
//  ShowPublicBillBoardVC.swift
//  Bilieto
//
//  Created by PC on 25/09/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import UIKit

class ShowPublicBillBoardVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var cardCollectionView: UICollectionView!
    
    var userId : String = ""
    var boardId : String = ""
    var type : Int = 1
    var _boardCard : [GetBoardCardModel] = [GetBoardCardModel]()
    var _boardInfo : [BillBoardModel] = [BillBoardModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getBillBoard()
        
    }
    func getBillBoard()  {
        BilietoService.shared.serviceCallToGetBoard(userId, boardId) { (data) in
            print(data)
            if data.boardCards != nil {
                 self._boardCard = data.boardCards
            }
            self._boardInfo = data.boardInfo
            self.cardCollectionView.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if(_boardCard == nil){
            cardCollectionView.backgroundView = nil
            return 0
        }
        else if _boardCard.count > 0
        {
            cardCollectionView.backgroundView = nil
            return 1
        }
        else
        {
            cardCollectionView.backgroundView  = getTableBackgroundViewForNoData(NSLocalizedString("boardCard_not_found", comment: ""),size:cardCollectionView.bounds.size)
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _boardCard.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: "BoardInfoCell", for: indexPath) as! BoardInfoCell
        
        if _boardCard.count > 0 {
            let dict : GetBoardCardModel = _boardCard[indexPath.row]
            
            if type == 1 {
                cell.imgBtn.sd_setBackgroundImage(with: URL(string: dict.cardImage), for:UIControl.State.normal,completed: { (image, error, SDImageCacheType, url) in
                    if image != nil{
                        cell.imgBtn.setBackgroundImage(image, for: .normal)
                    }else {
                        cell.lbl.text = "Error to load card image"
                    }
                })
            }
            else if type == 2 {
                cell.imgBtn.sd_setBackgroundImage(with: URL(string: dict.cardImageMed), for:UIControl.State.normal,completed: { (image, error, SDImageCacheType, url) in
                    if image != nil{
                        cell.imgBtn.setBackgroundImage(image, for: .normal)
                    }else {
                        cell.lbl.text = "Error to load card image"
                    }
                })
            }
            else if type == 3 {
                cell.imgBtn.sd_setBackgroundImage(with: URL(string: dict.cardImageSmall), for:UIControl.State.normal,completed: { (image, error, SDImageCacheType, url) in
                    if image != nil{
                        cell.imgBtn.setBackgroundImage(image, for: .normal)
                    }else {
                        cell.lbl.text = "Error to load card image"
                    }
                })
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if type == 1 {
            let cellW : CGFloat = cardCollectionView.frame.size.width
            let cellH : CGFloat = cardCollectionView.frame.size.height/2.5
            return CGSize(width: cellW, height: cellH)
        }
        else if type == 2 {
            let cellW : CGFloat = cardCollectionView.frame.size.width/2
            let cellH : CGFloat = cellW
            return CGSize(width: cellW, height: cellH)
        }
        else {
            let cellW : CGFloat = cardCollectionView.frame.size.width/3
            let cellH : CGFloat = cellW
            return CGSize(width: cellW, height: cellH)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CardWebViewVC") as! CardWebViewVC
        let dict : GetBoardCardModel = _boardCard[indexPath.row]
        vc.cardUserId = dict.cardUserID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - Button Click
    
    @IBAction func clickToList(_ sender: Any) {
        type = 1
        cardCollectionView.reloadData()
    }
    
    @IBAction func clickToGrid(_ sender: Any) {
        type = 2
        cardCollectionView.reloadData()
    }
    
    @IBAction func clickToTemp(_ sender: Any) {
        type = 3
        cardCollectionView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}

class BoardInfoCell: UICollectionViewCell {
    
    @IBOutlet var imgBtn: UIButton!
    @IBOutlet var lbl: UILabel!
    
}
