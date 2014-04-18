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

static CGFloat kMDMenuViewOpenWidth = 270.0f;
static CGFloat kMDMenuViewDefaultPosition = -90.0f;
static CGFloat kMDOpeningAnimationDuration = 0.5f;
static CGFloat kMDClosingAnimationDuration = 0.6f;
static CGFloat kMDOpenSpringDamping = 0.8f;
static CGFloat kMDCloseSpringDamping = 1.0f;
static CGFloat kMDSpringVelocity = 0.1f;



@interface MDContainerViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong, readwrite) UIViewController *centerViewController;
@property (nonatomic, strong, readwrite) UIViewController *menuViewController;
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) MDShadowVCenterContainerView *centerContainerView;
@property (nonatomic, strong) UIView *menuContainerView;

// To Store The Point When Pan Gesture Starting
@property (nonatomic, assign) CGPoint panStartPoint;

@end


@implementation MDContainerViewController



#pragma mark - The initialize and viewDidLoad method 
- (id)initWithCenterViewController:(UIViewController *)centerViewController
                menuViewController:(UIViewController *)menuViewController
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
    
/** Initialize The centerContainerView And The MenuContainerView and Add CenterViewController's
    View To centerContainrView Hierarchy  **/
    self.centerContainerView = [[MDShadowVCenterContainerView alloc] initWithFrame:self.view.bounds];
    self.menuContainerView = [[UIView alloc] initWithFrame:self.view.bounds];
    
/** Set The Autoresizing **/
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
    
/** Add CenterViewController's View To CenterContainer View Hierarchy **/
    [self addChildViewController:self.centerViewController];
    self.centerViewController.view.frame = self.centerContainerView.bounds;
    [self.centerContainerView addSubview:self.centerViewController.view];
    [self.centerViewController didMoveToParentViewController:self];

}

- (void)addMenuControllerViewToMenuContainerView
{
    
/** Add MenuViewController's View To MenuContainer View Hierarchy **/
    // This method is different from to -addCenterControllerViewToCenterContainerView
    // When the menu view have opend and invoking didMoveToParentViewController
    [self addChildViewController:self.menuViewController];
    self.menuViewController.view.frame = self.menuContainerView.bounds;
    [self.menuContainerView addSubview:self.menuViewController.view];
}




#pragma mark - The Gesture Method
- (void)addGestureRecognizer
{
/** Set up gesture and add the gesture to centerContainerView **/
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    self.panRecognizer.delegate = self;
    self.panRecognizer.minimumNumberOfTouches = 1;
    [self.centerContainerView addGestureRecognizer:self.panRecognizer];
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
/** The UIGesture Delegate **/
    CGPoint velocity = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:self.view];
    if (self.containerState == MDContainerViewControllerClosed && velocity.x > 0.0f) {
        return YES;
    } else if (self.containerState == MDContainerViewControllerOpen && velocity.x < 0.0f){
        return YES;
    }
    return NO;
}

- (void)addTapGesture
{
/** When the menuView did opend add tap gesture to centerContainerView to close it **/
    [self.centerContainerView addGestureRecognizer:self.tapRecognizer];
}

- (void)removeTapGesture
{
/** When the menuView did closed remove gesture in centerContainerView  **/
    [self.centerContainerView removeGestureRecognizer:self.tapRecognizer];
}

- (void)tap:(UITapGestureRecognizer *)tapGesture
{
/** tap centerContainerView to close menu **/
    if (self.containerState == MDContainerViewControllerOpen) {
        [self closeTheMenu];
    }
}

- (void)pan:(UIPanGestureRecognizer *)panGesture
{
    CGPoint changePoint = [panGesture locationInView:self.view];
    
    switch (panGesture.state)
    {
        
        case UIGestureRecognizerStateBegan:
        {
            self.panStartPoint = changePoint;
            
            if (self.containerState == MDContainerViewControllerClosed) {
                [self menuWillOpen];
            } else if(self.containerState == MDContainerViewControllerOpen) {
                [self menuWillClose];
            }
           break;
        }
            
        case UIGestureRecognizerStateChanged:
        {
            CGRect menuViewChangeFrame = self.menuContainerView.bounds;
            CGRect centerViewChangeFrame = self.centerContainerView.bounds;
            CGFloat changeLength = 0.0f;
            
            if (self.containerState == MDContainerViewControllerOpening) {
                changeLength = changePoint.x - self.panStartPoint.x;
            } else {
                changeLength = self.menuViewWidth - (self.panStartPoint.x- changePoint.x);
            }
            
            if (changeLength > self.menuViewWidth) {
                centerViewChangeFrame.origin.x = self.menuViewWidth;
                menuViewChangeFrame.origin.x = 0;
            } else if (changeLength < 0) {
                centerViewChangeFrame.origin.x = 0;
                menuViewChangeFrame.origin.x = kMDMenuViewDefaultPosition;
            } else {
                centerViewChangeFrame.origin.x = changeLength;
                menuViewChangeFrame.origin.x = kMDMenuViewDefaultPosition - (changeLength * kMDMenuViewDefaultPosition)/self.menuViewWidth;
            }
            self.centerContainerView.frame = centerViewChangeFrame;
            self.menuContainerView.frame = menuViewChangeFrame;
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            CGFloat changeLength = self.centerContainerView.frame.origin.x;
            
            if (self.containerState == MDContainerViewControllerOpening) {
                
                if (changeLength == self.menuViewWidth) {
                    [self menuDidOpen];
                } else if (changeLength < self.view.bounds.size.width/4) {
                    [self closeTheMenu];
                } else {
                    [self menuOpening];
                }
                
            } else if (self.containerState == MDContainerViewControllerClosing) {
                
                if (changeLength == 0) {
                    [self menuDidClose];
                } else if (changeLength > (self.menuViewWidth - 60)) {
                    [self menuOpening];
                } else {
                    [self closeTheMenu];
                }
                
            }
            
        }
        default:
            break;
    }
    
}




#pragma mark - The Open And Close MenuView Method
// invoking this method to open the menuViewController
- (void)openTheMenu
{
    [self menuWillOpen];
    [self menuOpening];
}
// invoking this method to close the menuViewController
- (void)closeTheMenu
{
    [self menuWillClose];
    [self menuClosing];
}




#pragma mark - The State Of Container View
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
    centerContainerViewFinalFrame.origin.x = self.menuViewWidth;
    
    [UIView animateWithDuration:kMDOpeningAnimationDuration
                          delay:0
         usingSpringWithDamping:kMDOpenSpringDamping
          initialSpringVelocity:kMDSpringVelocity
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.centerContainerView.frame = centerContainerViewFinalFrame;
                         self.menuContainerView.frame = menuContainerViewFinalFrame;
                         [self setNeedsStatusBarAppearanceUpdate];
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
         usingSpringWithDamping:kMDCloseSpringDamping
          initialSpringVelocity:kMDSpringVelocity
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.centerContainerView.frame = centerContainerViewFinalFrame;
                         self.menuContainerView.frame = menuContainerViewFinalFrame;
                         [self setNeedsStatusBarAppearanceUpdate];
                     }
                     completion:^(BOOL finished) {
                         [self menuDidClose];
                     }];
}

- (void)menuDidClose
{
    self.containerState = MDContainerViewControllerClosed;

    [self.menuViewController.view removeFromSuperview];
    [self.menuViewController removeFromParentViewController];
    [self.menuContainerView removeFromSuperview];
    [self removeTapGesture];
    
}




#pragma mark Statusbar

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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