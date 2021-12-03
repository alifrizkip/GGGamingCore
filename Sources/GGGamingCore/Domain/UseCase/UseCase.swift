//
//  File.swift
//  
//
//  Created by alip on 30/11/21.
//

import Combine

public protocol UseCase {
  associatedtype Request
  associatedtype Response

  func execute(request: Request?) -> AnyPublisher<Response, Error>
}
