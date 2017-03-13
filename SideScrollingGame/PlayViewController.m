//
//  PlayViewController.m
//  SideScrollingGame
//
//  Created by Sagar Mangulkar on 3/9/17.
//  Copyright © 2017 Sagar Mangulkar. All rights reserved.
//

#import "PlayViewController.h"

NSString *maxScore = @"0";

@interface PlayViewController ()

@end

@implementation PlayViewController
BOOL isCrashed = false;
//BOOL isCrashedWithCar1 = false;
//BOOL isCrashedWithCar2 = false;
BOOL isGameOvered = false;
int resetValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isCrashed = false;
    
    NSLog(@"View loaded, Crashed: @%hhd", isCrashed);
    [self StartingState];
    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(CheckCrashByTimer:)
                                   userInfo:nil repeats:YES];
 
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(VibrateHeroCar:)
                                   userInfo:nil repeats:YES];

    [NSTimer scheduledTimerWithTimeInterval:0.2
                                     target:self
                                   selector:@selector(OtherCar1:)
                                   userInfo:nil
                                    repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:0.2
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
    isCrashed = false;
//    isCrashedWithCar1 = false;
//    isCrashedWithCar2 = false;
    isGameOvered = false;
    resetValue = -100;
    [_imageGameOver setHidden:YES];
    [_slider setHidden:NO];
    _labelMaxScore.text = maxScore;
    _labelYourScore.text = @"0";
    NSLog(@"---------Starting state Called-----IsCrashed: @%hhd, GOImage: @%d------",isCrashed, ![_imageGameOver isHidden]);
    CGRect frameOtherCar1 = _imageOtherCar1.frame;
    frameOtherCar1.origin.y = 50;
    _imageOtherCar1.frame = frameOtherCar1;
    CGRect frameOtherCar2 = _imageOtherCar2.frame;
    frameOtherCar2.origin.y = 50;
    _imageOtherCar2.frame = frameOtherCar2;
}


-(void)SetMaxScore{
    //-----------Max score logic--------------
    if (!isGameOvered) {
        _labelYourScore.text = [NSString stringWithFormat:@"%ld", (long)([_labelYourScore.text integerValue] + 1)];
        if ([_labelYourScore.text integerValue] > [maxScore integerValue]) {
            maxScore = _labelYourScore.text;
            _labelMaxScore.text = maxScore;
    }
    }
}

-(void)GameOver{
 //   NSLog(@"---------Before Game Over Called-----IsCrashed: @%hhd, GOImage: @%d------",isCrashed, ![_imageGameOver isHidden]);
    isCrashed = true;
    isGameOvered = true;
    [_slider setHidden:YES];
    [_imageOtherCar1 setHidden:YES];
    [_imageOtherCar2 setHidden:YES];
//    resetValue = 900;
    [_imageGameOver setHidden:NO];
    UIImage *image = [UIImage imageNamed:@"CrashedCar.jpg"];
    [_imageHeroCar setImage:image];
  //  NSLog(@"---------After Game Over Called-----IsCrashed: @%hhd, GOImage: @%d------",isCrashed, ![_imageGameOver isHidden]);
}

-(void)Crashed:(UIImageView*)imageTempOtherCar{
   // NSLog(@"Crashed Function...!");
    CALayer *presentationLayerHeroCar = (CALayer*)[_imageHeroCar.layer presentationLayer];
    CALayer *presentationLayerOtherCar = (CALayer*)[imageTempOtherCar.layer presentationLayer];
    NSLog(@"Intersect: @%d",CGRectIntersectsRect(presentationLayerHeroCar.frame, presentationLayerOtherCar.frame));
  /*  NSLog(@"1) Cordinates:- HeroCar: X = @%f, Y = @%f; OtherCar: X = @%f, Y = @%f",
          presentationLayerHeroCar.position.x,
          presentationLayerHeroCar.position.y,
          presentationLayerOtherCar.position.x,
          presentationLayerOtherCar.position.y);
    */
    if (CGRectIntersectsRect(presentationLayerHeroCar.frame, presentationLayerOtherCar.frame)) {
        //presentationLayerHeroCar = (CALayer*)[_imageTemp1.layer presentationLayer];
        //presentationLayerOtherCar = (CALayer*)[_imageTemp2.layer presentationLayer];
    /*    NSLog(@"2) Cordinates:- HeroCar: X = @%f, Y = @%f; OtherCar: X = @%f, Y = @%f",
              presentationLayerHeroCar.position.x,
              presentationLayerHeroCar.position.y,
              presentationLayerOtherCar.position.x,
              presentationLayerOtherCar.position.y);
*/
     //        presentationLayerHeroCar = (CALayer*)[_imageHeroCar.layer presentationLayer];
//        presentationLayerOtherCar = (CALayer*)[imageTempOtherCar.layer presentationLayer];
        [self GameOver];
    }
}

-(void)VibrateHeroCar:timer{
    // NSLog(@"VibrateHeroCar, Crashed: @%hhd", isCrashed);
//    if (!isCrashed) {
    [self SetMaxScore];
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frameHeroCar = _imageHeroCar.frame;
            frameHeroCar.origin.x = frameHeroCar.origin.x + 5;
            _imageHeroCar.frame = frameHeroCar;
        } completion:^(BOOL finished){
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frameHeroCar = _imageHeroCar.frame;
                frameHeroCar.origin.x = frameHeroCar.origin.x - 5;
                _imageHeroCar.frame = frameHeroCar;
            }];
        }];
        [UIView commitAnimations];
//        [self Crashed:_imageOtherCar1];
//        [self Crashed:_imageOtherCar2];
//    }
}

-(BOOL)IsCrashed:(UIImageView*)imageOtherCarTemp{
    CGRect frameHeroCar = _imageHeroCar.frame;
    CGRect frameOtherCar = imageOtherCarTemp.frame;
    if (((frameHeroCar.origin.y <= frameOtherCar.origin.y + frameOtherCar.size.height - 40) && (frameHeroCar.origin.y + frameHeroCar.size.height > frameOtherCar.origin.y + frameOtherCar.size.height))) {
        if (((frameHeroCar.origin.x + frameHeroCar.size.width > frameOtherCar.origin.x) &&
             (frameHeroCar.origin.x + frameHeroCar.size.width < frameOtherCar.origin.x + frameOtherCar.size.width)) ||
            ((frameHeroCar.origin.x > frameOtherCar.origin.x)
             && (frameHeroCar.origin.x < frameOtherCar.origin.x + frameOtherCar.size.width))) {
            return true;
        }
    }
    return false;
}


-(void)CheckCrash{
    if ([self IsCrashed:_imageOtherCar1]){
        [self GameOver];
    }
    if ([self IsCrashed:_imageOtherCar2]){
        [self GameOver];
        NSLog(@"Second crashed...!");
    }
}

-(void)CheckCrashByTimer:timer{
    [self CheckCrash];
}



- (IBAction)SliderValueChanged:(id)sender {
    isCrashed = false;
    isGameOvered = false;
 //   if (!isCrashed) {
        //moving hero car right-left
        [UIView animateWithDuration:0.5 animations:^{
            CGRect imageFrameHeroCar = _imageHeroCar.frame;
            imageFrameHeroCar.origin.x = _slider.value * 270;
            _imageHeroCar.frame = imageFrameHeroCar;
        }];
        [UIView commitAnimations];
        
        //checking for crash
 //       [self Crashed:_imageOtherCar1];
//        [self Crashed:_imageOtherCar2];
 //   }
}
-(void)ResetCar1Position:(UIImageView*)imageTemp{
    if (imageTemp.frame.origin.y > 600) {
        int randomX = arc4random_uniform(270);
        CGRect frameTemp = imageTemp.frame;
        CGRect frameOtherCar2 = _imageOtherCar2.frame;
        frameTemp.origin.y = resetValue;
        if ((((randomX + frameOtherCar2.size.width > frameOtherCar2.origin.x) &&
                 (randomX + frameOtherCar2.size.width < frameOtherCar2.origin.x + frameOtherCar2.size.width)) ||
                ((randomX > frameOtherCar2.origin.x)
                 && (randomX < frameOtherCar2.origin.x + frameOtherCar2.size.width)))) {
                    if (randomX <= 220 && randomX > frameOtherCar2.origin.x) {
                        randomX = randomX + frameOtherCar2.size.width;
                    }
                    else if (randomX >= 0 && randomX < frameOtherCar2.origin.x) {
                        randomX = randomX + frameOtherCar2.size.width;
                    }
                    else{
                        randomX = 150;
                    }
                }
        frameTemp.origin.x = randomX;
        imageTemp.frame = frameTemp;
    }
}


-(void)ResetCar2Position:(UIImageView*)imageTemp{
    if (imageTemp.frame.origin.y > 600) {
        int randomX = arc4random_uniform(270);
        CGRect frameTemp = imageTemp.frame;
        CGRect frameOtherCar1 = _imageOtherCar1.frame;
        frameTemp.origin.y = resetValue;
        if ((((randomX + frameOtherCar1.size.width > frameOtherCar1.origin.x) &&
              (randomX + frameOtherCar1.size.width < frameOtherCar1.origin.x + frameOtherCar1.size.width)) ||
             ((randomX > frameOtherCar1.origin.x)
              && (randomX < frameOtherCar1.origin.x + frameOtherCar1.size.width)))) {
                 if (randomX <= 220 && randomX > frameOtherCar1.origin.x) {
                     randomX = randomX + frameOtherCar1.size.width;
                 }
                 else if (randomX >= 0 && randomX < frameOtherCar1.origin.x) {
                     randomX = randomX + frameOtherCar1.size.width;
                 }
                 else{
                     randomX = 150;
                 }
             }
        frameTemp.origin.x = randomX;
        imageTemp.frame = frameTemp;
    }
}

-(void)OtherCar1:timer{
  //  if (!isCrashedWithCar1) {
        [UIView animateWithDuration:0.4 animations:^{
            CGRect frameOtherCar = _imageOtherCar1.frame;
            frameOtherCar.origin.y = frameOtherCar.origin.y + 40;
            _imageOtherCar1.frame = frameOtherCar;
        } completion:^(BOOL finished){
            [self ResetCar1Position:_imageOtherCar1];
        }];
        [UIView commitAnimations];
   //     isCrashedWithCar2 = false;
   // }
}

-(void)OtherCar2:timer{
  //  if (!isCrashedWithCar2) {
        [UIView animateWithDuration:0.4 animations:^{
            CGRect frameOtherCar = _imageOtherCar2.frame;
            frameOtherCar.origin.y = frameOtherCar.origin.y + 30;
            _imageOtherCar2.frame = frameOtherCar;
        } completion:^(BOOL finished){
            [self ResetCar2Position:_imageOtherCar2];
        }];
        [UIView commitAnimations];
  //      isCrashedWithCar1 = false;
  //  }
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
