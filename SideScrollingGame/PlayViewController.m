//
//  PlayViewController.m
//  SideScrollingGame
//
//  Created by Sagar Mangulkar on 3/9/17.
//  Copyright © 2017 Sagar Mangulkar. All rights reserved.
//

#import "PlayViewController.h"

@interface PlayViewController ()

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(MovingCarBySlider:)
                                   userInfo:nil
                                    repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:3.0
                                     target:self
                                   selector:@selector(OtherCar1:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)MovingCarBySlider:timer{
    [_labelTest setHidden:YES];
    _labelTest.text = @"Changed";
    NSLog(@"Hello, @%f", _slider.value * 327);
    [UIView animateWithDuration:0.5 animations:^{
    CGRect imageFrameHeroCar = _imageHeroCar.frame;
        imageFrameHeroCar.origin.x = _slider.value * 327;
        _imageHeroCar.frame = imageFrameHeroCar;
        }];
    [UIView commitAnimations];
    
}

-(void)OtherCar1:timer{
    _labelTest.text = @"Changed";
    [UIView animateWithDuration:2.0 animations:^{
        CGRect imageFrameHeroCar = _imageOtherCar1.frame;
        imageFrameHeroCar.origin.y = imageFrameHeroCar.origin.y + 600;
        _imageOtherCar1.frame = imageFrameHeroCar;
    }];
    [UIView commitAnimations];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
