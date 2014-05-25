//
//  itViewController.h
//  Intake
//
//  Created by Arthur on 10/4/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface itViewController : UIViewController {

    BOOL isShowingLandscapeView;
    __weak IBOutlet UIImageView *dragBreakfast;
    __weak IBOutlet UIImageView *dragLunch;
    __weak IBOutlet UILabel *lblY;
    __weak IBOutlet UIImageView *dragDinner;
    __weak IBOutlet UIImageView *dragSnacks;
    
    __weak IBOutlet UIView *caloriesBG;
    
    __weak IBOutlet UIView *dailyIntakeBG;
    
    __weak IBOutlet UILabel *BreakfastPercentage;
    __weak IBOutlet UILabel *LunchPercentage;
    __weak IBOutlet UILabel *DinnerPercentage;
    __weak IBOutlet UILabel *SnacksPercentage;
        __weak IBOutlet UILabel *DailyIntakeTotal;
    
    __weak IBOutlet UILabel *DailyIntakePercentage;
    
    
    CGFloat old_x;
    CGFloat old_y;

}


@end
