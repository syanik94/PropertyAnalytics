//
//  FirestoreService.swift
//  PropertyAnalytics
//
//  Created by Yanik Simpson on 11/13/19.
//  Copyright © 2019 Yanik Simpson. All rights reserved.
//

import Foundation
import Firebase

class FirestoreService {
    typealias FirestoreFetchCompletion<T> = (Result<[T],Error>) -> Void

    enum Collection: String {
        case city
        case trends
        case users
    }
    
    let db = Firestore.firestore()

    func fetch(from collection: Collection, completion: @escaping FirestoreFetchCompletion<Any>) {
        let collectionPath = collection.rawValue
        db.collection(collectionPath).getDocuments { (snapshot, err) in
            if let error = err {
                completion(.failure(error))
            } else {
                var fetchedData = [Any]()
                for document in snapshot!.documents {
                    fetchedData.append(document)
                }
                completion(.success(fetchedData))
            }
        }
    }
}
