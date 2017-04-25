//
//  PurchaseViewController.m
//  MicroClassroom
//
//  Created by wdwk on 15/12/29.
//  Copyright © 2015年 FeiGuangpu. All rights reserved.
//

#import "PurchaseViewController.h"
#import "AcountTableViewCell.h"
#import "ProductTableViewCell.h"
#import "StoreObserver.h"
#import "ProductModel.h"
#import "ZLControl.h"

#define kProductsLoadedNotification         @"ProductsLoaded"
#define kProductPurchaseFailedNotification  @"ProductPurchaseFailed"
#define kProductPurchasedNotification       @"ProductPurchased"
#define kProductPurchasedButtonOpenNotification  @"ButtonOpen"
#define BUTTONTAGBEGIN 10000

@interface PurchaseViewController ()<UITableViewDelegate>
{
    NSMutableArray * _dataArray;
}
@property(nonatomic,strong) StoreObserver* observer;
@property(nonatomic,strong)UIButton * buyButton;


@property(nonatomic,strong)UIImageView * coverImageView;
@end
@implementation PurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _coverImageView =[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _coverImageView.backgroundColor= [UIColor yellowColor];
    _coverImageView.alpha=0.4;
    //[self.view addSubview:_coverImageView];
    [self.view.superview addSubview:_coverImageView];
    _coverImageView.hidden=YES;

     _dataArray=[[NSMutableArray alloc]init];
    self.observer=[StoreObserver shareStoreObserver];
    [self.observer Create];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productsLoaded:) name:kProductsLoadedNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:kProductPurchasedNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ButtonOpen:) name:kProductPurchasedButtonOpenNotification object:nil];
    
//    self.tableView.top=//MC_NAVBAR_HEIGHT_WITH_STATUS_BAR;
//    self.tableView.height=MC_SCREEN_HEIGHT-MC_NAVBAR_HEIGHT_WITH_STATUS_BAR;
//    self.tableView.width=self.view.size.width-20;
//    self.tableView.left=10;
    self.tableView.frame=CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-40);//self.view.frame;
    [self initNavButtons];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"AcountTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"acount"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"product"];

    
    // Do any additional setup after loading the view.
}
-(void)productsLoaded:(NSNotification*)notification{
    
    
   // NSLog(@"object%@",notification.object);
    
    [_dataArray removeAllObjects];
    NSArray * arr=notification.object;
    
    for (SKProduct * skproduct in arr) {
        
        ProductModel * model=[[ProductModel alloc]init];
        [model setProductTitle:skproduct.localizedTitle];
        [model setProductPrice:[skproduct.price stringValue]];
          [_dataArray addObject:model];
    }
    //SKProduct *  skproduct =notification.object;
    
    [self.tableView reloadData];
}
-(void)productPurchased:(NSNotification *)notification {
    
    NSLog(@"完成购买的通知%@",notification.object);
    
    NSString * product=notification.object;
    
}
-(void)ButtonOpen:(NSNotification*)notification
{
    self.tableView.userInteractionEnabled=YES;
    
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
    UILabel * titleLabel=[ZLControl createzlLabelWithtextColor:nil frame:CGRectMake(0, 0, 60, 30) font:nil backGroundColor:nil TextAlignment:NSTextAlignmentCenter text:@"充值"];
    self.navigationItem.titleView = titleLabel;
}
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark tabelView datasouce and delegate

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
        
        return @"我的账户";
    }
    else
    {
        return @"可选的V豆";
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        
        return 1;
    }
    else
    {
        //return 15;
        return _dataArray.count;//请求来产品；
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        return 80;
        
    }
    else
    {
        return 40;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        AcountTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"acount" forIndexPath:indexPath];
        
//        cell.AcountNameLabel.text=[MCUserInfoManager shareManager].nickName;
//        
//        if (_balaceModel.balance!= nil) {
//            CGFloat value = [_balaceModel.balance doubleValue];
//            NSString *tem = [NSString stringWithFormat:@"%.2f",value];
//            cell.balanceLabel.text=tem;
//        }
        cell.AcountNameLabel.text=@"zzzz";
        cell.balanceLabel.text=@"12.0";
        return cell;
    }
    else
    {
        ProductTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"product" forIndexPath:indexPath];
        
        if (_dataArray.count>0) {
            
            ProductModel * model=_dataArray[indexPath.row];
            cell.model=model;
            cell.productPriceButton.tag=BUTTONTAGBEGIN+indexPath.row+1;
            [cell.productPriceButton addTarget:self action:@selector(PayClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
}

-(void)PayClick:(UIButton * )sender
{
    NSLog(@"点击了按钮%ld",sender.tag-10000);
    [self.observer Buy:0];
    int productType=(int)sender.tag-BUTTONTAGBEGIN;
    [self.observer addProductToPaymentQueue:productType];
    
    self.tableView.userInteractionEnabled=NO;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"closeButton" object:nil];

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==1) {
        return 80;
    }
    return 0;
}
-(UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * bgView;
    
    if (section==1) {
        
       bgView=[[UIView alloc]initWithFrame:CGRectMake(0,0,320, 70)];
        bgView.backgroundColor=[UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
        UILabel * note1=[ZLControl createzlLabelWithtextColor:[UIColor grayColor] frame:CGRectMake(0, 10, 320-20, 30) font:[UIFont systemFontOfSize:12] backGroundColor:nil TextAlignment:NSTextAlignmentLeft text:@"1.由于苹果公司的限制，V豆只能在iOS端使用，安卓和电脑端不能使用"];
        note1.numberOfLines=2;
        note1.lineBreakMode=NSLineBreakByWordWrapping;
        [bgView addSubview:note1];
        UILabel * note2=[ZLControl createzlLabelWithtextColor:[UIColor grayColor] frame:CGRectMake(0, 40, 320-20, 30) font:[UIFont systemFontOfSize:12] backGroundColor:nil TextAlignment:NSTextAlignmentLeft text:@"2.V豆的使用期限为永久，充值的金额无法退回"];
        note1.numberOfLines=2;
        note1.lineBreakMode=NSLineBreakByWordWrapping;
        [bgView addSubview:note2];
        return bgView;
    }
    else
    {
        
        return bgView;
        
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        [tableView cellForRowAtIndexPath:indexPath].contentView.backgroundColor=[UIColor whiteColor];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
