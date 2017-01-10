//
//  SYContactsPickerController.h
//  SYContactsPicker
//
//  Created by reesun on 15/12/30.
//  Copyright © 2015年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SYContactsPickerController;
@class SYContacter;

@protocol SYContactsPickerControllerDelegate <NSObject>

@required

- (void)contactsPickerController:(SYContactsPickerController *)picker didFinishPickingContacts:(NSArray *)contacts;

@optional

- (void)contactsPickerController:(SYContactsPickerController *)picker didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)contactsPickerController:(SYContactsPickerController *)picker didSelectContacter:(SYContacter *)contacter;
- (void)contactsPickerControllerDidCancel:(SYContactsPickerController *)picker;

@end

@interface SYContactsPickerController : UIViewController

@property (nonatomic, weak) id<SYContactsPickerControllerDelegate>delegate;

@end
