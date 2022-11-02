//
//  MY_HTTP.swift
//  VidyoConnector
//
//  Created by 영상점검 on 2022/08/05.
//

import Foundation

//protocol MY_HTTPDelegate {
//    func StartWEBVIEW(_url: String)
//}

class MY_HTTP {
//    static var delegate:MY_HTTPDelegate?

    static func do_count1()
    {
        var url = "https://asia-northeast3-now-push-5e29e.cloudfunctions.net/count_plus"
        var method = "POST"
        var param: Dictionary = [String: Any]()
//        param["vote"]="1"
        param["phoneNum"]="010-2579-3844"

        request(url,method,param){ (success, data) in
            print(success)
            print(data)
          }
    }
    static func do_count2()
    {
        var url = "https://asia-northeast3-now-push-5e29e.cloudfunctions.net/count_minus"
        var method = "POST"
        var param: Dictionary = [String: Any]()
//        param["vote"]=5
        param["phoneNum"]="010-2579-3844"

        request(url,method,param){ (success, data) in
            print(success)
            print(data)
          }
    }
    
    static func request(_ url: String, _ method: String, _ param: [String: Any]? = nil, completionHandler: @escaping (Bool, Any) -> Void) {
        if method == "GET" {
//            requestGet(url: url) { (success, data) in
//                completionHandler(success, data)
//            }
        }
        else {
            requestPost(url: url, method: method, param: param!) { (success, data) in
                completionHandler(success, data)
            }

        }
    }

    struct Response: Codable {
        let success: Bool
        let result: String
        let message: String
    }

    static func requestPost(url: String, method: String, param: [String: Any], completionHandler: @escaping (Bool, Any) -> Void) {
        let sendData = try! JSONSerialization.data(withJSONObject: param, options: [])
        
        print("do_vote")
        
        guard let url = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = sendData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
//            print(response)
            let output = "done"//String(response.self)
//            guard let output = try? JSONDecoder().decode(Response.self, from: data) else {
//                print("Error: JSON Data Parsing failed")
//                return
//            }
            
            completionHandler(true, output)
        }.resume()
    }


//    static func post(urlString:String, postString:String)
//    {
//        let url = URL(string: urlString)
//        guard let requestUrl = url else { fatalError() }
//        // Prepare URL Request Object
//        print("REQUEST----- \(requestUrl)")
//        print("param: ----- \(postString)")
//        var request = URLRequest(url: requestUrl)
//        request.httpMethod = "POST"
//        request.httpBody = postString.data(using: String.Encoding.utf8);
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//                if let error = error {
//                    print("Error took place \(error)")
//
//                    return
//                }
//                // Convert HTTP Response Data to a String
//                if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                    print("Response data sFtring:\n \(String(dataString.prefix(300)))")//100줄까지.
//                                    }
//        }
//        task.resume()
//    }
//    static func do1(_ roomKey:String, _ enterId:String, _ enterCo:String, _ appSeq:String)
//    {
//        let basic = String(
//            String("actionType="+actionType+"&") +
//            String("callback="+"json"+"&") +
//            String("dataType="+"asdf"+"&")
//        )
//        let param = String(
//            basic +
//            String("roomKey="+roomKey+"&") +
//            String("enterId="+enterId+"&") +
//            String("enterCo="+enterCo+"&") +
//            String("appSeq="+appSeq) )
//
//        MY_HTTP.post(urlString:Easy.API,postString:param)
//
//    }

}
