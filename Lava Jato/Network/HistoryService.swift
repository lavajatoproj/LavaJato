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

protocol GenericService:AnyObject{
    typealias completion <T> = (_ result: T, _ failure:Error?) -> Void
}

enum _Error:Swift.Error{
    case fileNotFound(name:String)
    case fileDecodingFailed(name:String,Swift.Error)
}

protocol PersonServiceDelegate:GenericService{
    func getPersonFromJson(completion: @escaping completion<Users?>)
}


class PersonService:PersonServiceDelegate{
    
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
