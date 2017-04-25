//
//  ZLControl.h
//  8061
//
//  Created by wdwk on 15/9/6.
//  Copyright (c) 2015年 pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLControl : UIViewController
//中心点布局
+(UILabel*)createLabelWithtextColor:(UIColor*)color frame:(CGRect)frame point:(CGPoint)point font:(UIFont*)font backGroundColor:(UIColor*)color1 TextAlignment:(NSTextAlignment)textAlignment text:(NSString*)text;

+(UIImageView*)createImageViewWith:(NSString*)imageName frame:(CGRect)frame Point:(CGPoint)point;

+(UIButton*)createButtonWithtitleColor:(UIColor*)titleColor target:(id)target sel:(SEL)sel event:(UIControlEvents)event backGroundImage:(NSString*)imageName image:(NSString*)imageName1 backGrondColor:(UIColor*)color font:(UIFont*)font frame:(CGRect)frame point:(CGPoint)point title:(NSString*)title;

+(UITextField*)createTextFieldfont:(UIFont*)font frame:(CGRect)frame point:(CGPoint)point secureEntry:(BOOL)yesorno clearButtonMode:(UITextFieldViewMode)clearbuttonMode TextAlignment:(NSTextAlignment)textAlignment placehoder:(NSString*)placehoder text:(NSString*)text textColor:(UIColor*)color;



//非中心点布局

+(UILabel*)createzlLabelWithtextColor:(UIColor*)color frame:(CGRect)frame font:(UIFont*)font backGroundColor:(UIColor*)color1 TextAlignment:(NSTextAlignment)textAlignment text:(NSString*)text;

+(UIImageView*)createzlImageViewWith:(NSString*)imageName frame:(CGRect)frame;

+(UIButton*)createzlButtonWithtitleColor:(UIColor*)titleColor target:(id)target sel:(SEL)sel event:(UIControlEvents)event backGroundImage:(NSString*)imageName image:(NSString*)imageName1 backGrondColor:(UIColor*)color font:(UIFont*)font frame:(CGRect)frame title:(NSString*)title;

+(UITextField*)createzlTextFieldfont:(UIFont*)font frame:(CGRect)frame secureEntry:(BOOL)yesorno clearButtonMode:(UITextFieldViewMode)clearbuttonMode TextAlignment:(NSTextAlignment)textAlignment placehoder:(NSString*)placehoder text:(NSString*)text textColor:(UIColor*)color;

//判断电话号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
@end
