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
BOOL isGameOvered;
int resetValue;
NSTimer *timer1;
NSTimer *timer2;
NSTimer *timer3;
NSTimer *timer4;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isCrashed = false;
    
   // NSLog(@"View loaded, Crashed: @%hhd", isCrashed);
    [self StartingState];
    timer1 = [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(CheckCrashByTimer:)
                                   userInfo:nil repeats:YES];
 
    timer2 = [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(VibrateHeroCar:)
                                   userInfo:nil repeats:YES];

    timer3 = [NSTimer scheduledTimerWithTimeInterval:0.2
                                     target:self
                                   selector:@selector(OtherCar1:)
                                   userInfo:nil
                                    repeats:YES];
    timer4 = [NSTimer scheduledTimerWithTimeInterval:0.2
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
    
    [_labelGODisplay1 setHidden:YES];
    [_labelGODisplay2 setHidden:YES];
    [_labelMaxScoreGO setHidden:YES];
    [_LabelYourScoreGO setHidden:YES];
//    isCrashedWithCar1 = false;
//    isCrashedWithCar2 = false;
    isGameOvered = false;
    //NSLog(@"StartingState:- isGameOver:@%d",isGameOvered);
    resetValue = -100;
    [_imageGameOver setHidden:YES];
    [_slider setHidden:NO];
    _labelMaxScore.text = maxScore;
    _labelYourScore.text = @"0";
   // NSLog(@"---------Starting state Called-----IsCrashed: @%hhd, GOImage: @%d---",isCrashed, ![_imageGameOver isHidden]);
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
    [timer1 invalidate];
    timer1 = nil;
    [timer2 invalidate];
    timer2 = nil;
    [timer3 invalidate];
    timer3 = nil;
    [timer4 invalidate];
    timer4 = nil;
    [_labelGODisplay1 setHidden:NO];
    [_labelGODisplay2 setHidden:NO];
    [_labelMaxScoreGO setHidden:NO];
    [_LabelYourScoreGO setHidden:NO];
    _labelMaxScoreGO.text = _labelMaxScore.text;
    _LabelYourScoreGO.text = _labelYourScore.text;
    _imageGameOver.layer.zPosition = 1000;
    //NSLog(@"---------Before Game Over Called-----IsCrashed: @%hhd, isVisibleGOImage: @%d------",isCrashed, ![_imageGameOver isHidden]);
    isCrashed = true;
    isGameOvered = true;
    //NSLog(@"GameOver:- isGameOver:@%d",isGameOvered);
    [_slider setHidden:YES];
    [_imageOtherCar1 setHidden:YES];
    [_imageOtherCar2 setHidden:YES];
//    resetValue = 900;
    [_imageGameOver setHidden:NO];
    UIImage *image = [UIImage imageNamed:@"CrashedCar.jpg"];
    [_imageHeroCar setImage:image];
    //NSLog(@"---------After Game Over Called-----IsCrashed: @%hhd, isVisibleGOImage: @%d------",isCrashed, ![_imageGameOver isHidden]);
}

-(void)Crashed:(UIImageView*)imageTempOtherCar{
    CALayer *presentationLayerHeroCar = (CALayer*)[_imageHeroCar.layer presentationLayer];
    CALayer *presentationLayerOtherCar = (CALayer*)[imageTempOtherCar.layer presentationLayer];
    if (CGRectIntersectsRect(presentationLayerHeroCar.frame, presentationLayerOtherCar.frame)) {
        [self GameOver];
    }
}

-(void)VibrateHeroCar:timer{
//        NSLog(@"VibrateTimer:- fIsShowImage:@%d",![_imageGameOver isHidden]);
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
//    }
}

-(BOOL)IsCrashed:(UIImageView*)imageOtherCarTemp{
    if (!isGameOvered) {
     CGRect frameHeroCar = _imageHeroCar.frame;
     CGRect frameOtherCar = imageOtherCarTemp.frame;
    if (((frameHeroCar.origin.y <= frameOtherCar.origin.y + frameOtherCar.size.height - 40) && (frameHeroCar.origin.y + frameHeroCar.size.height > frameOtherCar.origin.y + frameOtherCar.size.height - 40))) {
        if (((frameHeroCar.origin.x + frameHeroCar.size.width > frameOtherCar.origin.x) &&
             (frameHeroCar.origin.x + frameHeroCar.size.width < frameOtherCar.origin.x + frameOtherCar.size.width)) ||
            ((frameHeroCar.origin.x > frameOtherCar.origin.x)
             && (frameHeroCar.origin.x < frameOtherCar.origin.x + frameOtherCar.size.width))) {
                isGameOvered = true;
                return true;
        }
    }
    }
       return false;
}


-(void)CheckCrash{
        if ([self IsCrashed:_imageOtherCar1]){
            //NSLog(@"First crashed...!");
            [self GameOver];
        }
        if ([self IsCrashed:_imageOtherCar2]){
           // NSLog(@"Second crashed...!");
            [self GameOver];
        }
    
}

-(void)CheckCrashByTimer:timer{
  //  NSLog(@"CheckCrashedTimer:- fIsShowImage:@%d",![_imageGameOver isHidden]);
    [self CheckCrash];
}



- (IBAction)SliderValueChanged:(id)sender {
    isCrashed = false;
  //  isGameOvered = false;
 //   if (!isCrashed) {
        //moving hero car right-left
        [UIView animateWithDuration:0.5 animations:^{
            CGRect imageFrameHeroCar = _imageHeroCar.frame;
            imageFrameHeroCar.origin.x = _slider.value * 270;
            _imageHeroCar.frame = imageFrameHeroCar;
        }];
        [UIView commitAnimations];
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
-(void)ResetWhite1Position:(UIImageView*)imageTemp{
    if (imageTemp.frame.origin.y > 600) {
        CGRect frameTemp = imageTemp.frame;
        frameTemp.origin.y = -150;
        imageTemp.frame = frameTemp;
    }
}

-(void)ResetWhite2Position:(UIImageView*)imageTemp{
    if (imageTemp.frame.origin.y > 600) {
        CGRect frameTemp = imageTemp.frame;
        frameTemp.origin.y = -100;
        imageTemp.frame = frameTemp;
    }
}
-(void)OtherCar1:timer{
  //      NSLog(@"OtherCar1Timer:- fIsShowImage:@%d",![_imageGameOver isHidden]);
  //  if (!isCrashedWithCar1) {
        [UIView animateWithDuration:0.4 animations:^{
            CGRect frameOtherCar = _imageOtherCar1.frame;
            frameOtherCar.origin.y = frameOtherCar.origin.y + 40;
            _imageOtherCar1.frame = frameOtherCar;
        } completion:^(BOOL finished){
            [self ResetCar1Position:_imageOtherCar1];
        }];
        [UIView commitAnimations];
    
    
    //remove
    [UIView animateWithDuration:0.4 animations:^{
        CGRect fr = _imageWhite1.frame;
        fr.origin.y = fr.origin.y + 100;
        _imageWhite1.frame = fr;
    } completion:^(BOOL finished){
        [self ResetWhite1Position:_imageWhite1];
    }];
    [UIView commitAnimations];
    
    [UIView animateWithDuration:0.4 animations:^{
        CGRect fr1 = _imageWhite2.frame;
        fr1.origin.y = fr1.origin.y + 100;
        _imageWhite2.frame = fr1;
    } completion:^(BOOL finished){
        [self ResetWhite2Position:_imageWhite2];
    }];
    [UIView commitAnimations];
    
    //remove
   //     isCrashedWithCar2 = false;
   // }
}

-(void)OtherCar2:timer{
    //    NSLog(@"OtehrCar2Timer:- IsShowImage:@%d",![_imageGameOver isHidden]);
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
