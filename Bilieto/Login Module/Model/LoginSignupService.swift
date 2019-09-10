//
//  LoginSignUpService.swift
//  ToShare
//
//  Created by ToShare Pty. Ltd. on 2/16/18.
//  Copyright © 2018 ToShare Pty. Ltd.. All rights reserved.
//

import Alamofire
import AlamofireImage
import AlamofireJsonToObjects

class LoginSignupService: NSObject {

    static let shared = LoginSignupService()
    
    //MARK:- login-signup
    
    func serviceCallToSignup(_ imageData : Data, completion: @escaping () -> Void){
        showLoader()
        
        let headerParams :[String : String] = APIManager.shared.getMultipartHeaderPara()
        var params :[String : Any] = AppModel.shared.currentUser.toDictionary() as! [String : Any]
        params["userPhoto"] = nil
        print(params)

        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            if imageData.count != 0
            {
                multipartFormData.append(imageData, withName: "userPhoto", fileName: "userPhoto.png", mimeType: "image/png")
            }
        }, usingThreshold: UInt64.init(), to: BASE_URL + "signup/POST" , method: .post, headers: headerParams) { (result) in
            switch result{
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseObject { (response: DataResponse<UserDataModel>) in
                    removeLoader()
              
                    switch response.result {
                    case .success:
                        print(response.data)
                        if let data = response.data
                        {
                            do{
                                let jsonDecoder = JSONDecoder()
                                let decodedLog = try jsonDecoder.decode(UserDataModel.self, from: data)
                                if APIManager.shared.checkStatusCode(decodedLog.status){
                                    if (decodedLog.data) != nil{
                                        AppModel.shared.currentUser = decodedLog.data
                                        saveUser()
                                        completion()
                                        return
                                    }
                                }
                                displayToast(decodedLog.status_message)
                                return
                              }
                            catch
                            {
                                displayToast(NSLocalizedString("something_went_wrong", comment: ""))
                                return
                            }
                        }
                        AppDelegate().sharedDelegate().logout()
                        if let error = response.result.error
                        {
                            displayToast(error.localizedDescription)
                            return
                        }
                        displayToast(NSLocalizedString("register_error", comment: ""))
                        break
                    case .failure(let error):
                        AppDelegate().sharedDelegate().logout()
                        displayToast(error.localizedDescription)
                        break
                    }
                }
            case .failure(let error):
                removeLoader()
                displayToast(error.localizedDescription)
                break
            }
        }
    }
    
  
    func serviceCallToLogin(_ completion: @escaping () -> Void) {
        showLoader()

        let headerParams :[String : String] = APIManager.shared.getMultipartHeaderPara()

        var params : [String : Any] = [String : Any]()
        params["userEmail"] = AppModel.shared.currentUser.userEmail
        params["userPassword"] = AppModel.shared.currentUser.userPassword

        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, usingThreshold: UInt64.init(), to: "http://api.bilieto.com/user/login/POST", method: .post
        , headers: headerParams) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseObject { (response: DataResponse<UserDataModel>) in
                    removeLoader()
                   
                    switch response.result {
                    case .success:
                        if let data = response.data
                        {
                          do{
                                let jsonDecoder = JSONDecoder()
                                let decodedLog = try jsonDecoder.decode(UserDataModel.self, from: data)
                                if APIManager.shared.checkStatusCode(decodedLog.status){
                                    if (decodedLog.data) != nil{
                                        AppModel.shared.currentUser = decodedLog.data
                                        saveUser()
                                        completion()
                                        return
                                    }
                                }
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
                        AppDelegate().sharedDelegate().logout()
                        displayToast(error.localizedDescription)
                        break
                    }
                } 
            case .failure(let error):
                removeLoader()
                displayToast(error.localizedDescription)
                break
            }
        }
    }
    
  
    func serviceCallToChangePassword(_ useroldpass : String,_ userpass : String,_ completion: @escaping () -> Void) {
        showLoader()
        let headerParams :[String : String] = APIManager.shared.getMultipartHeaderPara()
        var dict:[String:Any] = [String:Any]()
        dict["userID"] = AppModel.shared.currentUser.userID
        dict["useroldPassword"] = useroldpass
        dict["userPassword"] = userpass
        
        print(dict)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in dict {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, usingThreshold: UInt64.init(), to: "http://api.bilieto.com/user/changepassword/PUT", method: .post
        , headers: headerParams) { (result) in
            switch result{
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                upload.responseObject { (response: DataResponse<DataModel>) in
                    
                    removeLoader()
              
                    
                    switch response.result {
                    case .success:
                        if let data = response.data
                        {
                            do{
                                let jsonDecoder = JSONDecoder()
                                let decodedLog = try jsonDecoder.decode(DataModel.self, from: data)
                                if APIManager.shared.checkStatusCode(decodedLog.status) {
                                    displayToast(decodedLog.status_message)
                                    completion()
                                }
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
                        displayToast(NSLocalizedString("change_pwd_error", comment: ""))
                        break
                    case .failure(let error):
                        displayToast(error.localizedDescription)
                        break
                    }
                }
            case .failure(let error):
                removeLoader()
                displayToast(error.localizedDescription)
                break
            }
        }
    }
}
