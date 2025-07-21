//
//  Practice.swift
//  DreamHub
//
//  Created by Yi Ling on 7/21/25.
//

import Foundation
import SwiftUI


var jsonOut = ""

func decodeJSON() -> DreamModel? {
    guard let data = jsonOut.data(using: .utf8) else { //.data() returns a byte buffer, turning the string into a readable form for decoder
        print("Failed to convert string to data")
        return nil
    }
    
    let decoder = JSONDecoder()
    
    do {
        let dream = try decoder.decode(DreamModel.self, from: data)
        return dream
    } catch {
        print("Invalid JSON")
        return nil
    }
}


func getJSON(urlString: String) async -> DreamModel? {
    guard let url = URL(string: urlString) else { // validate url
        print("Invalid URL")
        return nil
    }
//    
//    var result1: DreamModel? = nil
//    URLSession.shared.dataTask(with: url){ (data, response, err) in
//        if err == nil {
//            guard let jsondata = data else { return }
//            do {
//                result1 = try JSONDecoder().decode(DreamModel.self, from: jsondata)
//                print("JSON download successful!")
//            } catch {
//                print("JSON Downloading error")
//            }
//        }
//    }
//    
//    return result1
    
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        do {
            let result2 = try JSONDecoder().decode(DreamModel.self, from: data)
            print("JSON download successful!")
            return result2
        } catch {
            print("JSON Downloading error")
            return nil
        }
    } catch {
        print("JSON Downloading error")
        return nil
    }
}

func getJ(urlString: String) async -> DreamModel? {
    guard let url = URL(string: urlString) else {
        print("Fail to resolve url")
        return nil
    }
    
//    var result1: DreamModel? = nil
//    URLSession.shared.dataTask(with: url) { (data, response, error) in
//        if error == nil {
//            guard let jsonData = data else { return }
//            
//            do {
//                var result1 = try JSONDecoder().decode(DreamModel.self, from: jsonData)
//            } catch {
//                print("Invalid json")
//            }
//            
//        } else {
//            print("Network error")
//        }
//    }
//    
//    return result1
    
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        do {
            let result2 = try JSONDecoder().decode(DreamModel.self, from: data)
            return result2
        } catch {
            print("Invalid json")
            return nil
        }
        
    } catch {
        print("Network error")
        return nil
    }
}

