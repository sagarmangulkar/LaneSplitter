//
//  PlayViewController.h
//  SideScrollingGame
//
//  Created by Sagar Mangulkar on 3/9/17.
//  Copyright © 2017 Sagar Mangulkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageHeroCar;
@property (strong, nonatomic) IBOutlet UISlider *slider;

@property (strong, nonatomic) IBOutlet UIImageView *imageOtherCar1;
@property (strong, nonatomic) IBOutlet UIImageView *imageOtherCar2;

@property (strong, nonatomic) IBOutlet UIImageView *imageGameOver;
@property (strong, nonatomic) IBOutlet UIImageView *imageTemp2;
@property (strong, nonatomic) IBOutlet UILabel *labelYourScore;
@property (strong, nonatomic) IBOutlet UILabel *labelMaxScore;

@end
