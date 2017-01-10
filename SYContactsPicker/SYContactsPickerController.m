//
//  SYContactsPickerController.m
//  SYContactsPicker
//
//  Created by reesun on 15/12/30.
//  Copyright © 2015年 SY. All rights reserved.
//

#import "SYContactsPickerController.h"
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import "SYContacter.h"
#import "NSString+SY.h"
#import "SYContactsHelper.h"

@interface SYContactsPickerController () <UITableViewDataSource, UITableViewDelegate> {
@private
    NSMutableArray *_arrContacts;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SYContactsPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTopBar];
    
    __weak SYContactsPickerController *weakSelf = self;
    
    [SYContactsHelper fetchContacts:^(NSArray <SYContacter *> *contacts, BOOL success) {
        if (success) {
            [weakSelf reloadContacts:contacts];
        }
        else {
            [weakSelf showUserDenied];
        }
    }];
}

- (void)createTopBar {
    UIView *vTopBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    vTopBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    vTopBar.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:0.94];
    CGFloat btnWidth = 100;
    
    // 标题
    UIButton *_btnTitle = [[UIButton alloc] initWithFrame:CGRectMake(btnWidth, 20, self.view.frame.size.width - btnWidth * 2, 44)];
    _btnTitle.titleLabel.font = [UIFont systemFontOfSize:20.0];
    _btnTitle.exclusiveTouch = YES;
    [_btnTitle setTitle:@"通讯录" forState:UIControlStateNormal];
    [_btnTitle setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    // 左按钮
    UIButton *_btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, btnWidth, _btnTitle.frame.size.height)];
    _btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btnLeft.titleLabel.font = [UIFont systemFontOfSize:18.0];
    _btnLeft.exclusiveTouch = YES;
    _btnLeft.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    [_btnLeft setTitle:@"关闭" forState:UIControlStateNormal];
    [_btnLeft setTitleColor:_btnTitle.titleLabel.textColor forState:UIControlStateNormal];
    [_btnLeft addTarget:self action:@selector(onClickBtnBack:) forControlEvents: UIControlEventTouchUpInside];
    
    // 右按钮
    UIButton *_btnRight = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - btnWidth, 20, btnWidth, _btnTitle.frame.size.height)];
    _btnRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _btnRight.titleLabel.font = [UIFont systemFontOfSize:18.0];
    _btnRight.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    _btnRight.exclusiveTouch = YES;
    [_btnRight setTitle:@"保存" forState:UIControlStateNormal];
    [_btnRight setTitleColor:_btnTitle.titleLabel.textColor forState:UIControlStateNormal];
    [_btnRight addTarget:self action:@selector(onClickBtnSave:) forControlEvents: UIControlEventTouchUpInside];
    
    [vTopBar addSubview:_btnTitle];
    [vTopBar addSubview:_btnLeft];
    [vTopBar addSubview:_btnRight];
    [self.view addSubview:vTopBar];
}

- (void)onClickBtnBack:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(contactsPickerControllerDidCancel:)]) {
        [self.delegate contactsPickerControllerDidCancel:self];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onClickBtnSave:(UIButton *)btn {
    NSArray *selectedContacts = [self savedContacts];
    if (selectedContacts.count > 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(contactsPickerController:didFinishPickingContacts:)]) {
            [self.delegate contactsPickerController:self didFinishPickingContacts:selectedContacts];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        NSLog(@"还未选择联系人!!!");
    }
}

- (NSArray *)savedContacts {
    NSMutableArray *contacts = [[NSMutableArray alloc] init];
    for (NSArray *section in _arrContacts) {
        for (SYContacter *contacter in section) {
            if (contacter.selected)
                [contacts addObject:contacter];
        }
    }
    
    return contacts;
}

- (void)reloadContacts:(NSArray *)contactsTemp {
    if (!_arrContacts) {
        _arrContacts = [[NSMutableArray alloc] init];
    }
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
    for (SYContacter *contacter in contactsTemp) {
        NSInteger sect = [theCollation sectionForObject:contacter
                                collationStringSelector:@selector(getContacterName)];
        contacter.section = sect;
    }
    
    NSInteger highSection = [[theCollation sectionTitles] count];
    NSMutableArray *sectionArrays = [NSMutableArray arrayWithCapacity:highSection];
    for (NSInteger i = 0; i <= highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sectionArrays addObject:sectionArray];
    }
    
    for (SYContacter *addressBook in contactsTemp) {
        [(NSMutableArray *)[sectionArrays objectAtIndex:addressBook.section] addObject:addressBook];
    }
    
    //getContactName 如果这个返回的是nil会有问题
    for (NSMutableArray *sectionArray in sectionArrays) {
        NSArray *sortedSection = [theCollation sortedArrayFromArray:sectionArray collationStringSelector:@selector(getContacterName)];
        [_arrContacts addObject:sortedSection];
    }
    [self.tableView reloadData];
}

- (void)onClickBtnSetting:(UIButton *)btn {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root"]];
}

- (void)showUserDenied {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
    
    NSString *str = [NSString stringWithFormat:@"您没有权限访问通讯录\n\n请到“设置-隐私-通讯录”里\n允许”SYContactsPicker“访问"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0] range:[str rangeOfString:@"您没有权限访问通讯录"]];
    label.attributedText = attributedString;
    [label sizeToFit];
    label.frame = CGRectMake(0, 0, label.frame.size.width, label.frame.size.height);
    label.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(0, 0, 140, 40);
    settingBtn.backgroundColor = [UIColor blueColor];
    settingBtn.layer.cornerRadius = 5;
    settingBtn.layer.masksToBounds = YES;
    [settingBtn setTitle:@"去设置" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    settingBtn.center = CGPointMake(self.view.frame.size.width / 2, label.center.y + 5 + 20 + label.frame.size.height / 2);
    [settingBtn addTarget:self action:@selector(onClickBtnSetting:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingBtn];
}

- (void)checkButtonTapped:(id)sender event:(id)event {
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    
    if (indexPath) {
        [self accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

- (void)accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    SYContacter *contacter = (SYContacter *)[[_arrContacts objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    BOOL checked = !contacter.selected;
    contacter.selected = checked;
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UIButton *button = (UIButton *)cell.accessoryView;
    [button setSelected:checked];
}

#pragma mark -
#pragma mark UITableViewDataSource & UITableViewDelegate

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[NSArray array] arrayByAddingObjectsFromArray:
            [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_arrContacts count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[_arrContacts objectAtIndex:section] count] ? [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section] : nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [[_arrContacts objectAtIndex:section] count] ? tableView.sectionHeaderHeight : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_arrContacts objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellID = @"kCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(30, 0, 22, 22)];
        [button setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"selected_h"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
        [button setSelected:NO];
        cell.accessoryView = button;
    }
    
    SYContacter *addressBook = (SYContacter *)[[_arrContacts objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if ([[addressBook.name sy_trim] length] > 0) {
        cell.textLabel.text = addressBook.name;
    }
    else {
        cell.textLabel.font = [UIFont italicSystemFontOfSize:cell.textLabel.font.pointSize];
        cell.textLabel.text = @"无名氏";
    }
    
    UIButton *button = (UIButton *)cell.accessoryView;
    [button setSelected:addressBook.selected];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(contactsPickerController:didSelectRowAtIndexPath:)]) {
        [self.delegate contactsPickerController:self didSelectRowAtIndexPath:indexPath];
    }
    
    SYContacter *contacter = (SYContacter *)[[_arrContacts objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    if (self.delegate && [self.delegate respondsToSelector:@selector(contactsPickerController:didSelectContacter:)]) {
        [self.delegate contactsPickerController:self didSelectContacter:contacter];
    }

    [self accessoryButtonTappedForRowWithIndexPath:indexPath];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
