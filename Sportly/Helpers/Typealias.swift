//
//  Typealias.swift
//  Sportly
//
//  Created by MN on 14.05.2023.
//

import Foundation
import Firebase

public typealias EmptyClosure = () -> ()
public typealias SimpleClosure<T> = (T) -> ()
public typealias DoubleSimpleClosure<T, A> = (T, A) -> ()
public typealias TrippleSimpleClosure<A, B, C> = (A, B, C) -> ()
public typealias DefaultClosure<T, A> = (T) -> (A)
public typealias ResultClosure<R, E: Error> = (Result<R, E>) -> ()

public typealias UserDataType = [[String: [Double]]]

public typealias HashCoded = Codable & Hashable
public typealias DictDataType = [String: [String: Any]]

public typealias FirebaseRequestClosure<R: AuthDataResult, E: Error> = (_ result: (Result<R, E>)) -> ()
public typealias FirebaseRequestUserClosure<U: FirebaseAuth.User> = (U) -> ()
