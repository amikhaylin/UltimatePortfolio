//
//  UnlockManager.swift
//  UltimatePortfolio
//
//  Created by Andrey Mikhaylin on 19.08.2021.
//

import Combine
import StoreKit

class UnlockManager: NSObject, ObservableObject, SKPaymentTransactionObserver, SKProductsRequestDelegate {
    enum RequestState {
        case loading
        case loaded(SKProduct)
        case failed(Error?)
        case purchased
        case deferred
    }
    
    private enum StoreError: Error {
        case invalidIdentifiers, missingProduct
    }
    
    @Published var requestState = RequestState.loading
    private let dataController: DataController
    private let request: SKProductsRequest
    private var loadedProducts = [SKProduct]()
    
    var canMakePayment: Bool {
        SKPaymentQueue.canMakePayments()
    }

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        DispatchQueue.main.async { [self] in
            for transaction in transactions {
                switch transaction.transactionState {
                case .purchased, .restored:
                    self.dataController.fullVersionUnlocked = true
                    self.requestState = .purchased
                    queue.finishTransaction(transaction)
                    
                case .failed:
                    if let product = loadedProducts.first {
                        self.requestState = .loaded(product)
                    } else {
                        self.requestState = .failed(transaction.error)
                    }
                    
                    queue.finishTransaction(transaction)
                    
                case .deferred:
                    self.requestState = .deferred
                    
                default:
                    break
                }
            }
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            self.loadedProducts = response.products
            
            guard let unlock = self.loadedProducts.first else {
                self.requestState = .failed(StoreError.missingProduct)
                return
            }
            
            if response.invalidProductIdentifiers.isEmpty == false {
                print("ALERT: Received invalid product identifiers: \(response.invalidProductIdentifiers)")
                self.requestState = .failed(StoreError.invalidIdentifiers)
                return
            }
            
            self.requestState = .loaded(unlock)
        }
    }
    
    func buy(product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func restore() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    init(dataController: DataController) {
        self.dataController = dataController
        
        // Prepare to our product
        let productIDs = Set(["com.amikhaylin.UltimatePortfolioApp.unlock"])
        request = SKProductsRequest(productIdentifiers: productIDs)
        
        super.init()
        
        // Start payment queue
        SKPaymentQueue.default().add(self)
        
        guard dataController.fullVersionUnlocked == false else {
            return
        }
        
        request.delegate = self
        
        request.start()
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }
}
