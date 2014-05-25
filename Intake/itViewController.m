//
//  itViewController.m
//  Intake
//
//  Created by Arthur on 10/4/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "itViewController.h"

@interface itViewController ()

@end

@implementation itViewController

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

}

- (void)viewDidLayoutSubviews
{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    
    float calories = [standardDefaults floatForKey:@"calories"];
    
    float dailyintake;
    float calx;
    calx =  ((calories) / 344 ) * 3300;
    dailyintake = 0.0;
    
    float perc;
    float breakfast = [standardDefaults floatForKey:@"breakfast"];
    
    CGPoint pointb = CGPointMake(dragBreakfast.center.x,breakfast);
    dragBreakfast.center = pointb;
    
    perc = abs(breakfast - 680);
    dailyintake = dailyintake + ((perc/368) * calx);
    printf("dailyintake 1: %f\n", dailyintake);
    perc = (perc / 368) * 100;
    BreakfastPercentage.text = [NSString stringWithFormat: @"%.0f", perc];
    BreakfastPercentage.text = [BreakfastPercentage.text stringByAppendingString:@"%"];

    float lunch = [standardDefaults floatForKey:@"lunch"];
    CGPoint pointl = CGPointMake(dragLunch.center.x,lunch );
    dragLunch.center = pointl;

    perc = abs(lunch - 680);
    dailyintake = dailyintake + ((perc/368) * calx);
    printf("dailyintake 2: %f\n", dailyintake);
    perc = (perc / 368) * 100;
    LunchPercentage.text = [NSString stringWithFormat: @"%.0f", perc];
    LunchPercentage.text = [LunchPercentage.text stringByAppendingString:@"%"];

    float dinner = [standardDefaults floatForKey:@"dinner"];
    CGPoint pointd = CGPointMake(dragDinner.center.x,dinner );
    dragDinner.center = pointd;
  
    perc = abs(dinner - 680);
    dailyintake = dailyintake + ((perc/368) * calx);
    printf("dailyintake 3: %f\n", dailyintake);
    perc = (perc / 368) * 100;
    DinnerPercentage.text = [NSString stringWithFormat: @"%.0f", perc];
    DinnerPercentage.text = [DinnerPercentage.text stringByAppendingString:@"%"];
    
    float snacks = [standardDefaults floatForKey:@"snacks"];
    CGPoint points = CGPointMake(dragSnacks.center.x,snacks);
    dragSnacks.center = points;
    
    perc = abs(snacks - 680);
    dailyintake = dailyintake + ((perc/368) * calx);
    printf("dailyintake 4: %f\n\n", dailyintake);
    perc = (perc / 368) * 100;
    SnacksPercentage.text = [NSString stringWithFormat: @"%.0f", perc];
    SnacksPercentage.text = [SnacksPercentage.text stringByAppendingString:@"%"];

    DailyIntakeTotal.text = [NSString stringWithFormat: @"%.0f", dailyintake ];
    DailyIntakePercentage.text = [NSString stringWithFormat: @"%.0f", (dailyintake / calx) * 100 ];
    
    float percentage = (dailyintake / calx) * 100;
    
    if (percentage >= 0 && percentage <= 30)
    {
        [dailyIntakeBG setBackgroundColor:[UIColor colorWithRed:70/255.0 green:223/255.0 blue:202/255.0 alpha:1]];
   
    }
    
    if (percentage >= 31 && percentage <= 60)
    {
        [dailyIntakeBG setBackgroundColor:[UIColor colorWithRed:236/255.0 green:188/255.0 blue:131/255.0 alpha:1]];
        
    }
    
    if (percentage >= 61 && percentage <= 90)
    {
        [dailyIntakeBG setBackgroundColor:[UIColor colorWithRed:105/255.0 green:208/255.0 blue:247/255.0 alpha:1]];
        
    }
    
    if (percentage >= 91 && percentage <= 100)
    {
        [dailyIntakeBG setBackgroundColor:[UIColor colorWithRed:255/255.0 green:118/255.0 blue:98/255.0 alpha:1]];
        
    }
    
    if (percentage >= 101)
    {
        [dailyIntakeBG setBackgroundColor:[UIColor colorWithRed:255/255.0 green:1/255.0 blue:1/255.0 alpha:1]];
        
    }
    
    DailyIntakePercentage.text = [DailyIntakePercentage.text stringByAppendingString:@"%"];
    
    if(calories < 217.0) {
             DailyIntakePercentage.text =[@"0" stringByAppendingString:@"%"];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib
{
    isShowingLandscapeView = NO;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)orientationChanged:(NSNotification *)notification
{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation) &&
        !isShowingLandscapeView)
    {
        
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [main instantiateViewControllerWithIdentifier:@"view2controller"];
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
   
        [self presentViewController:vc animated:YES completion:nil];
        
        isShowingLandscapeView = YES;
    }
    else if (UIDeviceOrientationIsPortrait(deviceOrientation) &&
             isShowingLandscapeView)
    {
            [self dismissViewControllerAnimated:YES completion:nil];
            isShowingLandscapeView = NO;
        
    }
}
-(BOOL)shouldAutorotate
{
    return NO;
}

float oldX, oldY;
BOOL dragging;


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    if ([[touch.view class] isSubclassOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)touch.view;
        if (CGRectContainsPoint(label.frame, touchLocation)) {
            dragging = YES;
            oldX = touchLocation.x;
            oldY = touchLocation.y;
        }
    }
    
    
    old_x = [touch locationInView:self.view].x;
    old_y = [touch locationInView:self.view].y;

    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [caloriesBG setBackgroundColor:[UIColor colorWithRed:133/255.0 green:133/255.0 blue:132/255.0 alpha:1]];
    lblY.text = [NSString stringWithFormat: @"%.0f", 0.0];
    
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    UITouch *Drag = [[event allTouches] anyObject];
    
    CGFloat y = [Drag locationInView:self.view].y ;
    CGFloat x = [Drag locationInView:self.view].x;
    
    //BREAKFAST
    if (x > 10 && x < 78 && dragBreakfast.center.y <= 682 && dragBreakfast.center.y >= 313 )
    {
        float calx = [standardDefaults floatForKey:@"calories"];
        CGFloat finaly;

        if (y < dragBreakfast.frame.origin.y){ return; }
        
        finaly = y - old_y;
        
        if(abs(finaly) < 2 ) {
            finaly = .00625 * finaly;
        }
        else {
            finaly = 1 * finaly;
        }
        
        old_x = [Drag locationInView:self.view].x ;
        old_y = [Drag locationInView:self.view].y ;
        
        CGPoint point = CGPointMake(dragBreakfast.center.x,dragBreakfast.center.y + finaly);
        
        dragBreakfast.center = point;
        
        [caloriesBG setBackgroundColor:[UIColor colorWithRed:70/255.0 green:223/255.0 blue:202/255.0 alpha:1]];
    
        float perc;
        perc = abs((dragBreakfast.center.y + finaly) - 682);
        
        calx = (calx / 344) * 3300;
        perc = (perc / 368) * 100;

        lblY.text = [NSString stringWithFormat: @"%.0f",  (perc / 100) * calx ];
        
        BreakfastPercentage.text = [NSString stringWithFormat: @"%.0f", perc];
        BreakfastPercentage.text = [BreakfastPercentage.text stringByAppendingString:@"%"];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setFloat:(dragBreakfast.center.y) forKey:@"breakfast"];
        printf("breakfast: %f\n",dragBreakfast.center.y);
        
    }
    
    //LUNCH
    if (x > 87 && x < 155 && dragLunch.center.y <= 682 && dragLunch.center.y > 313 )
    {
        
        if( y < dragLunch.frame.origin.y) { return; }
        
        CGFloat finaly;
        finaly = y - old_y;
        
        if(abs(finaly) < 2 ) {
            finaly = 0.0625 * finaly;
        }
        else {
            finaly = 1 * finaly;
        }
        
        old_x = [Drag locationInView:self.view].x ;
        old_y = [Drag locationInView:self.view].y ;
        
        CGPoint point = CGPointMake(dragLunch.center.x, dragLunch.center.y + finaly);
        
        dragLunch.center = point;
        
        [caloriesBG setBackgroundColor:[UIColor colorWithRed:236/255.0 green:188/255.0 blue:131/255.0 alpha:1]];
   
        float perc;
        perc = abs((dragLunch.center.y + finaly) - 682);
        
        float calx = [standardDefaults floatForKey:@"calories"];
        calx = (calx / 344) * 3300;
        perc = (perc / 368) * 100;
        
        lblY.text = [NSString stringWithFormat: @"%.0f",  (perc / 100) * calx ];
        
        LunchPercentage.text = [NSString stringWithFormat: @"%.0f", perc];
        LunchPercentage.text = [LunchPercentage.text stringByAppendingString:@"%"];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setFloat:(dragLunch.center.y) forKey:@"lunch"];
        

    }
    
    
    //DINNER
    if (x > 165 && x < 233 && dragDinner.center.y <= 682 && dragDinner.center.y > 313 )
    {
        
        if(y < dragDinner.frame.origin.y) { return; }
        
        CGFloat finaly;
        finaly = y - old_y;
        
        if(abs(finaly) < 2) {
            finaly = 0.0625 * finaly;
        }
        else {
            finaly = 1 * finaly;
        }
        
        old_x = [Drag locationInView:self.view].x ;
        old_y = [Drag locationInView:self.view].y ;
        
        CGPoint point = CGPointMake(dragDinner.center.x,dragDinner.center.y + finaly);
        
        dragDinner.center = point;
        
        [caloriesBG setBackgroundColor:[UIColor colorWithRed:105/255.0 green:208/255.0 blue:247/255.0 alpha:1]];
    
        float perc;
        perc = abs((dragDinner.center.y + finaly) - 682);
        
        float calx = [standardDefaults floatForKey:@"calories"];
        calx = (calx / 344) * 3300;
        perc = (perc / 368) * 100;
        
        lblY.text = [NSString stringWithFormat: @"%.0f",  (perc / 100) * calx ];
        
        DinnerPercentage.text = [NSString stringWithFormat: @"%.0f", perc];
        DinnerPercentage.text = [DinnerPercentage.text stringByAppendingString:@"%"];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setFloat:(dragDinner.center.y) forKey:@"dinner"];

    }

    //SNACKS
    if (x > 242 && x < 310 && dragSnacks.center.y <= 682 && dragSnacks.center.y > 313 )
    {
        
        if(y < dragSnacks.frame.origin.y){ return; }
        
        CGFloat finaly;
        finaly = y - old_y;
        
        if(abs(finaly) < 2 ) {
            finaly = 0.0625 * finaly;
        }
        else {
            finaly = 1 * finaly;
        }
        
        old_x = [Drag locationInView:self.view].x ;
        old_y = [Drag locationInView:self.view].y ;
        
        CGPoint point = CGPointMake(dragSnacks.center.x, dragSnacks.center.y + finaly);
        
        dragSnacks.center = point;
        
        [caloriesBG setBackgroundColor:[UIColor colorWithRed:255/255.0 green:118/255.0 blue:98/255.0 alpha:1]];
        
        float perc;
        perc = abs((dragSnacks.center.y) - 682);
        
        float calx = [standardDefaults floatForKey:@"calories"];
        calx = (calx / 344) * 3300;
        perc = (perc / 368) * 100;
        
        lblY.text = [NSString stringWithFormat: @"%.0f",  (perc / 100) * calx ];
        
        SnacksPercentage.text = [NSString stringWithFormat: @"%.0f", perc];
        SnacksPercentage.text = [SnacksPercentage.text stringByAppendingString:@"%"];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setFloat:(dragSnacks.center.y) forKey:@"snacks"];
        
    }
    
    
    //RESET BREAKFAST
    if(dragBreakfast.center.y  >= 682 ){
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setFloat:680 forKey:@"breakfast"];
        CGPoint point = CGPointMake(dragBreakfast.center.x,680);
        
        dragBreakfast.center = point;
        
        return;
    }
    
    if( dragBreakfast.center.y <= 313){
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setFloat:315 forKey:@"breakfast"];
        
        CGPoint point = CGPointMake(dragBreakfast.center.x,315);
        
        dragBreakfast.center = point;
        return;
    }
    //END RESET BREAKFAST
    
    //RESET LUNCH
    if(dragLunch.center.y  >= 682 ){
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setFloat:680 forKey:@"lunch"];
        CGPoint point = CGPointMake(dragLunch.center.x,680);
        
        dragLunch.center = point;
        
        return;
    }
    
    if( dragLunch.center.y <= 313){
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setFloat:315 forKey:@"lunch"];
        
        CGPoint point = CGPointMake(dragLunch.center.x,315);
        
        dragLunch.center = point;
        return;
    }
    //END RESET LUNCH
    
    
    //RESET DINNER
    if(dragDinner.center.y  >= 682 ){
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setFloat:680 forKey:@"dinner"];
        CGPoint point = CGPointMake(dragDinner.center.x,680);
        
        dragDinner.center = point;
        
        return;
    }
    
    if( dragDinner.center.y <= 313){
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setFloat:315 forKey:@"dinner"];
        
        CGPoint point = CGPointMake(dragDinner.center.x,315);
        
        dragDinner.center = point;
        return;
    }
    //END RESET DINNER
    
    //RESET SNACKS
    if(dragSnacks.center.y  >= 682 ){
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setFloat:680 forKey:@"snacks"];
        CGPoint point = CGPointMake(dragSnacks.center.x,680);
        
        dragSnacks.center = point;
        
        return;
    }
    
    if( dragSnacks.center.y <= 313){
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setFloat:315 forKey:@"snacks"];
        
        CGPoint point = CGPointMake(dragSnacks.center.x,315);
        
        dragSnacks.center = point;
        return;
    }
    //END RESET SNACKS
    
    
    [self viewDidLayoutSubviews];

}


@end
