//
//  SettingsViewController.h
//  Intake
//
//  Created by Arthur on 10/5/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
{
    
    __weak IBOutlet UILabel *lblReally;
    __weak IBOutlet UILabel *lblDailyIntake;
   
    __weak IBOutlet UIImageView *DailyIntakeDrag;
    __weak IBOutlet UIImageView *StartingWeightDrag;
    __weak IBOutlet UIImageView *CurrentWeightDrag;
    __weak IBOutlet UIImageView *ResetDrag;
    
    __weak IBOutlet UILabel *StartingWeightStones;
    __weak IBOutlet UILabel *StartingWeightPounds;
    __weak IBOutlet UILabel *StartingWeightKilograms;
    
    __weak IBOutlet UILabel *CurrentWeightStones;
    __weak IBOutlet UILabel *CurrentWeightPounds;
    __weak IBOutlet UILabel *CurrentWeightKilograms;
    
    __weak IBOutlet UILabel *StonesLost;
    __weak IBOutlet UILabel *PoundsLost;
    __weak IBOutlet UILabel *KilogramsLost;
    
    float startingstones;
    float currentstones;
    
    bool reset;
    bool reset_touched;
    
    CGFloat old_x;
    CGFloat old_y;

    
}

@end
