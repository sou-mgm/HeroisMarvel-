//
//  MarvelClasses.swift
//  MarvelHerois
//
//  Created by Matheus Matias on 26/12/22.
//

import Foundation


struct MarvelInfo: Codable {
        var code: Int
        var status: String
        var data: MarvelData
    }

    struct MarvelData: Codable {
        let offset: Int
        let limit: Int
        let total: Int
        let count: Int
        let results: [Hero]

    }

    struct Hero: Codable {
        let id: Int
        let name: String
        let description: String
        let thumbnail: Thumbnail
        let urls: [HeroUrl]
    }


    struct Thumbnail: Codable{

        let path: String
        let ext: String
        
        var url: String {
            return path + "." + ext
        }
        // Devido extension ser uma palavra reservada, e ser necessário pegar uma variavel com o mesmo nome no arquivo JSON devolvido pelo servidor, foi criado o enum.
        //CodingKey - Um tipo que pode ser usado como uma chave para codificação e decodificação.
        enum CodingKeys: String, CodingKey {
            case path
            // "De - Para" ... Nome da variavel = Nome da propriedade no JSON
            case ext = "extension"
        }
    }

    struct HeroUrl: Codable{
        let type: String
        let url: String
    }
    

