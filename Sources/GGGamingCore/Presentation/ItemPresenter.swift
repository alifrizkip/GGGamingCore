//
//  File.swift
//  
//
//  Created by alip on 28/11/21.
//

import Foundation
import Combine

public class ItemPresenter<Request, Response, Interactor: UseCase>: ObservableObject
where Interactor.Request == Request, Interactor.Response == Response {
  private var cancellables: Set<AnyCancellable> = []

  private let useCase: Interactor
  public let itemID: Request

  @Published public var item: Response?
  @Published public var errorMessage: String?
  @Published public var isLoading: Bool = false

  public init(useCase: Interactor, itemID: Request) {
    self.useCase = useCase
    self.itemID = itemID
  }

  public func execute() {
    isLoading = true
    errorMessage = nil
    useCase.execute(request: itemID)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
        case .finished: break
        }
        self.isLoading = false
      }, receiveValue: { item in
        self.item = item
      })
      .store(in: &cancellables)
  }
}
