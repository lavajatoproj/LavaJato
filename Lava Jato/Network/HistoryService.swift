//
//  PersonService.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 11/05/22.
//

//import Foundation
//
//protocol GenericService:AnyObject{
//    typealias completion <T> = (_ result: T, _ failure:Error?) -> Void
//}
//
//enum Error2:Swift.Error{
//    case fileNotFound(name:String)
//    case errorURL(urlString:String)
//    case detailError(detail:String)
//    case fileDecodingFailed(name:String,Swift.Error?)
//}
//
//protocol PersonServiceDelegate:GenericService{
//    func getPersonFromJson(completion: @escaping completion<Users?>)
//}
//
//class PersonService:PersonServiceDelegate{
//
//    func getPersonFromJson(completion: @escaping completion<Users?>) {
//        if let url = Bundle.main.url(forResource: "Users", withExtension: "json"){
//            do {
//                let data = try Data(contentsOf: url)
//                let person:Users = try JSONDecoder().decode(Users.self, from: data)
//                completion(person,nil)
//            } catch{
//                print(error)
//                completion(nil,Error2.fileDecodingFailed(name: "Users", error))
//            }
//        }
//    }
//}

import Foundation
import Alamofire

protocol GenericService:AnyObject{
    typealias completion <T> = (_ result: T, _ failure:Error?) -> Void
}

enum _Error:Swift.Error{
    case fileNotFound(name:String)
    case fileDecodingFailed(name:String,Swift.Error)
    case errorRequest(AFError)
}

protocol PersonServiceDelegate:GenericService{
    func getPersonFromJson(completion: @escaping completion<Users?>)
    func getPersonAlamofire(completion: @escaping completion<Users?>)
}


class PersonService:PersonServiceDelegate{
    
    // fazendo uma requisacao para bater em uma API
    func getPersonAlamofire(completion: @escaping completion<Users?>) {
        let url:String = "https://run.mocky.io/v3/193d0b88-4231-486e-9e32-2615ff071198"
        
        // AF do Alamonfire
        AF.request(url,method: .get).responseDecodable(of: Users.self){ response in
            debugPrint(response)                      // um print mais avançado
            switch response.result{
            case .success(let success):
                print("Sucesso")
                completion(success,nil)
            case .failure(let error):
                print("ERROR")
                completion(nil, _Error.errorRequest(error))
            }
        }
    }
    
    
    // leitura de um MOC, informacoes que estao dentro do aplicativo
    func getPersonFromJson(completion: @escaping completion<Users?>) {
        if let url = Bundle.main.url(forResource: "Users", withExtension: "json"){
            do {
                let data = try Data(contentsOf: url)
                let user:Users = try JSONDecoder().decode(Users.self, from: data)
                completion(user,nil)
            } catch{
                print(error)
                completion(nil,_Error.fileDecodingFailed(name: "Users", error))
            }
        }
    }
}
