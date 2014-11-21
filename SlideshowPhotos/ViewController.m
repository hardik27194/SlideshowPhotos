//
//  ViewController.m
//  SlideshowPhotos
//
//  Created by Suraj on 21/11/14.
//  Copyright (c) 2014 Sonora. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    __weak IBOutlet UIToolbar *toolbarBottom;
    __weak IBOutlet UIBarButtonItem *barBtnPlay;
    __weak IBOutlet UIBarButtonItem *barBtnStop;
    __weak IBOutlet UIImageView *imgViewPhoto;
    NSMutableArray *mutArrImages;
    NSInteger intCurrentImage;
    NSTimer *timerAnimation;
}

- (IBAction)playSlideshow:(id)sender;
- (IBAction)stopSlideshow:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mutArrImages = [[NSMutableArray alloc] init];
    for (int i=1; i<=16; i++) {
        [mutArrImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg",i]]];
    }
    
    intCurrentImage = 0;
    [imgViewPhoto setImage:[mutArrImages objectAtIndex:intCurrentImage]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)animatePhotoSlideShow {
    if (intCurrentImage == [mutArrImages count]-1 && [timerAnimation isValid]) {
        [timerAnimation invalidate];
        timerAnimation = nil;
        return;
    }
    intCurrentImage += 1;
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush; //Animation Types: kCATransitionFade, kCATransitionFromLeft, kCATransitionReveal, kCATransitionFromBottom
    transition.duration = 2;
    
    [imgViewPhoto.layer addAnimation:transition forKey:nil];
    [imgViewPhoto setImage:[mutArrImages objectAtIndex:intCurrentImage]];
}

- (IBAction)playSlideshow:(id)sender {
    if (![timerAnimation isValid]) {
        timerAnimation = [NSTimer scheduledTimerWithTimeInterval:4.0
                                                          target:self
                                                        selector:@selector(animatePhotoSlideShow)
                                                        userInfo:nil
                                                         repeats:YES];
    }
}

- (IBAction)stopSlideshow:(id)sender {
    if ([timerAnimation isValid]) {
        [timerAnimation invalidate];
        timerAnimation = nil;
    }
}
@end
