//
//  ZLControl.m
//  8061
//
//  Created by wdwk on 15/9/6.
//  Copyright (c) 2015年 pro. All rights reserved.
//

#import "ZLControl.h"

@implementation ZLControl

//创建label中心点布局
+(UILabel*)createLabelWithtextColor:(UIColor*)color frame:(CGRect)frame point:(CGPoint)point font:(UIFont*)font backGroundColor:(UIColor*)color1 TextAlignment:(NSTextAlignment)textAlignment text:(NSString*)text{
    
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.center=point;
    label.text = text;
    label.textColor = color;
    label.backgroundColor = color1;
    label.font = font;
    label.textAlignment = textAlignment;
    
    label.userInteractionEnabled = YES;
    return label;
}
//UIimageView
+(UIImageView*)createImageViewWith:(NSString*)imageName frame:(CGRect)frame Point:(CGPoint)point{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.center=point;
    imageView.image = [UIImage imageNamed:imageName];
    imageView.userInteractionEnabled = YES;
    return imageView;
}

//Uibutton
+(UIButton*)createButtonWithtitleColor:(UIColor*)titleColor target:(id)target sel:(SEL)sel event:(UIControlEvents)event backGroundImage:(NSString*)imageName image:(NSString*)imageName1 backGrondColor:(UIColor*)color font:(UIFont*)font frame:(CGRect)frame point:(CGPoint)point title:(NSString*)title{
    
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = frame;
    bt.center=point;
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:titleColor forState:UIControlStateNormal];
    bt.backgroundColor = color;
    bt.titleLabel.font = font;
    [bt setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [bt setImage:[UIImage imageNamed:imageName1] forState:UIControlStateNormal];
    [bt addTarget:target action:sel forControlEvents:event];
    return bt;
}


+(UITextField*)createTextFieldfont:(UIFont*)font frame:(CGRect)frame point:(CGPoint)point secureEntry:(BOOL)yesorno clearButtonMode:(UITextFieldViewMode)clearbuttonMode TextAlignment:(NSTextAlignment)textAlignment placehoder:(NSString*)placehoder text:(NSString*)text textColor:(UIColor*)color

{
    UITextField * textfield=[[UITextField alloc ]initWithFrame:frame];
    textfield.center=point;
    textfield.secureTextEntry=yesorno;
    textfield.clearButtonMode=clearbuttonMode;
    textfield.textAlignment=textAlignment;
    textfield.placeholder=placehoder;
    textfield.text=text;
    textfield.textColor=color;
    return textfield;
}



//非中心点布局

+(UILabel*)createzlLabelWithtextColor:(UIColor*)color frame:(CGRect)frame font:(UIFont*)font backGroundColor:(UIColor*)color1 TextAlignment:(NSTextAlignment)textAlignment text:(NSString*)text
{
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.textColor = color;
    label.backgroundColor = color1;
    label.font = font;
    label.textAlignment = textAlignment;
    label.userInteractionEnabled = YES;
    return label;
}

+(UIImageView*)createzlImageViewWith:(NSString*)imageName frame:(CGRect)frame
{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.userInteractionEnabled = YES;
    return imageView;

}

+(UIButton*)createzlButtonWithtitleColor:(UIColor*)titleColor target:(id)target sel:(SEL)sel event:(UIControlEvents)event backGroundImage:(NSString*)imageName image:(NSString*)imageName1 backGrondColor:(UIColor*)color font:(UIFont*)font frame:(CGRect)frame title:(NSString*)title
{
    
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = frame;
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:titleColor forState:UIControlStateNormal];
    bt.backgroundColor = color;
    bt.titleLabel.font = font;
    [bt setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [bt setImage:[UIImage imageNamed:imageName1] forState:UIControlStateNormal];
    [bt addTarget:target action:sel forControlEvents:event];
    return bt;

}

+(UITextField*)createzlTextFieldfont:(UIFont*)font frame:(CGRect)frame secureEntry:(BOOL)yesorno clearButtonMode:(UITextFieldViewMode)clearbuttonMode TextAlignment:(NSTextAlignment)textAlignment placehoder:(NSString*)placehoder text:(NSString*)text textColor:(UIColor*)color
{
    UITextField * textfield=[[UITextField alloc ]initWithFrame:frame];
    textfield.secureTextEntry=yesorno;
    textfield.clearButtonMode=clearbuttonMode;
    textfield.textAlignment=textAlignment;
    textfield.placeholder=placehoder;
    textfield.text=text;
    textfield.textColor=color;
    return textfield;
}

//判断电话号码

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    // NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    //
    NSString * WL =@"^17\\d{9}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestwl = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", WL];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestwl evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}




@end
