//
//  ProductTableViewCell.m
//  MicroClassroom
//
//  Created by wdwk on 15/12/30.
//  Copyright © 2015年 FeiGuangpu. All rights reserved.
//

#import "ProductTableViewCell.h"

@implementation ProductTableViewCell
-(void)closeButton
{_productPriceButton.enabled=NO;}
-(void)openButton
{_productPriceButton.enabled=YES;}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeButton) name:@"closeButton" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openButton) name:@"openButton" object:nil];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeButton) name:@"closeButton" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openButton) name:@"openButton" object:nil];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeButton) name:@"closeButton" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openButton) name:@"openButton" object:nil];
    }
    return self;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeButton) name:@"closeButton" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openButton) name:@"openButton" object:nil];
    }
    return self;
}
-(void)setModel:(ProductModel *)model
{
     _productTitleLable.text=model.productTitle;
    [_productPriceButton setTitle:model.productPrice forState:UIControlStateNormal];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
