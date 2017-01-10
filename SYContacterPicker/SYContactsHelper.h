//
//  SYContactsHelper.h
//  SYContactsPicker
//
//  Created by reesun on 15/12/30.
//  Copyright © 2015年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYContacter;

@interface SYContactsHelper : NSObject

//是否可以访问通讯录
+ (BOOL)canAccessContacts;

//读取通讯录,contacts成员限制为SYContacter
+ (void)fetchContacts:(void(^)(NSArray <SYContacter *> *contacts, BOOL success))block;

@end
