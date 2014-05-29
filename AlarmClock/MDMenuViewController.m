//
//  MDMenuViewController.m
//  AlarmClock
//
//  Created by IIMare on 14-4-18.
//  Copyright (c) 2014年 IIMare. All rights reserved.
//

#import "MDMenuViewController.h"
#import "MDTableViewCell.h"
#import "MDContainerViewController.h"

@interface MDMenuViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *menuImageView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MDMenuViewController

#pragma mark - The View did load method

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}


#pragma mark - The delegate and datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger rowNumber = indexPath.row;
    
    static NSString *cellIdentifer = @"MDTableViewCells";
    
    BOOL isRegister = NO;
    
    if (!isRegister) {
        UINib *nib = [UINib nibWithNibName:@"MDTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifer];
        isRegister = YES;
    }
    MDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (rowNumber) {
        case 0:
        {
            cell.lableName.text = @"Main";
            cell.lableName.textColor = [UIColor colorWithRed:55/255 green:70/255 blue:102/255 alpha:1.0];
        }
            break;
        case 1:
        {
            cell.lableName.text = @"About";
            cell.lableName.textColor = [UIColor colorWithRed:55/255 green:70/255 blue:102/255 alpha:1.0];
        }
            
        default:
            break;
    }

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    switch (row) {
        case 0:
        {
            if ([self container].containerState == MDContainerViewControllerOpen) {
                [[self container] closeTheMenu];
            }
        }
            break;
            
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 140)];
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-20, 40, 320, 108)];
    headerImageView.image = [UIImage imageNamed:@"clockImage.png"];
    headerImageView.contentMode = UIViewContentModeScaleAspectFit;
    [headerView addSubview:headerImageView];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 160;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    UIImageView *footerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-25, 9, 320, 187)];
    footerImageView.image = [UIImage imageNamed:@"menu_another_cell_image"];
    footerImageView.contentMode = UIViewContentModeScaleAspectFit;
    [footerView addSubview:footerImageView];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 150;
}

@end
