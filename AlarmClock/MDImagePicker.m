//
//  MDImagePicker.m
//  AlarmClock
//
//  Created by IIMare on 14-5-31.
//  Copyright (c) 2014年 IIMare. All rights reserved.
//

#import "MDImagePicker.h"
#import "MDContainerViewController.h"


@interface MDImagePicker ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation MDImagePicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _images = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"bg1.png"],
                                                          [UIImage imageNamed:@"bg2.png"],
                                                          [UIImage imageNamed:@"bg3.png"],
                                                          [UIImage imageNamed:@"bg4.png"],
                                                          [UIImage imageNamed:@"bg5.png"],
                                                          [UIImage imageNamed:@"bg6.png"],
                                                          [UIImage imageNamed:@"bg7.png"],
                                                          [UIImage imageNamed:@"bg8.png"], nil];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self configerBackground];
    
    [self addScrollview];
    
    [self configerPagControl];
    
}


- (void)configerBackground
{
    //self.backgroundColor = [UIColor redColor];
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -35, 248, 300)];
    self.backgroundImageView.image = [UIImage imageNamed:@"menu_another_cell_image.png"];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.backgroundImageView];
    
    // Title label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(61, 15, 43, 30)];
    label.text = @"Skin";
    label.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0];
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    
    // Cell image
    self.cellSmallImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 12, 34, 33)];
    self.cellSmallImage.image = [UIImage imageNamed:@"cell_small3.png"];
    self.cellSmallImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.cellSmallImage];
    
}

- (void)addScrollview
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(24, 50, 200, 120)];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.images.count, self.scrollView.frame.size.height);

    for (int i = 0; i < self.images.count; i++) {
        
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [self.images objectAtIndex:i];
        
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
}

- (void)configerPagControl
{
    self.pagController = [[UIPageControl alloc] initWithFrame:CGRectMake(100, 155, 50, 50)];
    self.pagController.numberOfPages = 8;
    self.pagController.enabled = YES;
    self.pagController.currentPageIndicatorTintColor = [UIColor blackColor];
    self.pagController.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:self.pagController];
}

- (void)scrollToCurrentPage:(NSInteger)page
{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * page, 0)];
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.isDecelerating) {
        int page = scrollView.contentOffset.x / self.scrollView.frame.size.width;
        self.pagController.currentPage = page;
    }
    
}



@end
