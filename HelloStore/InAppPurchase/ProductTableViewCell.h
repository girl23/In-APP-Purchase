//
//  ProductTableViewCell.h
//  MicroClassroom
//
//  Created by wdwk on 15/12/30.
//  Copyright © 2015年 FeiGuangpu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
@interface ProductTableViewCell : UITableViewCell
@property(nonatomic,strong)ProductModel * model;

@property (weak, nonatomic) IBOutlet UILabel *productTitleLable;

@property (weak, nonatomic) IBOutlet UIButton *productPriceButton;

@end
