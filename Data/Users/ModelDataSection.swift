//
//  ModelDataSection.swift
//  StarNews
//
//  Created by daud daud on 27/04/25.
//

struct Article: Decodable {
    let id: String
    let title: String
    let newsSite: String
    let imageUrl: String
    let summary: String
}

struct Blog: Decodable {
    let id: String
    let title: String
    let newsSite: String
    let imageUrl: String
    let summary: String
}

struct Report: Decodable {
    let id: String
    let title: String
    let newsSite: String
    let imageUrl: String
    let summary: String
}
