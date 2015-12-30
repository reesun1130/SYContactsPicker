# SYContactsPicker
SYContactsPicker contacts contactsPicker 通讯录读取及展示demo，适配iOS9，详情请看demo
# 使用
    SYContactsPickerController *vcContacts = [[SYContactsPickerController alloc] init];
    vcContacts.delegate = self;
    [self presentViewController:vcContacts animated:YES completion:nil];
#代理
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

