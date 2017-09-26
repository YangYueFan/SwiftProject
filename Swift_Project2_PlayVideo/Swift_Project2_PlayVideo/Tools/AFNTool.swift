//
//  AFNTool.swift
//  Swift_Project2_PlayVideo
//
//  Created by 科技部2 on 2017/9/18.
//  Copyright © 2017年 Ken. All rights reserved.
//

import UIKit


enum RequestType:String {
    case GET = "GET"
    case POST = "POST"
}


class AFNTool: AFHTTPSessionManager {
    
    //单例
    static let shareInstance :AFNTool = {
        let tools = AFNTool();
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        return tools
    }()
    
}

extension AFNTool{
    
    func reqest(methodType : RequestType , urlString:String,parameters:[String : String],finished :@escaping (_ result : AnyObject?, _ error : Error?)-> ()) {
        
        let successBlock = {(task:URLSessionDataTask,result:Any)in
            finished(result as AnyObject?,nil)
        }
        let failureBlock = {(task:URLSessionDataTask,error:Error)in
            finished(nil,error)
        }
        
        if methodType == .GET {
            // get 请求
            get(urlString, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock as? (URLSessionDataTask?, Error) -> Void)
        } else {
            post(urlString, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock as? (URLSessionDataTask?, Error) -> Void)
        }
        
    }
   
}
