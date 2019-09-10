//
//  BilietoService.swift
//  Bilieto
//
//  Created by pc1 on 23/07/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import Alamofire
import AlamofireImage
import AlamofireJsonToObjects

//Development

struct BILLBOARDAPI {
    static let BASE_URL = "http://api.bilieto.com/"
    
    static let GET_USER_BILLBOARD         =  BASE_URL +  "bilboards/"
    static let GET_PUBLIC_BILLBOARD       =  BASE_URL +  "bilboards/public/"
    static let GET_BILLBOARD              =  BASE_URL +  "bilboards/"
    
}


class BilietoService: NSObject {
    
    static let shared = BilietoService()
    
    func serviceCallToGetBillBoard(_ Id : Int,_ completion: @escaping (_ styles : [BillBoardModel]) -> Void) {
        showLoader()
        
        let headerParams :[String : String] = APIManager.shared.getMultipartHeaderPara()
        print(headerParams)
        
        Alamofire.request(BILLBOARDAPI.GET_USER_BILLBOARD + "\(Id)" , method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headerParams).responseObject { (response: DataResponse<StyleDataModel>) in
            removeLoader()
            
            switch response.result {
            case .success:
                if let data = response.data
                {
                    do{
                        let jsonDecoder = JSONDecoder()
                        let decodedLog = try jsonDecoder.decode(BillModel.self, from: data)
                        if APIManager.shared.checkStatusCode(decodedLog.status){
                            if (decodedLog.data) != nil {
                                completion(decodedLog.data)
                                return
                            }
                        }
                        completion([BillBoardModel]())
                        displayToast(decodedLog.status_message)
                        return
                    }
                    catch
                    {
                        displayToast(NSLocalizedString("something_went_wrong", comment: ""))
                        return
                    }
                }
                if let error = response.result.error
                {
                    displayToast(error.localizedDescription)
                    return
                }
                displayToast(NSLocalizedString("login_error", comment: ""))
                break
            case .failure(let error):
                displayToast(error.localizedDescription)
                break
            }
        }
    }
    
    
    func serviceCallToGetPublicBilBoard(_ page : Int,_ completion: @escaping (_ styles : [BillBoardModel]) -> Void){
        showLoader()
        
        let headerParams :[String : String] = APIManager.shared.getMultipartHeaderPara()
        print(headerParams)
        
        Alamofire.request(BILLBOARDAPI.GET_PUBLIC_BILLBOARD, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headerParams).responseObject { (response: DataResponse<StyleDataModel>) in
            removeLoader()
            
            switch response.result {
            case .success:
                if let data = response.data
                {
                    do{
                        let jsonDecoder = JSONDecoder()
                        let decodedLog = try jsonDecoder.decode(BillModel.self, from: data)
                        if APIManager.shared.checkStatusCode(decodedLog.status){
                            if (decodedLog.data) != nil {
                                completion(decodedLog.data)
                                return
                            }
                        }
                        completion([BillBoardModel]())
                        displayToast(decodedLog.status_message)
                        return
                    }
                    catch
                    {
                        displayToast(NSLocalizedString("something_went_wrong", comment: ""))
                        return
                    }
                }
                if let error = response.result.error
                {
                    displayToast(error.localizedDescription)
                    return
                }
                displayToast(NSLocalizedString("login_error", comment: ""))
                break
            case .failure(let error):
                displayToast(error.localizedDescription)
                break
            }
        }
    }
    
    func serviceCallToGetBoard(_ Id : String,_ bId : String,_ completion: @escaping (_ styles : GetBillBoardModel) -> Void) {
        showLoader()
       
        Alamofire.request(BILLBOARDAPI.GET_BILLBOARD + "\(Id)" + "/" + "\(bId)"  , method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<GetBillModel>) in
            removeLoader()
            
            switch response.result {
            case .success:
                if let data = response.data
                {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let decodedLog = try jsonDecoder.decode(GetBillModel.self, from: data)
                        if APIManager.shared.checkStatusCode(decodedLog.status) {
                            if (decodedLog.data) != nil {
                                completion(decodedLog.data)
                                return
                            }
                        }
//                        completion(GetBillBoardModel)
                        displayToast(decodedLog.status_message)
                        return
                    }
                    catch
                    {
                        displayToast(NSLocalizedString("something_went_wrong", comment: ""))
                        return
                    }
                }
                if let error = response.result.error
                {
                    displayToast(error.localizedDescription)
                    return
                }
                displayToast(NSLocalizedString("login_error", comment: ""))
                break
            case .failure(let error):
                displayToast(error.localizedDescription)
                break
            }
        }
    }
    
    
    
}
