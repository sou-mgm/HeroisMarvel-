//
//  marvelAPI.swift
//  MarvelHerois
//
//  Created by Matheus Matias on 26/12/22.
//

import Foundation
import Alamofire
import SwiftHash


class MarvelAPI {
    
    static private let basePath = "https://gateway.marvel.com/v1/public/characters"
    static private let privateKey = "0b3be38cf5ff553c02a1b23d3502666470651366"
    static private let publicKey = "3be2059849f7cc40ee799161a92fc58b"
    static private let limit = 50
    
    private class func getCredentials() -> String {
        // devolve um intervalo de tempo entre 1970 até agora. O que permite uma maneira dinamica de ter um valor exclusivo
        let ts = String (Date().timeIntervalSince1970)
        // Cria a hash utilizando uma variavel da dependencia SwiftHash. Uso de lowercased só se faz necessario devido a api da marvel solicitar tudo em minusculo
        let hash = MD5(ts+privateKey+publicKey).lowercased()
        return "ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
    
    
    class func loadHeros(name: String?, page: Int, onComplete: @escaping (MarvelInfo?) -> Void){
        // Determina as informacoes que serao carregadas de acordo com a pagina
        // offset - a pagina comeca na 0, e recupera 50 herois, caso vá para a pagina 1, ele pula os 50 arquivos já carregados, evitando repetir informacoes
        let offset = page * limit
        // Nesta requisicao sera procurado herois a qual as inicias comecam com o que usuario digitou
        let startsWith: String
        // desembrulha o nome
        if let name = name, !name.isEmpty {
            startsWith = "nameStartsWith=\(name.replacingOccurrences(of: " ", with: ""))&"
        } else {
            startsWith = ""
        }
        // Cria a url
        let url = basePath + "?offset=\(offset)&limit=\(limit)&" + startsWith + getCredentials()
        print (url)
        
        // Realiza o request usando a dependencia Alamofire
        AF.request(url).responseJSON { (response) in
            //Desembrulha verificando a responta, se o http code é 200, e se é possivel decodificar a informacao
            guard let data = response.data else {
                print ("Sem Data")
                onComplete(nil)
                return
            }
            do{
                let marvelInfo = try JSONDecoder().decode(MarvelInfo.self, from: data)
                // retorna a informacao para a closure
                onComplete(marvelInfo)
                
            }catch{
                onComplete(nil)
                print (error.localizedDescription)
            }
                  
                   
        }
        
    }
}
