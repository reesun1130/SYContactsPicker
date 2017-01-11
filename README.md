# SYContactsPicker

## Introduce

### SY Contacts Picker 通讯录读取及展示demo，适配iOS9，详情请看demo
### Version 1.0.5

* 功能：
  * 通讯录读取
  * 通讯录展示


## Example

``` objective-c
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
```

## UI
 ![image](https://github.com/reesun1130/SYContactsPicker/blob/master/SYContactsPickerDemo/sycontactspicker1.png)
 ![image](https://github.com/reesun1130/SYContactsPicker/blob/master/SYContactsPickerDemo/sycontactspicker2.png)

## Installation

### CocoaPods

* [CocoaPods](http://cocoapods.org) is a dependency manager for Swift and Objective-C Cocoa projects, which automates and simplifies the process of using 3rd-party libraries like SYContactsPicker in your projects. 
* [CocoaPods](http://cocoapods.org) can help you scale your projects elegantly.
* See the [Getting Started](https://guides.cocoapods.org/using/getting-started.html) guide for more information.

```ruby
# Your Podfile
platform :ios, '8.0'
target 'yourTarget' do
pod 'SYContactsPicker', '~> 1.0.3'
end
```

### Manually

1.	直接拷贝 `SYContactsPicker/`目录到你的project
2.	添加frameworks：`Foundation`、`UIKit`、`AddressBook` or `Contacts`

## Usage

### Objective-C

1. 初始化：
 * `SYContactsPickerController *vcContacts = [[SYContactsPickerController alloc] init]`
2. 设置代理：
 * `vcContacts.delegate = self`
3. 展示界面：
 * `[self presentViewController:vcContacts animated:YES completion:nil]`
4. 实现代理（SYContactsPickerControllerDelegate）：
 * `contactsPickerController:didFinishPickingContacts`
 * `contactsPickerController:didSelectContacter`
 * `contactsPickerController:didSelectRowAtIndexPath`
 * `contactsPickerControllerDidCancel:`

## Enviroment

- iOS 8+
- Objective-C
- Support armv7/armv7s/arm64

## Misc

### Author

- Name: [Ree Sun](https://github.com/reesun1130)
- Email: <ree.sun.cn@hotmail.com>

### License

This code is distributed under the terms and conditions of the MIT license. 

### Contribution guidelines

**NB!** If you are fixing a bug you discovered, please add also a unit test so I know how exactly to reproduce the bug before merging.
