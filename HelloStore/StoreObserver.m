//
//  StoreObserver.m
//  HelloStore
//
//  Created by wdwk on 15/12/29..
//  Copyright (c) 2015年 wdwk. All rights reserved.
//
#import "StoreObserver.h"
#import "VdouController.h"
#import "StoreObserver.h"

#define ProductID  @"com.HelloStorTest.TestItem"	//6//1 产品ID，对应iTunes Connect中设置的产品ID
#define ProductID1 @"com.HelloStorTest1.TestItem"   //12／／12元2
#define ProductID2 @"com.HelloStorTest2.TestItem"   //30／／30元5
#define ProductID3 @"com.HelloStorTest3.TestItem"   //60／／60元10

#define ProductID4 @"com.HelloStorTest4.TestItem"   //90／／88元13
#define ProductID5 @"com.HelloStorTest5.TestItem"   //120／／118元18
#define ProductID6 @"com.HelloStorTest6.TestItem"   //150／／148元22
@implementation StoreObserver

static StoreObserver * _storeOb=nil;

+(StoreObserver *)shareStoreObserver
{
 
        if (_storeOb==nil) {
            _storeOb=[[StoreObserver alloc]init];
        }
    
    return _storeOb;
    
}

-(void)Create
{
    //---------------------
    //----监听购买结果//1
    NSLog(@"监听购买结果//1");
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

-(void)Destroy
{
    //解除监听
     NSLog(@"解除监听");
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    
}

-(void)Buy:(int)type
{
    buyType = type;
    
    if ([self CanMakePay])
    {
        NSLog(@"允许程序内付费购买");
        [self RequestProductData];
    }
    else
    {
        NSLog(@"不允许程序内付费购买");        
    }
}

-(bool)CanMakePay
{
    //2
    return [SKPaymentQueue canMakePayments];
}

//3
-(void)RequestProductData
{
    
    NSLog(@"---------请求对应的产品信息------------");
    NSArray *product = nil;
    // 这时可以根据buyType不同选择不同的商品，这个只是测试，只用了一种
    product=[[NSArray alloc] initWithObjects:ProductID,ProductID1,ProductID2,ProductID3,ProductID4,ProductID5,ProductID6,nil];
    
    NSSet *nsset = [NSSet setWithArray:product];
    
    SKProductsRequest *request=[[SKProductsRequest alloc] initWithProductIdentifiers: nsset];
    
    request.delegate=self;
    
    [request start];
    
   // [product release];
    
}

//<SKProductsRequestDelegate> 请求协议
//收到的产品信息
//4
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    
    NSLog(@"-----------收到产品反馈信息--------------");
    
    NSArray *myProduct = response.products;
    
    NSLog(@"无效产品Product ID:%@",response.invalidProductIdentifiers);
    
   // NSLog(@"产品付费数量: %lu", (unsigned long)[myProduct count]);
    if (myProduct.count==0) {
        NSLog(@"无法获取产品信息，购买失败");
        return;
    }
    // populate UI
    for(SKProduct *product in myProduct){
       // NSLog(@"product info");
        NSLog(@"SKProduct 描述信息%@", [product description]);
        NSLog(@"产品标题 %@" , product.localizedTitle);
        NSLog(@"产品描述信息: %@" , product.localizedDescription);
        NSLog(@"价格: %@" , product.price);
        NSLog(@"Product id: %@" , product.productIdentifier);
        //发送通知
      // [[NSNotificationCenter defaultCenter] postNotificationName:kProductsLoadedNotification object:product];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kProductsLoadedNotification object:myProduct];
    
    NSLog(@"-----------收到产品反馈信息--------------");
    
}

-(void)addProductToPaymentQueue:(int)ProductType
{
    
    SKPayment *payment = nil;
    switch (ProductType) {
        case 1:
            //5
            payment  = [SKPayment paymentWithProductIdentifier:ProductID];
            NSLog(@"---------发送购买请求------------");
            [[SKPaymentQueue defaultQueue] addPayment:payment];

            break;
        case 2:
            //5
            payment  = [SKPayment paymentWithProductIdentifier:ProductID1];
            NSLog(@"---------发送购买请求1------------");
            [[SKPaymentQueue defaultQueue] addPayment:payment];

            break;
        case 3:
            //5
            payment  = [SKPayment paymentWithProductIdentifier:ProductID2];
            NSLog(@"---------发送购买请求2------------");
            [[SKPaymentQueue defaultQueue] addPayment:payment];

            break;
        case 4:
            //5
            payment  = [SKPayment paymentWithProductIdentifier:ProductID3];
            NSLog(@"---------发送购买请求3------------");
            [[SKPaymentQueue defaultQueue] addPayment:payment];

            break;
        case 5:
            //5
            payment  = [SKPayment paymentWithProductIdentifier:ProductID4];
            NSLog(@"---------发送购买请求4------------");
            [[SKPaymentQueue defaultQueue] addPayment:payment];

            break;
        case 6:
            //5
            payment  = [SKPayment paymentWithProductIdentifier:ProductID5];
            NSLog(@"---------发送购买请求5------------");
            [[SKPaymentQueue defaultQueue] addPayment:payment];

            break;
        case 7:
            //5
            payment  = [SKPayment paymentWithProductIdentifier:ProductID6];
            NSLog(@"---------发送购买请求6------------");
            [[SKPaymentQueue defaultQueue] addPayment:payment];
            break;
            
        default:
            break;
    }
    
    
}
- (void)requestProUpgradeProductData
{
    
    NSLog(@"------请求升级数据---------");
    NSSet *productIdentifiers = [NSSet setWithObject:@"com.productid"];
    SKProductsRequest* productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
    
}
//弹出错误信息
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"%@",error.localizedDescription);
    NSLog(@"-------弹出错误信息----------");
}

//如果没有设置监听购买结果将直接跳至反馈结束；
-(void) requestDidFinish:(SKRequest *)request
{
    NSLog(@"----------反馈信息结束--------------");
    
   [[NSNotificationCenter defaultCenter] postNotificationName:kProductPurchasedButtonOpenNotification object:@"noObserver"];
    
}

-(void) PurchasedTransaction: (SKPaymentTransaction *)transaction
{
    NSLog(@"-----PurchasedTransaction----");
    NSArray *transactions =[[NSArray alloc] initWithObjects:transaction, nil];
    [self paymentQueue:[SKPaymentQueue defaultQueue] updatedTransactions:transactions];
   // [transactions release];
}

//<SKPaymentTransactionObserver> 千万不要忘记绑定，代码如下：
//----监听购买结果
//[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
//6
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions//交易结果
{
    
    NSLog(@"-----paymentQueue  updatedTransactions,购买结果--------");
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
          
            case SKPaymentTransactionStatePurchasing:      //点击购买按钮添加支付队列，商品添加进列表
                //Update your UI to reflect the in-progress status, and wait to be called again.
                NSLog(@"-----商品添加进列表 --------");
                break;
            case SKPaymentTransactionStateDeferred:
                //Update your UI to reflect the deferred status, and wait to be called again.
                NSLog(@"-----交易延期—－－－－");
                break;
            case SKPaymentTransactionStatePurchased://交易完成
                [self completeTransaction:transaction];
                NSLog(@"-----交易完成 --------");
                break;
            case SKPaymentTransactionStateFailed://交易失败
                [self failedTransaction:transaction];
                NSLog(@"-----交易失败 --------");
                break;
            case SKPaymentTransactionStateRestored://已经购买过该商品
                [self restoreTransaction:transaction];
                NSLog(@"-----已经购买过该商品 --------");
                
            default:
                break;
        }
    }
}
- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"openButton" object:nil];
    
    NSString * str=[[NSString alloc]initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
    
    NSString *environment=[self environmentForReceipt:str];
        NSLog(@"----- 完成交易调用的方法completeTransaction 1--------%@",environment);
   
    // 接受到的App Store验证字符串，这里需要经过JSON编码
//   //收据编码方法一；
//    NSString* jsonObjectString = [self encode:(uint8_t *)transaction.transactionReceipt.bytes length:transaction.transactionReceipt.length];
//    
//    NSLog(@"接受到64编码后的App Store验证字符串,将收据进行编码，传入收据的二进制数据，和收据的长度，这里需要经过JSON编码%@",str);
//    
//    // 以下为测试POST到itunes上验证，正常来说，装jsonObjectString发给服务器，由服务器来完成验证
//    
//    NSString* sendString = [[NSString alloc] initWithFormat:@"{\"receipt-data\":\"%@\"}",jsonObjectString];
//    
    //收据编码方法二；
    // 验证凭据，获取到苹果返回的交易凭据
    // appStoreReceiptURL iOS7.0增加的，购买交易完成后，会将凭据存放在该地址
     NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    // 从沙盒中获取到购买凭据
     NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    /**
     20      BASE64 常用的编码方案，通常用于数据传输，以及加密算法的基础算法，传输过程中能够保证数据传输的稳定性
     21      BASE64是可以编码和解码的
     22      */
     NSString *encodeStr = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSString *sendString = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", encodeStr];
    NSLog(@"_____%@",sendString);
    NSURL *StoreURL=nil;
    if ([environment isEqualToString:@"environment=Sandbox"]) {
        
         StoreURL= [[NSURL alloc] initWithString: @"https://sandbox.itunes.apple.com/verifyReceipt"];
    }
    else{
        
        StoreURL= [[NSURL alloc] initWithString: @"https://buy.itunes.apple.com/verifyReceipt"];
    }
       //这个二进制数据由服务器进行验证；zl
	 NSData *postData = [NSData dataWithBytes:[sendString UTF8String] length:[sendString length]];
    
    
    NSLog(@"++++++%@",postData);
    
    
    
	 NSMutableURLRequest *connectionRequest = [NSMutableURLRequest requestWithURL:StoreURL];
    
	[connectionRequest setHTTPMethod:@"POST"];
	[connectionRequest setTimeoutInterval:50.0];//120.0---50.0zl
    [connectionRequest setCachePolicy:NSURLRequestUseProtocolCachePolicy];
	[connectionRequest setHTTPBody:postData];
//
//	[[SKPaymentQueue defaultQueue] finishTransaction: transaction];
	
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:connectionRequest delegate:self];
	//[connection release];
    
    
    // Your application should implement these two methods.
    
    NSString *product = transaction.payment.productIdentifier;
    
    NSLog(@"transaction.payment.productIdentifier++++%@",product);
    
    if ([product length] > 0)
    {
        NSArray *tt = [product componentsSeparatedByString:@"."];
        
        NSString *bookid = [tt lastObject];
        
        if([bookid length] > 0)
        {
        
            NSLog(@"打印bookid%@",bookid);
        }
    }
    //在此做交易记录
    // Remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
   
}
//收据的环境判断；
-(NSString * )environmentForReceipt:(NSString * )str
{
    str= [str stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    str = [str stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    str=[str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    str=[str stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    NSArray * arr=[str componentsSeparatedByString:@";"];
    
    //存储收据环境的变量
    NSString * environment=arr[2];
    return environment;
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
    
    NSLog(@"交易失败2");
    if (transaction.error.code == SKErrorPaymentCancelled)
    {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提 示" message:@"你已取消购买"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else if(transaction.error.code==SKErrorPaymentInvalid)
    {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提 示" message:@"支付无效"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];

    }
    else if(transaction.error.code==SKErrorPaymentNotAllowed)
    {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提 示" message:@"不允许支付"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    }
    else if(transaction.error.code==SKErrorStoreProductNotAvailable)
    {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提 示" message:@"产品无效"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    }
    else if(transaction.error.code==SKErrorClientInvalid)
    {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"提 示" message:@"客服端无效"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    }



    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
   // [[NSNotificationCenter defaultCenter] postNotificationName:kProductPurchasedButtonOpenNotification object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"openButton" object:nil];

    
}
-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction
{
    NSLog(@"paymentQueueRestoreCompletedTransactionFinishied方法");
    
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"openButton" object:nil];
    //
    NSLog(@"已经购买过该商品 --- 交易恢复处理");
    
}

-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    NSLog(@"-------paymentQueue，restoreCompletedTransactionsFailedWithError----");
}

// JSON编码
- (NSString *)encode:(const uint8_t *)input length:(NSInteger)length
{
    NSLog(@"JSON64编码");
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData *data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    
    uint8_t *output = (uint8_t *)data.mutableBytes;
    
    for (NSInteger i = 0; i < length; i += 3) {
        
        NSInteger value = 0;
        
        for (NSInteger j = i; j < (i + 3); j++) {
            
            value <<= 8;
            
            if (j < length) {
                
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger index = (i / 3) * 4;
        output[index + 0] =                    table[(value >> 18) & 0x3F];
        output[index + 1] =                    table[(value >> 12) & 0x3F];
        output[index + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[index + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
        
    }
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
   // return [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
}

// 以下是HTTP协议的监听，若由服务器验证，可不用这段代码
#pragma mark connection delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    //进行二次验证；
   // NSLog(@" 以下是HTTP协议的监听，若由服务器验证，可不用这段代码%@",  [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]);
    NSLog(@" 以下是HTTP协议的监听，若由服务器验证，可不用这段代码%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSDictionary * dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    
    NSNumber *status=dic[@"status"];
     NSDictionary * receiptDic=dic[@"receipt"];
//    NSString *purchased=receiptDic[@"product_id"];
    NSArray * tempArr=receiptDic[@"in_app"];
    
    NSString * purchased=nil;
    for (int i=0 ; i<tempArr.count; i++) {
        NSDictionary * tempPurchase=tempArr[i];
        purchased=tempPurchase[@"product_id"];
    }
    if (status.intValue==0) {
        // 发送通知更改账户V豆的数量；
        [[NSNotificationCenter defaultCenter] postNotificationName:kProductPurchasedNotification object:purchased];
    }
    else
    {
        NSLog(@"收据校验失败");
        
        switch (status.intValue) {
            case 21000:
                NSLog(@"App Store不能读取你提供的JSON对象");
                break;
            case 21002:
                NSLog(@"receipt-data域的数据有问题");
                break;
            case 21003:
                NSLog(@"receipt无法通过验证");
                break;
            case 21004:
                NSLog(@"提供的shared secret不匹配你账号中的shared secret");
                break;
            case 21005:
                NSLog(@"receipt服务器当前不可用");
                break;
            case 21006:
                NSLog(@"receipt合法，但是订阅已过期。服务器接收到这个状态码时，receipt数据仍然会解码并一起发送");
                break;
            case 21007:
                NSLog(@"receipt是Sandbox receipt，但却发送至生产系统的验证服务");
                break;
            case 21008:
                NSLog(@"receipt是生产receipt，但却发送至Sandbox环境的验证服务");
                break;
            default:
                break;
        }
        
    }
    NSLog(@"%@",dic[@"status"]);
   
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSLog(@" 以下是HTTP协议的监听，若由服务器验证，可不用这段代码");
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@" 以下是HTTP协议的监听，若由服务器验证，可不用这段代码");
    NSLog(@"%@+++",response);
    switch([(NSHTTPURLResponse *)response statusCode]) {
            
        case 200:
            NSLog(@"200------");
            break;
        case 206:
              NSLog(@"206------");
            break;
        case 304:
              NSLog(@"304------");
            break;
        case 400:
              NSLog(@"400------");
            break;
        case 404:
              NSLog(@"404------");
            break;
        case 416:
              NSLog(@"416------");
            break;
        case 403:
              NSLog(@"403------");
            break;
        case 401:
              NSLog(@"401------");
        case 500:
              NSLog(@"500------");
            break;
        default:
            break;
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@" 以下是HTTP协议的监听，若由服务器验证，可不用这段代码test");
}


@end