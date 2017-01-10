//
//  ViewController.m
//  SYContactsPicker
//
//  Created by reesun on 15/12/30.
//  Copyright © 2015年 SY. All rights reserved.
//

#import "ViewController.h"
#import "SYContactsPickerController.h"
#import "SYContactsHelper.h"

@interface ViewController () <SYContactsPickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickBtnPicker:(id)sender {
    SYContactsPickerController *vcContacts = [[SYContactsPickerController alloc] init];
    vcContacts.delegate = self;
    [self presentViewController:vcContacts animated:YES completion:nil];
//
//    if ([SYContactsHelper canAccessContacts]) {
//        SYContactsPickerController *vcContacts = [[SYContactsPickerController alloc] init];
//        [self presentViewController:vcContacts animated:YES completion:nil];
//    }
//    else {
//        NSLog(@"can not access contact");
//    }
}

#pragma mark - SYContactsPickerControllerDelegate

- (void)contactsPickerController:(SYContactsPickerController *)picker didFinishPickingContacts:(NSArray *)contacts {
    NSLog(@"contacts==%@",contacts);
}

- (void)contactsPickerController:(SYContactsPickerController *)picker didSelectContacter:(SYContacter *)contacter {
    NSLog(@"contacter==%@",contacter);
}

- (void)contactsPickerController:(SYContactsPickerController *)picker didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexPath==%@",indexPath);
}

- (void)contactsPickerControllerDidCancel:(SYContactsPickerController *)picker {
    NSLog(@"contactsPickerControllerDidCancel");
}

@end
