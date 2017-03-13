//
//  PlayViewController.m
//  SideScrollingGame
//
//  Created by Sagar Mangulkar on 3/9/17.
//  Copyright © 2017 Sagar Mangulkar. All rights reserved.
//

#import "PlayViewController.h"

@interface PlayViewController ()
- (void)Crashed;
@end

@implementation PlayViewController
BOOL isCrashed;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isCrashed = false;
    
    NSLog(@"View loaded, Crashed: @%hhd", isCrashed);
    [self StartingState];
/*    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(CheckCrash:)
                                   userInfo:nil repeats:YES];
  */
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(VibrateHeroCar:)
                                   userInfo:nil repeats:YES];
//    [NSTimer scheduledTimerWithTimeInterval:3.0
//                                     target:self
//                                   selector:@selector(MovingCarBySlider:)
//                                   userInfo:nil
//                                    repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:4.0
                                     target:self
                                   selector:@selector(OtherCar1:)
                                   userInfo:nil
                                    repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:6.0
                                     target:self
                                   selector:@selector(OtherCar2:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)StartingState{
    CGRect frameOtherCar1 = _imageOtherCar1.frame;
    frameOtherCar1.origin.y = 50;
    _imageOtherCar1.frame = frameOtherCar1;
    CGRect frameOtherCar2 = _imageOtherCar2.frame;
    frameOtherCar2.origin.y = -150;
    _imageOtherCar2.frame = frameOtherCar2;
}

-(void)Crashed:(UIImageView*)imageTempOtherCar{
   // NSLog(@"Crashed Function...!");
    CALayer *presentationLayerHeroCar = (CALayer*)[_imageHeroCar.layer presentationLayer];
    CALayer *presentationLayerOtherCar = (CALayer*)[imageTempOtherCar.layer presentationLayer];
    
    if (CGRectIntersectsRect(presentationLayerHeroCar.frame, presentationLayerOtherCar.frame)) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frameHeroCar = _imageHeroCar.frame;
            frameHeroCar.origin.y = 100;
            _imageHeroCar.frame = frameHeroCar;
            
            CGRect frameOtherCar = imageTempOtherCar.frame;
            frameOtherCar.origin.y = 100;
            imageTempOtherCar.frame = frameOtherCar;
            isCrashed = true;
            _labelGameStarted.text = @"Game Over";
        }];
        [UIView commitAnimations];
    }
}

-(void)VibrateHeroCar:timer{
    if (!isCrashed) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frameHeroCar = _imageHeroCar.frame;
            frameHeroCar.origin.x = frameHeroCar.origin.x + 10;
            _imageHeroCar.frame = frameHeroCar;
        } completion:^(BOOL finished){
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frameHeroCar = _imageHeroCar.frame;
                frameHeroCar.origin.x = frameHeroCar.origin.x - 10;
                _imageHeroCar.frame = frameHeroCar;
            }];
        }];
        [UIView commitAnimations];
        [self Crashed:_imageOtherCar1];
        [self Crashed:_imageOtherCar2];
    }
}

/*
-(void)CheckCrash:timer{
    //NSLog(@"Checking Crash...!");
    CGRect frameHeroCar = _imageHeroCar.frame;
    CGRect frameOtherCar1 = _imageOtherCar1.frame;
    if (((frameHeroCar.origin.y <= frameOtherCar1.origin.y + frameOtherCar1.size.height) && (frameHeroCar.origin.y + frameHeroCar.size.height > frameOtherCar1.origin.y + frameOtherCar1.size.height))){// || (frameHeroCar.origin.y + frameHeroCar.size.height < frameOtherCar1.origin.y)) {
        isCrashed = true;
        NSLog(@"Crashed: @%hhd", isCrashed);
        [self Crashed];
    }
}
*/
 
-(void)MovingCarBySlider:timer{
    [_labelGameStarted setHidden:YES];
//    _labelTest.text = @"Changed";
//    NSLog(@"Hello, @%f", _slider.value * 327);
//    [UIView animateWithDuration:0.5 animations:^{
//    CGRect imageFrameHeroCar = _imageHeroCar.frame;
//        imageFrameHeroCar.origin.x = _slider.value * 327;
//        _imageHeroCar.frame = imageFrameHeroCar;
//        }];
////    [UIView commitAnimations];
    
    //just a testing
//    [UIView animateWithDuration:3.0 animations:^{
//        CGRect frameHeroCar = _imageHeroCar.frame;
//        frameHeroCar.origin.x = frameHeroCar.origin.x+ 1;
//        _imageHeroCar.frame = frameHeroCar;
//    }];
//    [UIView commitAnimations];

}


- (IBAction)SliderValueChanged:(id)sender {
    if (!isCrashed) {
        //moving hero car right-left
        [UIView animateWithDuration:0.5 animations:^{
            CGRect imageFrameHeroCar = _imageHeroCar.frame;
            imageFrameHeroCar.origin.x = _slider.value * 270;
            _imageHeroCar.frame = imageFrameHeroCar;
        }];
        [UIView commitAnimations];
        
        //checking for crash
        [self Crashed:_imageOtherCar1];
        [self Crashed:_imageOtherCar2];
    }
}
-(void)ResetCarPosition:(UIImageView*)imageTemp{
    CGRect frameTemp = imageTemp.frame;
    frameTemp.origin.y = 700;
    imageTemp.frame = frameTemp;
}

-(void)OtherCar1:timer{
    if (!isCrashed) {
        [UIView animateWithDuration:4.0 animations:^{
            CGRect frameOtherCar = _imageOtherCar1.frame;
            frameOtherCar.origin.y = frameOtherCar.origin.y + 800;
            _imageOtherCar1.frame = frameOtherCar;
            NSLog(@"Animations, Y: @%f",frameOtherCar.origin.y);
        } completion:^(BOOL finished){
            [self ResetCarPosition:_imageOtherCar1];
        }];
        [UIView commitAnimations];
    }
}

-(void)OtherCar2:timer{
    if (!isCrashed) {
        [UIView animateWithDuration:6.0 animations:^{
            CGRect imageFrameHeroCar = _imageOtherCar2.frame;
            imageFrameHeroCar.origin.y = imageFrameHeroCar.origin.y + 700;
            _imageOtherCar2.frame = imageFrameHeroCar;
        } completion:^(BOOL finished){
            [self ResetCarPosition:_imageOtherCar2];
        }];
        [UIView commitAnimations];
    }
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
