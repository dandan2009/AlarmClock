//
//  MDAddViewController.m
//  AlarmClock
//
//  Created by IIMare on 14/6/5.
//  Copyright (c) 2014年 IIMare. All rights reserved.
//

#import "MDAddViewController.h"
#import "MDTimePickerView.h"

@interface MDAddViewController ()//<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIImageView *backgroundImageView;
//@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MDTimePickerView *timePicker;

@end

@implementation MDAddViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // The backgound image view
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.backgroundImageView.image = [UIImage imageNamed:@"menuBG.png"];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroundImageView];
    self.backgroundImageView.userInteractionEnabled = YES;
    
    // The top cancel and done button
    /** cancel button **/
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelButton.frame = CGRectMake(16, 30, 70, 40);
    cancelButton.tintColor = [UIColor whiteColor];
    cancelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(tapCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundImageView addSubview:cancelButton];
    
    /** done button **/
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    doneButton.frame = CGRectMake(244, 30, 70, 40);
    doneButton.tintColor = [UIColor whiteColor];
    doneButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(tapDoneButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundImageView addSubview:doneButton];
    
    /** Time Picker **/
    self.timePicker = [[MDTimePickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2 - 160, self.view.frame.size.width, self.view.frame.size.width)];
    [self.view addSubview:self.timePicker];
    
//    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
//    self.tableView.backgroundColor = [UIColor clearColor];
//
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    [self.backgroundImageView addSubview:self.tableView];
    
}

- (void)tapCancelButton:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dissmissTheAddViewController:)]) {
        [self.delegate dissmissTheAddViewController:self];
    }
}

- (void)tapDoneButton:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dissmissTheAddViewController:)]) {
        [self.delegate dissmissTheAddViewController:self];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *idCell = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idCell];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idCell];
//    }
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
//    cell.backgroundColor = [UIColor clearColor];
//    return cell;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 100;
//}

@end
