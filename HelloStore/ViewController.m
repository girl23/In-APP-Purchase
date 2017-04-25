//
//  ViewController.m
//  HelloStore
//
//  Created by wdwk on 15/12/29.
//  Copyright (c) 2015年 wdwk. All rights reserved.
//

#import "ViewController.h"
#import "StoreObserver.h"
#import "VdouController.h"

@interface ViewController ()<UIAlertViewDelegate>

@property StoreObserver* observer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

//    self.observer = [[StoreObserver alloc] init];
//    
//    [self.observer Create];
//    // test
//    [self.observer Buy:0];

    UIAlertView*alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的V豆余额不足，是否前往充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去充值", nil];
    [alert show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        
        self.observer=[StoreObserver shareStoreObserver];
        // [self.observer Create];
        [self.observer Buy:0];
        
//        UIStoryboard*story=[UIStoryboard storyboardWithName:@"MyVdou" bundle:[NSBundle mainBundle]];
//        VdouController*vdou=[story instantiateViewControllerWithIdentifier:@"VdouController"];
//      //  [self.navigationController pushViewController:vdou animated:YES];
//        [self presentViewController:vdou animated:YES completion:nil];
        
        PurchaseViewController * purchase=[[PurchaseViewController alloc]init];
        [self presentViewController:purchase animated:YES completion:nil];

        
    }
}
- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    
//    [self.observer Destroy];
//    [self.observer release];
    
}



@end
