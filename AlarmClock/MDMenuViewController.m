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
#import "MDImagePicker.h"
#import "MDContainerViewController.h"

@interface MDMenuViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MDImagePicker *imagePicker;
@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, assign) NSInteger page;

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.imagePicker scrollToCurrentPage:self.page];
    
}

// Using key value to change the root view controller background image
- (void)ChangeBackground:(id)sender
{
    UIImage *image;
    switch (self.imagePicker.pagController.currentPage) {
        case 0:
        {
            image = [UIImage imageNamed:@"background1.png"];
        }
            break;
        case 1:
        {
            image = [UIImage imageNamed:@"background2.png"];
        }
            break;
        case 2:
        {
            image = [UIImage imageNamed:@"background3.png"];
        }
            break;
        case 3:
        {
            image = [UIImage imageNamed:@"background4.png"];
        }
            break;
        case 4:
        {
            image = [UIImage imageNamed:@"background5.png"];
        }
            break;
        case 5:
        {
            image = [UIImage imageNamed:@"background6.png"];
        }
            break;
        case 6:
        {
            image = [UIImage imageNamed:@"background7.png"];
        }
            break;
        case 7:
        {
            image = [UIImage imageNamed:@"background8.png"];
        }
            break;
        default:
            break;
    }
    
    self.page = self.imagePicker.pagController.currentPage;
    
    [[[self container].centerViewController.viewControllers objectAtIndex:0] setValue:image forKeyPath:@"backgroundImageView.image"];
    [[self container] closeTheMenu];

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
            cell.lableName.textColor = [UIColor whiteColor];
            cell.cellSmallImage.image = [UIImage imageNamed:@"cell_small1.png"];
            //cell.lableName.textColor = [UIColor colorWithRed:55/255 green:70/255 blue:102/255 alpha:1.0];
            
        }
            break;
        case 1:
        {
            cell.lableName.text = @"About";
            cell.lableName.textColor = [UIColor whiteColor];
            cell.cellSmallImage.image = [UIImage imageNamed:@"cell_small2.png"];
            //cell.lableName.textColor = [UIColor colorWithRed:55/255 green:70/255 blue:102/255 alpha:1.0];
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

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    UIView *footerView = [[UIView alloc] init];
    //footerView.backgroundColor = [UIColor yellowColor];
    self.imagePicker = [[MDImagePicker alloc] initWithFrame:CGRectMake(12, 5, 320, 250)];
    [footerView addSubview:self.imagePicker];
    // Add a button to select image
    // Change background button
    UIButton *imageChangeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    imageChangeButton.frame = CGRectMake( 185, 178, 70, 70);
    imageChangeButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0];
    [imageChangeButton setTintColor:[UIColor whiteColor]];
    [imageChangeButton setTitle:@"Choose" forState:UIControlStateNormal];
    [imageChangeButton addTarget:self action:@selector(ChangeBackground:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:imageChangeButton];
    
    

    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 250;
}

@end
