//
//  ViewController.m
//  TicTacToeChallenge
//
//  Created by Andrew Liu on 10/23/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelThree;
@property (weak, nonatomic) IBOutlet UILabel *labelFour;
@property (weak, nonatomic) IBOutlet UILabel *labelFive;
@property (weak, nonatomic) IBOutlet UILabel *labelSix;
@property (weak, nonatomic) IBOutlet UILabel *labelSeven;
@property (weak, nonatomic) IBOutlet UILabel *labelEight;
@property (weak, nonatomic) IBOutlet UILabel *labelNine;
@property (weak, nonatomic) IBOutlet UILabel *whichPlayerLabel;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) findLabelUsingPoint: (CGPoint)point
{
//define CGlabel




}

- (IBAction)onLabelTapped:(UITapGestureRecognizer *)gesture
{
    //find labelone
    CGPoint point = [gesture locationInView:self.view];
    if (CGRectContainsPoint(self.labelOne.frame, point)) {
        self.labelOne.text = self.whichPlayerLabel.text;
        self.labelOne.textColor = self.whichPlayerLabel.textColor;
    }
    //find labeltwo
    else if (CGRectContainsPoint(self.labelTwo.frame, point)){
        self.labelTwo.text = self.whichPlayerLabel.text;
        self.labelTwo.textColor = self.whichPlayerLabel.textColor;

    }
    else if (CGRectContainsPoint(self.labelThree.frame, point)){
        self.labelThree.text = self.whichPlayerLabel.text;
        self.labelThree.textColor = self.whichPlayerLabel.textColor;
        
    }
    else if (CGRectContainsPoint(self.labelFour.frame, point)){
        self.labelFour.text = self.whichPlayerLabel.text;
        self.labelFour.textColor = self.whichPlayerLabel.textColor;
        
    }
    else if (CGRectContainsPoint(self.labelFive.frame, point)){
        self.labelFive.text = self.whichPlayerLabel.text;
        self.labelFive.textColor = self.whichPlayerLabel.textColor;
        
    }
    else if (CGRectContainsPoint(self.labelSix.frame, point)){
        self.labelSix.text = self.whichPlayerLabel.text;
        self.labelSix.textColor = self.whichPlayerLabel.textColor;
        
    }
    else if (CGRectContainsPoint(self.labelSeven.frame, point)){
        self.labelSeven.text = self.whichPlayerLabel.text;
        self.labelSeven.textColor = self.whichPlayerLabel.textColor;
        
    }
    else if (CGRectContainsPoint(self.labelEight.frame, point)){
        self.labelEight.text = self.whichPlayerLabel.text;
        self.labelEight.textColor = self.whichPlayerLabel.textColor;
        
    }
    else if (CGRectContainsPoint(self.labelNine.frame, point)){
        self.labelNine.text = self.whichPlayerLabel.text;
        self.labelNine.textColor = self.whichPlayerLabel.textColor;

    }

    if ([self.whichPlayerLabel.text isEqual: @"X"]) {
        self.whichPlayerLabel.text = @"O";
    }
    else if([self.whichPlayerLabel.text isEqual: @"O"]) {
        self.whichPlayerLabel.text = @"X";
    }







//
//    CGPoint point = [gesture locationInView:self.view];
//    self.theFutureLabel.center = point;
//    if (CGRectContainsPoint(self.thePrecogsLabel.frame, point))
//    {
//        self.theFutureLabel.text = @"foobar foobar foobar";
//        self.theFutureLabel.backgroundColor = [UIColor redColor];
//        [self.theFutureLabel sizeToFit];
//    }


}

@end
