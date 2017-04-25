//
//  VdouController.m
//  MicroClassroom
//
//  Created by wdwk on 15/10/23.
//  Copyright (c) 2015年 FeiGuangpu. All rights reserved.
//

#import "VdouController.h"
#import "StoreObserver.h"

#define kProductsLoadedNotification         @"ProductsLoaded"
#define kProductPurchaseFailedNotification  @"ProductPurchaseFailed"
#define kProductPurchasedNotification       @"ProductPurchased"
#define kProductPurchasedButtonOpenNotification  @"ButtonOpen"
#define BUTTONTAGBEGIN 1000

@interface VdouController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *VdouCountLabel;

@property (retain, nonatomic) IBOutlet UIButton *buy1;

@property (retain, nonatomic) IBOutlet UIButton *buy2;

@property (retain, nonatomic) IBOutlet UIButton *buy3;

@property (retain, nonatomic) IBOutlet UIButton *buy4;

@property (retain, nonatomic) IBOutlet UIButton *buy5;

@property (retain, nonatomic) IBOutlet UIButton *buy6;

@property (retain, nonatomic) IBOutlet UIButton *buy7;

@property StoreObserver* observer;
@property(nonatomic,strong)UIImageView * coverImageView;
@property(nonatomic,assign)int productFlag;
//@property(nonatomic,strong)SKProduct * product;

@end

@implementation VdouController
- (void)viewDidLoad {
    
    [super viewDidLoad];
     _productFlag=1;
     self.observer=[StoreObserver shareStoreObserver];
    [self.observer Create];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productsLoaded:) name:kProductsLoadedNotification object:nil];

    
    _coverImageView =[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _coverImageView.backgroundColor= [UIColor yellowColor];
    _coverImageView.alpha=0.4;
    [self.view addSubview:_coverImageView];
    _coverImageView.hidden=YES;
   
    [self setMyCount];
    [self initNavButtons];
}

-(void)setMyCount{

    self.nameLabel.text=@"zzzzz";//[MCUserInfoManager shareManager].nickName;
   // if (_balaceModel.balance!= nil) {
      //  CGFloat value = [_balaceModel.balance doubleValue];
        NSString *tem = [NSString stringWithFormat:@"%.2f",0.0];
        self.VdouCountLabel.text=tem;
  //  }
    
}
-(void)initNavButtons
{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.showsTouchWhenHighlighted = YES;
    backBtn.frame = CGRectMake(0, 0, 50, 40);
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"arrow-left.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 32)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:self
                                                                               action:nil];
    flexSpacer.width = -10;
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:flexSpacer,item, nil]];
    
   // UILabel* titleLabel = [MCCustomizeControl customizeLabel:@"充值" backgroundColor:[UIColor clearColor] font:[UIFont boldSystemFontOfSize:MC_NAVBAR_TITLE_FONT_SIZE] textColor:[UIColor colorWithHexString:@"#f3f3f3"] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
    
    UILabel * titleLabel=[[UILabel alloc]init];
    titleLabel.frame=CGRectMake(0, 0, 200, 30);
    titleLabel.backgroundColor=[UIColor yellowColor];
    titleLabel.text=@"充值";
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    
    self.navigationItem.titleView = titleLabel;
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{

    
//  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchaseFailed:) name:kProductPurchaseFailedNotification object:nil];
    
    
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:kProductPurchasedNotification object:nil];
    
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ButtonOpen:) name:kProductPurchasedButtonOpenNotification object:nil];
    
}
-(void)ButtonOpen:(NSNotification * )notification
{
    _coverImageView.hidden=YES;
    [self ManagerTheBuyButton];
}
-(void)productsLoaded:(NSNotification*)notification{
    
    NSLog(@"object%@",notification.object);
    SKProduct *  skproduct =notification.object;
   
        switch (_productFlag) {
            case 1:

                _product1.text=skproduct.localizedTitle;
                [_buy1 setTitle:[NSString stringWithFormat:@"￥%@.00",skproduct.price]  forState:UIControlStateNormal];

                break;
            case 2:
                _product2.text=skproduct.localizedTitle;
                [_buy2 setTitle: [NSString stringWithFormat:@"￥%@.00",skproduct.price]  forState:UIControlStateNormal];

                break;
            case 3:
                _product3.text=skproduct.localizedTitle;
                [_buy3 setTitle: [NSString stringWithFormat:@"￥%@.00",skproduct.price]  forState:UIControlStateNormal];

                break;
            case 4:
                _product4.text=skproduct.localizedTitle;
                [_buy4 setTitle: [NSString stringWithFormat:@"￥%@.00",skproduct.price]  forState:UIControlStateNormal];

                break;
            case 5:
                _product5.text=skproduct.localizedTitle;
                [_buy5 setTitle: [NSString stringWithFormat:@"￥%@.00",skproduct.price]  forState:UIControlStateNormal];

                break;
            case 6:
                _product6.text=skproduct.localizedTitle;
                [_buy6 setTitle: [NSString stringWithFormat:@"￥%@.00",skproduct.price]  forState:UIControlStateNormal];

                break;
            case 7:
                _product7.text=skproduct.localizedTitle;
                [_buy7 setTitle: [NSString stringWithFormat:@"￥%@.00",skproduct.price]  forState:UIControlStateNormal];
                break;
            default:
                break;
        }

   
    _productFlag++;
}
//-(void)productPurchaseFailed:(NSNotification*)notification{
//
//}

-(void)productPurchased:(NSNotification *)notification {
    
    NSLog(@"完成购买的通知%@",notification.object);
    
    NSString * proid=notification.object;
    
    if ([proid isEqualToString:@"com.HelloStorTest.TestItem"]) {
        
        _VdouCountLabel.text=[NSString stringWithFormat:@"%.2f",[_VdouCountLabel.text floatValue]+6 ];
        
    }
    else if ([proid isEqualToString:@"com.HelloStorTest1.TestItem"])
    {
        _VdouCountLabel.text=[NSString stringWithFormat:@"%.2f",[_VdouCountLabel.text floatValue]+12 ];
    }
    
    else if ([proid isEqualToString:@"com.HelloStorTest2.TestItem"])
    {
        _VdouCountLabel.text=[NSString stringWithFormat:@"%.2f",[_VdouCountLabel.text floatValue]+30 ];
    }
    else if ([proid isEqualToString:@"com.HelloStorTest3.TestItem"])
    {
        _VdouCountLabel.text=[NSString stringWithFormat:@"%.2f",[_VdouCountLabel.text floatValue]+60 ];
    }
    else if ([proid isEqualToString:@"com.HelloStorTest4.TestItem"])
    {
        _VdouCountLabel.text=[NSString stringWithFormat:@"%.2f",[_VdouCountLabel.text floatValue]+90 ];
    }
    else if ([proid isEqualToString:@"com.HelloStorTest5.TestItem"])
    {
        _VdouCountLabel.text=[NSString stringWithFormat:@"%.2f",[_VdouCountLabel.text floatValue]+120 ];
    }
    else if ([proid isEqualToString:@"com.HelloStorTest6.TestItem"])
    {
        _VdouCountLabel.text=[NSString stringWithFormat:@"%.2f",[_VdouCountLabel.text floatValue]+150];
    }
    
    _coverImageView.hidden=YES;
    [self ManagerTheBuyButton];
}
-(void)viewWillDisappear:(BOOL)animated{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:kProductsLoadedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kProductPurchasedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kProductPurchaseFailedNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kProductPurchasedButtonOpenNotification object:nil];
}

- (void)viewDidUnload
{
        [self.observer Destroy];
       // [self.observer release];
}


#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 90;
    }else{
        return 20;
    }
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"我的账户";
    }else{
        return @"可选的V豆";
    }
}

-(void)ManagerTheBuyButton
{
    
    if (_coverImageView.hidden==NO) {
      //禁用按钮；
        _buy1.enabled=NO;
        _buy2.enabled=NO;
        _buy3.enabled=NO;
        _buy4.enabled=NO;
        _buy5.enabled=NO;
        _buy6.enabled=NO;
        _buy7.enabled=NO;

    }
    else
    {
        //启用购买按钮；
        _buy1.enabled=YES;
        _buy2.enabled=YES;
        _buy3.enabled=YES;
        _buy4.enabled=YES;
        _buy5.enabled=YES;
        _buy6.enabled=YES;
        _buy7.enabled=YES;
    }
}

#pragma mark in-app purchase
- (IBAction)payClick:(UIButton*)button {
    
    [self.observer Buy:0];
    //self.observer addProductToPaymentQueue];
    int productType=(int)button.tag-BUTTONTAGBEGIN;
    [self.observer addProductToPaymentQueue:productType];
     _coverImageView.hidden=NO;
     _coverImageView.userInteractionEnabled=NO;
    [self ManagerTheBuyButton];
//    SKProduct *product = [[InAppRageIAPHelper sharedHelper].products objectAtIndex:button.tag];
//    [[InAppRageIAPHelper sharedHelper] buyProductIdentifier:product.productIdentifier];
//    [self performSelector:@selector(timeout:) withObject:nil afterDelay:30.0];
//   

}
- (void)timeout:(id)arg {
//    [MBProgressHUD hideActivityToView:self.view];
//    [MBProgressHUD showError:@"连接超时，请检查您的网络"];
}

//- (void)dealloc {
//    [super dealloc];
//}

- (void)dealloc {
 
    //[super dealloc];
}
@end
