//
//  MDContainerViewController.m
//  AlarmClock
//
//  Created by IIMare on 4/15/14.
//  Copyright (c) 2014 IIMare. All rights reserved.
//

#import "MDContainerViewController.h"
#import "MDShadowVCenterContainerView.h"

/** Default Some Value **/

static CGFloat kMDMenuViewOpenWidth = 260.0f;
static CGFloat kMDMenuViewDefaultPosition = -60.0f;
static CGFloat kMDOpeningAnimationDuration = 0.5f;
static CGFloat kMDClosingAnimationDuration = 0.5f;
static CGFloat kMDSpringDamping = 1.0f;
static CGFloat kMDSpringVelocity = 1.0f;


typedef NS_ENUM(NSInteger, MDContainerViewControllerState) {
    MDContainerViewControllerClosed = 0,
    MDContainerViewControllerOpen,
    MDContainerViewControllerClosing,
    MDContainerViewControllerOpening
};


@interface MDContainerViewController ()

@property (nonatomic, strong, readwrite) UIViewController *centerViewController;
@property (nonatomic, strong, readwrite) UIViewController *menuViewController;
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) MDShadowVCenterContainerView *centerContainerView;
@property (nonatomic, strong) UIView *menuContainerView;
@property (nonatomic, assign) MDContainerViewControllerState containerState;


@end


@implementation MDContainerViewController



#pragma mark - The initialize and viewDidLoad method 
- (id)initWithCenterViewController:(UIViewController *)centerViewController menuViewController:(UIViewController *)menuViewController
{
    if (self = [super init]) {
        _centerViewController = centerViewController;
        _menuViewController = menuViewController;
        _menuViewWidth = kMDMenuViewOpenWidth;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
/** Initialize The centerContainerView And The MenuContainerView and Add  CenterViewController's
    View To centerContainrView Hierarchy  **/
    
    self.centerContainerView = [[MDShadowVCenterContainerView alloc] initWithFrame:self.view.bounds];
    self.menuContainerView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.centerContainerView.autoresizingMask = self.view.autoresizingMask;
    self.menuContainerView.autoresizingMask = self.view.autoresizingMask;
    
    [self addCenterControllerViewToCenterContainerView];
    
/** Add The CenterContainerView To ParentController's View Hierarchy **/
    
    [self.view addSubview:self.centerContainerView];
    
/** Add Gesture **/
    
    [self addGestureRecognizer];
    
}

- (void)addCenterControllerViewToCenterContainerView
{
    [self addChildViewController:self.centerViewController];
    [self.centerViewController didMoveToParentViewController:self];
    self.centerViewController.view.frame = self.centerContainerView.bounds;
    [self.centerContainerView addSubview:self.centerViewController.view];
}

- (void)addMenuControllerViewToMenuContainerView
{
    [self addChildViewController:self.menuViewController];
    self.menuViewController.view.frame = self.menuContainerView.bounds;
    [self.menuContainerView addSubview:self.menuViewController.view];
}


#pragma mark - The Gesture Method
- (void)addGestureRecognizer
{
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    self.panRecognizer.minimumNumberOfTouches = 1;
    [self.centerContainerView addGestureRecognizer:self.panRecognizer];
}

- (void)addTapGesture
{
    [self.centerContainerView addGestureRecognizer:self.tapRecognizer];
}

- (void)removeTapGesture
{
    [self.centerContainerView removeGestureRecognizer:self.tapRecognizer];
}

- (void)pan:(UIPanGestureRecognizer *)panGesture
{
    
}

- (void)tap:(UITapGestureRecognizer *)tapGesture
{
    
}



#pragma mark - The Open And Close MenuView Method
- (void)openTheMenu
{
    [self menuWillOpen];
    [self menuOpening];
}

- (void)closeTheMenu
{
    [self menuWillClose];
    [self menuClosing];
}

- (void)menuWillOpen
{
    self.containerState = MDContainerViewControllerOpening;
    
    CGRect menuContainerViewStartRect = self.view.bounds;
    menuContainerViewStartRect.origin.x = kMDMenuViewDefaultPosition;
    
    self.menuContainerView.frame = menuContainerViewStartRect;
    [self addMenuControllerViewToMenuContainerView];
    
    [self.view insertSubview:self.menuContainerView belowSubview:self.centerContainerView];
}

- (void)menuDidOpen
{
    self.containerState = MDContainerViewControllerOpen;
    [self.menuViewController didMoveToParentViewController:self];
    [self addTapGesture];
}

- (void)menuOpening
{
    CGRect menuContainerViewFinalFrame = self.view.bounds;
    CGRect centerContainerViewFinalFrame = self.view.bounds;
    centerContainerViewFinalFrame.origin.x = kMDMenuViewOpenWidth;
    
    [UIView animateWithDuration:kMDOpeningAnimationDuration
                          delay:0
         usingSpringWithDamping:kMDSpringDamping
          initialSpringVelocity:kMDSpringVelocity
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.centerContainerView.frame = centerContainerViewFinalFrame;
                         self.menuContainerView.frame = menuContainerViewFinalFrame;
                     }
                     completion:^(BOOL finished) {
                         [self menuDidOpen];
                     }];
    
}

- (void)menuWillClose
{
    [self.menuViewController willMoveToParentViewController:nil];
    
    self.containerState = MDContainerViewControllerClosing;
}

- (void)menuClosing
{
    CGRect centerContainerViewFinalFrame = self.view.bounds;
    CGRect menuContainerViewFinalFrame = self.view.bounds;
    menuContainerViewFinalFrame.origin.x = kMDMenuViewDefaultPosition;
    
    [UIView animateWithDuration:kMDClosingAnimationDuration
                          delay:0
         usingSpringWithDamping:kMDSpringDamping
          initialSpringVelocity:kMDSpringVelocity
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.centerContainerView.frame = centerContainerViewFinalFrame;
                         self.menuContainerView.frame = menuContainerViewFinalFrame;
                     }
                     completion:^(BOOL finished) {
                         [self menuDidClose];
                     }];
}

- (void)menuDidClose
{
    [self.menuViewController.view removeFromSuperview];
    [self.menuViewController removeFromParentViewController];
    
    [self.menuContainerView removeFromSuperview];
    
    [self removeTapGesture];
    
    self.containerState = MDContainerViewControllerClosed;
}


@end




#pragma mark - The MDContainerViewController Category Implementation
@implementation UIViewController(MDContainerViewController)

- (MDContainerViewController *)container
{
    UIViewController *parent = self;
    Class containerClass = [MDContainerViewController class];
    
    while (nil != (parent = [parent parentViewController]) && ![parent isKindOfClass:containerClass]) {
        
    }
    return (id)parent;
    
}

@end