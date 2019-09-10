//
//  SettingService.swift
//  Bilieto
//
//  Created by pc1 on 10/07/18.
//  Copyright © 2018 Amisha. All rights reserved.
//

import Alamofire
import AlamofireImage
import AlamofireJsonToObjects

//Development
struct SETTINGAPI {
    static let BASE_URL = "http://api.bilieto.com/"
    
    static let GET_STYLES  =  BASE_URL +  "styles/page=1"
    
}


class SettingSevices: NSObject {
    
    
    
    static let shared = SettingSevices()
  
    func serviceCallToGetStyles(_ completion: @escaping (_ styles : [StyleModel]) -> Void){
        showLoader()
        
        let headerParams :[String : String] = APIManager.shared.getMultipartHeaderPara()
        print(headerParams)
        
        Alamofire.request(SETTINGAPI.GET_STYLES, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headerParams).responseObject { (response: DataResponse<StyleDataModel>) in
            removeLoader()
            
            switch response.result {
            case .success:
                if let data = response.data
                {
                    do{
                        let jsonDecoder = JSONDecoder()
                        let decodedLog = try jsonDecoder.decode(StyleDataModel.self, from: data)
                        if APIManager.shared.checkStatusCode(decodedLog.status){
                            if (decodedLog.data) != nil {
                                completion(decodedLog.data)
                                return
                            }
                        }
                        completion([StyleModel]())
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
