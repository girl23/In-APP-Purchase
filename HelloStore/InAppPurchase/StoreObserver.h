//
//  StoreObserver.h
//  HelloStore
//
//  Created by zhouli on 13-8-4.
//  Copyright (c) 2013年 zhouli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import <StoreKit/SKPaymentTransaction.h>
#import <UIKit/UIKit.h>
#import "VdouController.h"
#define kProductsLoadedNotification         @"ProductsLoaded"
#define kProductPurchaseFailedNotification  @"ProductPurchaseFailed"
#define kProductPurchasedNotification       @"ProductPurchased"
#define kProductPurchasedButtonOpenNotification  @"ButtonOpen"
@interface StoreObserver : NSObject <SKPaymentTransactionObserver, SKProductsRequestDelegate>
{
    int buyType;
}

-(void)Create;
-(void)Destroy;

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;
-(void)PurchasedTransaction: (SKPaymentTransaction *)transaction;
-(void)completeTransaction: (SKPaymentTransaction *)transaction;
-(void)failedTransaction: (SKPaymentTransaction *)transaction;
-(void)paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction;
-(void)paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error;

-(void)Buy:(int)type;
-(bool)CanMakePay;
-(void)RequestProductData;
-(void)restoreTransaction: (SKPaymentTransaction *)transaction;

-(void)addProductToPaymentQueue:(int)ProductType;
+(StoreObserver *)shareStoreObserver;
@end