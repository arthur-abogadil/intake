//
//  SettingsViewController.m
//  Intake
//
//  Created by Arthur on 10/5/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults registerDefaults:@{@"calories": @0.0}];
    [standardDefaults registerDefaults:@{@"startingweight": @0.0}];
    [standardDefaults registerDefaults:@{@"currentweight": @0.0}];
    
    [standardDefaults registerDefaults:@{@"breakfast": @680.0}];
    [standardDefaults registerDefaults:@{@"lunch": @680.0}];
    [standardDefaults registerDefaults:@{@"dinner": @680.0}];
    [standardDefaults registerDefaults:@{@"snacks": @680.0}];
    
    reset = false;
    reset_touched = false;
    
    return;

}

- (void)viewDidLayoutSubviews
{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    float x = [standardDefaults floatForKey:@"calories"];
    CGPoint point = CGPointMake(x,DailyIntakeDrag.center.y);
    DailyIntakeDrag.center = point;

    lblDailyIntake.text = [NSString stringWithFormat: @"%.0f",( (x) / 344 ) * 3300];

    //current weight
    
    float currentweight = [standardDefaults floatForKey:@"currentweight"];
    CGPoint pointCW = CGPointMake(currentweight,CurrentWeightDrag.center.y );
  
    CurrentWeightDrag.center = pointCW;
        
    x = currentweight;
    
    CurrentWeightStones.text = [NSString stringWithFormat: @"%.0f", ((x) / 12.74)];
    CurrentWeightPounds.text = [NSString stringWithFormat: @"%.0f", ((x) / 12.74) * 14];
    CurrentWeightKilograms.text = [NSString stringWithFormat: @"%.0f", ((x) / 12.74) * 6.35029];
    currentstones = ((x) / 12.74);
    
    CurrentWeightStones.text  = [CurrentWeightStones.text stringByAppendingString:@" Stones"];
    CurrentWeightPounds.text =  [CurrentWeightPounds.text stringByAppendingString:@" Pounds"];
    CurrentWeightKilograms.text =  [CurrentWeightKilograms.text stringByAppendingString:@" Kilograms"];
    
    //starting weight
    float startingweight = [standardDefaults floatForKey:@"startingweight"];
    CGPoint pointSW = CGPointMake(startingweight,StartingWeightDrag.center.y );
   
    StartingWeightDrag.center = pointSW;
    
    x = startingweight;
    
    StartingWeightStones.text = [NSString stringWithFormat: @"%.0f", ((x) / 12.74)];
    StartingWeightPounds.text = [NSString stringWithFormat: @"%.0f", ((x) / 12.74) * 14];
    StartingWeightKilograms.text = [NSString stringWithFormat: @"%.0f", ((x) / 12.74) * 6.35029];
    startingstones = ((x) / 12.74);
 
    StartingWeightStones.text  = [StartingWeightStones.text stringByAppendingString:@" Stones"];
    StartingWeightPounds.text =  [StartingWeightPounds.text stringByAppendingString:@" Pounds"];
    StartingWeightKilograms.text =  [StartingWeightKilograms.text stringByAppendingString:@" Kilograms"];
    
    
    StonesLost.text = [NSString stringWithFormat: @"%.0f", startingstones - currentstones];
    PoundsLost.text = [NSString stringWithFormat: @"%.0f", (startingstones - currentstones) * 14];
    KilogramsLost.text = [NSString stringWithFormat: @"%.0f", (startingstones - currentstones) * 6.35029];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    UITouch *Drag = [[event allTouches] anyObject];
    
    CGFloat y = [Drag locationInView:self.view].y;
    CGFloat x = [Drag locationInView:self.view].x;
    
    
    if (y > 246 && y < 310 && DailyIntakeDrag.center.x >= 0 && DailyIntakeDrag.center.x < 345 )
    {
        
        if (x > DailyIntakeDrag.frame.origin.x + DailyIntakeDrag.frame.size.width){
            return;
        }
        
        CGFloat finalx;
        
        if (x > old_x){
            finalx = x - old_x;
        }
        else {
            finalx = x - old_x;
        }
        
        if(abs(finalx) < 2) {
            finalx = 0.0625 * finalx;
        }
        
        old_x = [Drag locationInView:self.view].x ;
        old_y = [Drag locationInView:self.view].y ;

        if(DailyIntakeDrag.center.x + finalx < 1){
        
            [prefs setFloat:0.0 forKey:@"calories"];
            lblDailyIntake.text = @"0";

            return;
        }
        
        if(DailyIntakeDrag.center.x + finalx > 344){
            
            [prefs setFloat:3300.0 forKey:@"calories"];
            lblDailyIntake.text = @"3300";
            
            return;
        }
        
        CGPoint point = CGPointMake(DailyIntakeDrag.center.x + finalx ,DailyIntakeDrag.center.y );
        DailyIntakeDrag.center = point;
        
        lblDailyIntake.text = [NSString stringWithFormat: @"%.0f",  ( (DailyIntakeDrag.center.x) / 344 ) * 3300 ];
        
        [prefs setFloat:DailyIntakeDrag.center.x forKey:@"calories"];
        
    }
    
    if (y > 174 && y < 238 && StartingWeightDrag.center.x >= 0 && StartingWeightDrag.center.x < 345)
    {
        
        if (x > StartingWeightDrag.frame.origin.x + StartingWeightDrag.frame.size.width){
            return;
        }
        
        CGFloat finalx;
        
        if (x > old_x){
            finalx = x - old_x;
        }
        else {
            finalx = x - old_x;
        }
        
        old_x = [Drag locationInView:self.view].x ;
        old_y = [Drag locationInView:self.view].y ;
        
        if(StartingWeightDrag.center.x + finalx < 1){
            
            [prefs setFloat:0.0 forKey:@"startingweight"];
            StartingWeightStones.text = @"0 Stones";
            StartingWeightPounds.text = @"0 Pounds";
            StartingWeightKilograms.text = @"0 Kilograms";
            
            return;
        }
        
        if(StartingWeightDrag.center.x + finalx > 344){
            
            [prefs setFloat:26.8 forKey:@"startingweight"];
            StartingWeightStones.text = @"26.8 Stones";
            StartingWeightPounds.text = @"375 Pounds";
            StartingWeightKilograms.text = @"170 Kilograms";
            
            return;
        }
        
        CGPoint point = CGPointMake(StartingWeightDrag.center.x + finalx ,StartingWeightDrag.center.y );
        
        StartingWeightDrag.center = point;
        
        StartingWeightStones.text = [NSString stringWithFormat: @"%.1f", ((StartingWeightDrag.center.x) / 12.74)];
        
        StartingWeightPounds.text = [NSString stringWithFormat: @"%.0f", ((StartingWeightDrag.center.x) / 12.74) * 14];
        
        StartingWeightKilograms.text = [NSString stringWithFormat: @"%.0f", ((StartingWeightDrag.center.x) / 12.74) * 6.35029];
        
        
        StartingWeightStones.text  = [StartingWeightStones.text stringByAppendingString:@" Stones"];
        StartingWeightPounds.text =  [StartingWeightPounds.text stringByAppendingString:@" Pounds"];
        StartingWeightKilograms.text =  [StartingWeightKilograms.text stringByAppendingString:@" Kilograms"];

        
        startingstones = ((StartingWeightDrag.center.x) / 12.74);
        
        StonesLost.text = [NSString stringWithFormat: @"%.1f", startingstones - currentstones];
        PoundsLost.text = [NSString stringWithFormat: @"%.0f", (startingstones - currentstones) * 14];
        KilogramsLost.text = [NSString stringWithFormat: @"%.0f", (startingstones - currentstones) * 6.35029];
        
        [prefs setFloat:StartingWeightDrag.center.x forKey:@"startingweight"];

        
    }

    
    if (y > 102 && y < 166 && CurrentWeightDrag.center.x >= 0 && CurrentWeightDrag.center.x < 345)
    {
        if (x > CurrentWeightDrag.frame.origin.x + CurrentWeightDrag.frame.size.width){
            return;
        }
        
        CGFloat finalx;
        
        if (x > old_x){
            finalx = x - old_x;
        }
        else {
            finalx = x - old_x;
        }
        
        old_x = [Drag locationInView:self.view].x ;
        old_y = [Drag locationInView:self.view].y ;
        
        if(CurrentWeightDrag.center.x + finalx < 1){
            
            [prefs setFloat:0.0 forKey:@"currentweight"];
            CurrentWeightStones.text = @"0 Stones";
            CurrentWeightPounds.text = @"0 Pounds";
            CurrentWeightKilograms.text = @"0 Kilograms";
            
            return;
        }
        
        if(CurrentWeightDrag.center.x + finalx > 344){
            
            [prefs setFloat:26.8 forKey:@"currentweight"];
            CurrentWeightStones.text = @"26.8 Stones";
            CurrentWeightPounds.text = @"375 Pounds";
            CurrentWeightKilograms.text = @"170 Kilograms";
            
            return;
        }
        
        CGPoint point = CGPointMake(CurrentWeightDrag.center.x + finalx ,CurrentWeightDrag.center.y );
        
        CurrentWeightDrag.center = point;
        
        CurrentWeightStones.text = [NSString stringWithFormat: @"%.1f", ((CurrentWeightDrag.center.x) / 12.74)];
        
        CurrentWeightPounds.text = [NSString stringWithFormat: @"%.0f", ((CurrentWeightDrag.center.x) / 12.74) * 14];
        
        CurrentWeightKilograms.text = [NSString stringWithFormat: @"%.0f", ((CurrentWeightKilograms.center.x) / 12.74) * 6.35029];
        
        
        CurrentWeightStones.text  = [CurrentWeightStones.text stringByAppendingString:@" Stones"];
        CurrentWeightPounds.text =  [CurrentWeightPounds.text stringByAppendingString:@" Pounds"];
        CurrentWeightKilograms.text =  [CurrentWeightKilograms.text stringByAppendingString:@" Kilograms"];
        
        
        currentstones = ((CurrentWeightDrag.center.x) / 12.74);
        
        StonesLost.text = [NSString stringWithFormat: @"%.1f", startingstones - currentstones];
        PoundsLost.text = [NSString stringWithFormat: @"%.0f", (startingstones - currentstones) * 14];
        
        KilogramsLost.text = [NSString stringWithFormat: @"%.0f", (startingstones - currentstones) * 6.35029];
        
        
        [prefs setFloat:CurrentWeightDrag.center.x forKey:@"currentweight"];

        
    }

    if (y > 29 && y < 93 && (x) > 362 + 98 && (x ) < 362 + 120 )
    {
    
        CGPoint point = CGPointMake(x,ResetDrag.center.y );
        
        ResetDrag.center = point;
        
        reset_touched = YES;
        
    }

    
//    if (x > 87 && x < 155 && (y + 216) < 681 && (y + 216) > 313 )
//    {
//        CGPoint point = CGPointMake(dragLunch.center.x,y + 216 );
//        
//        dragLunch.center = point;
//    }
//    
//    if (x > 165 && x < 233 && (y + 216) < 681 && (y + 216) > 313 )
//    {
//        CGPoint point = CGPointMake(dragDinner.center.x,y + 216 );
//        
//        dragDinner.center = point;
//    }
//    
//    
//    if (x > 242 && x < 310 && (y + 216) < 681 && (y + 216) > 313 )
//    {
//        CGPoint point = CGPointMake(dragSnacks.center.x,y + 216 );
//        
//        dragSnacks.center = point;
//    }
    
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *Drag = [[event allTouches] anyObject];
    
    old_x = [Drag locationInView:self.view].x;
    old_y = [Drag locationInView:self.view].y;
    
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGFloat x = 362 + 98;
    CGFloat y = 29 + 32;
    
    CGPoint point = CGPointMake(x,y);
    
    ResetDrag.center = point;
    
    if(reset_touched == YES){
        
        if(reset == false){
            reset = true;
            lblReally.text = @"Really?";
        }
        else {
        
            NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        
            [standardDefaults setFloat:0.0 forKey:@"calories"];
            [standardDefaults setFloat:0.0 forKey:@"startingweight"];
            [standardDefaults setFloat:0.0 forKey:@"currentweight"];
            [standardDefaults setFloat:680.0 forKey:@"breakfast"];
            [standardDefaults setFloat:680.0 forKey:@"lunch"];
            [standardDefaults setFloat:680.0 forKey:@"dinner"];
            [standardDefaults setFloat:680.0 forKey:@"snacks"];

            [self viewDidLayoutSubviews];
        
            lblReally.text = @"";
            reset = false;
    
        }
        
        reset_touched = NO;
    
    }
    
}




@end
