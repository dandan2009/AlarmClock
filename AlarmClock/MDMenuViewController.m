//
//  MDMenuViewController.m
//  AlarmClock
//
//  Created by IIMare on 14-4-18.
//  Copyright (c) 2014年 IIMare. All rights reserved.
//

#import "MDMenuViewController.h"

@interface MDMenuViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *menuImageView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MDMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView Delegate and Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 2;
        
    } else {
        
        return 1;
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifer];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 150;
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(74,20, 130, 120)];
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(74, 20, 130, 120)];
    headImageView.image = [UIImage imageNamed:@"clockImage.png"];
    headImageView.contentMode = UIViewContentModeScaleAspectFit;
    [headView addSubview:headImageView];
    if (section == 0) {
        return headView;
    } else {
        return nil;
    }
                                   
}

@end
