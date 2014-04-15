//
//  MDRootViewController.m
//  AlarmClock
//
//  Created by MARE on 14-3-9.
//  Copyright (c) 2014年 MARE. All rights reserved.
//

#import "MDRootViewController.h"
#import "MDTransformerDateFormatter.h"
#import "MDWeatherManager.h"
#import "NSDate+CurrentTimeIntervalWith24Hour.h"


@interface MDRootViewController()

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, weak) IBOutlet UIImageView *timeBoard;

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *weekLabel;
@property (nonatomic, weak) IBOutlet UILabel *ampmLabel;

@property (nonatomic, weak) IBOutlet UILabel *cityNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *weatherConditionLabel;
@property (nonatomic, weak) IBOutlet UILabel *weatherTempLabel;
@property (nonatomic, weak) IBOutlet UIImageView *iconImage;

@property (nonatomic, strong) MDTransformerDateFormatter *transformerFormatter;
@property (nonatomic, strong) NSTimer *dateTimer;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MDRootViewController


#pragma mark - The initializer methed and The load view method
- (id)init
{
    if (self = [super init]) {
        
        _transformerFormatter = [[MDTransformerDateFormatter alloc] init];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                  target:self
                                                selector:@selector(changingTime)
                                                userInfo:nil
                                                 repeats:YES];
        _dateTimer = [NSTimer scheduledTimerWithTimeInterval:[NSDate getCurrentTimeIntervalWith24Hour]
                                                      target:self
                                                    selector:@selector(changingDate)
                                                    userInfo:nil
                                                     repeats:YES];
        
        
        //Navigation item button
        UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"]
                                                                           style:UIBarButtonItemStyleDone
                                                                          target:self
                                                                          action:@selector(menuButton:)];
        self.navigationItem.leftBarButtonItem = leftButtonItem;
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
        
        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add.png"]
                                                                            style:UIBarButtonItemStyleDone
                                                                           target:self
                                                                           action:@selector(addButton:)];
        self.navigationItem.rightBarButtonItem = rightButtonItem;
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    /** Set the navigation bar transpareance **/
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navgationBar"]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
/** Display current date **/
    self.timeLabel.text = [self.transformerFormatter getCurrentTime];
    self.dateLabel.text = [self.transformerFormatter getCurrentDate];
    self.weekLabel.text = [self.transformerFormatter getCurrentWeek];
    self.ampmLabel.text = [self.transformerFormatter getCurrentAmpm];
    
/** Get current location weather **/
    [[RACObserve([MDWeatherManager sharedManager], currentCondition) deliverOn:RACScheduler.mainThreadScheduler]
    
        subscribeNext:^(MDWeatherCondition *newCondition) {
           
            
            self.cityNameLabel.text = [newCondition.locationName capitalizedString];
            self.iconImage.image = [UIImage imageNamed:newCondition.imageName];
            
            if(newCondition){
                float celsius =[[newCondition temperature] floatValue] -  273.15;
                self.weatherTempLabel.text = [NSString stringWithFormat:@"%.0f℃",celsius];
            }
            
            self.weatherConditionLabel.text = [newCondition condition];
            
        }];
    
/** Fina locations **/
    [[MDWeatherManager sharedManager] findCurrentLocation];
    
    
}



#pragma mark - Change the time every per minute
- (void)changingTime
{
    self.timeLabel.text = [self.transformerFormatter getCurrentTime];
}

- (void)changingDate
{
    self.dateLabel.text = [self.transformerFormatter getCurrentDate];
    self.weekLabel.text = [self.transformerFormatter getCurrentWeek];
}



#pragma mark - The navigation bar button action
- (void)menuButton:(id)sender
{
    
}

- (void)addButton:(id)sender
{
    
}

@end
