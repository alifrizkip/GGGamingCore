//
//  File.swift
//
//
//  Created by alip on 28/11/21.
//

public protocol Mapper {
  associatedtype Response
  associatedtype Domain
  associatedtype Presentation

  func transformResponseToDomain(response: Response) -> Domain
  func transformDomainToPresentation(domain: Domain) -> Presentation
}
