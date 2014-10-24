//
//  ViewController.m
//  TicTacToeChallenge
//
//  Created by Andrew Liu on 10/23/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

#import "RootViewController.h"
//ADD A #DEFINE FOR X AND O VALUES ??

@interface RootViewController () <UIAlertViewDelegate>
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
@property (weak, nonatomic) IBOutlet UILabel *xButtonLabel;
@property (weak, nonatomic) IBOutlet UILabel *oButtonLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property CGPoint point;

@end


@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.whichPlayerLabel.text = @"X";
    self.whichPlayerLabel.textColor = [UIColor blueColor];

    UIPanGestureRecognizer *xButtonPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(xButtonHandler:)];
    [self.xButtonLabel addGestureRecognizer:xButtonPan];
    self.xButtonLabel.userInteractionEnabled = YES;

    UIPanGestureRecognizer *oButtonPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(oButtonHandler:)];
    [self.oButtonLabel addGestureRecognizer:oButtonPan];
    self.oButtonLabel.userInteractionEnabled = YES;
}

//This function determines which label is tapped based on the point, returns that Label
- (UILabel *) findLabelUsingPoint: (CGPoint)point
{
    if(CGRectContainsPoint(self.labelOne.frame, point)) //if point is inside labelOne's frame, return labelOne
    {
        return self.labelOne;
    }
    else if(CGRectContainsPoint(self.labelTwo.frame, point))
    {
        return self.labelTwo;
    }
    else if(CGRectContainsPoint(self.labelThree.frame, point))
    {
        return self.labelThree;
    }
    else if(CGRectContainsPoint(self.labelFour.frame, point))
    {
        return self.labelFour;
    }
    else if(CGRectContainsPoint(self.labelFive.frame, point))
    {
        return self.labelFive;
    }
    else if(CGRectContainsPoint(self.labelSix.frame, point))
    {
        return self.labelSix;
    }
    else if(CGRectContainsPoint(self.labelSeven.frame, point))
    {
        return self.labelSeven;
    }
    else if(CGRectContainsPoint(self.labelEight.frame, point))
    {
        return self.labelEight;
    }
    else if(CGRectContainsPoint(self.labelNine.frame, point))
    {
        return self.labelNine;
    }
    return nil;

}

//on label tapped, get the label
//and then change that label's value'
//and then change the user interaction to be disabled

- (IBAction)onLabelTapped:(UITapGestureRecognizer *)gesture
{
    self.point = [gesture locationInView:self.view];

    UILabel *tappedLabel = [self findLabelUsingPoint:self.point];


    tappedLabel.text = self.whichPlayerLabel.text;
    tappedLabel.textColor = self.whichPlayerLabel.textColor;

    if ([tappedLabel.text  isEqual: @"X"])
    {
        self.whichPlayerLabel.text = @"O";
        self.whichPlayerLabel.textColor = [UIColor redColor];
    }
    else
    {
        self.whichPlayerLabel.text = @"X";
        self.whichPlayerLabel.textColor = [UIColor blueColor];
    }

    [self checkWhoWins:[self whoWon]];
}

// If someone won, then proclaim victory with an alert, button should start new game
- (void) checkWhoWins : (NSString *)isWinner
{
    if (isWinner != nil)
    {
        NSString *message= [NSString stringWithFormat:@"%@ won this round!", isWinner];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"HOORAY!!!" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"Play again", nil];

        //UIAlertController used instead of UIAlertView

        [alert show];
        
    }
    //!!!! ADD IF IT'S A DRAW
}

// defining the reset button for when Alert view is tapped
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self resetGame:YES];
    }
}

- (NSString *)whoWon
{
    NSString *currentPlayer = self.whichPlayerLabel.text;
    NSString *previousPlayer = nil;

    if ([currentPlayer isEqualToString:@"X"])
    {
        previousPlayer = @"O";
    }
    else if ([currentPlayer isEqualToString:@"O"])
    {
        previousPlayer = @"X";
    }

    //Checking top row 123
    if ([self.labelOne.text isEqualToString:previousPlayer] && [self.labelTwo.text isEqualToString:previousPlayer] &&
        [self.labelThree.text isEqualToString:previousPlayer])
    {
        return self.labelOne.text;
    }

    //Checking middle row 456
    else if ([self.labelFour.text isEqualToString:previousPlayer] && [self.labelFive.text isEqualToString:previousPlayer] &&
        [self.labelSix.text isEqualToString:previousPlayer])
    {
        return self.labelFour.text;
    }

    //Checking bottom row 789
    else if ([self.labelSeven.text isEqualToString:previousPlayer] && [self.labelEight.text isEqualToString:previousPlayer] &&
        [self.labelNine.text isEqualToString:previousPlayer])
    {
        return self.labelSeven.text;
    }

    //Checking left column 147
    else if ([self.labelOne.text isEqualToString:previousPlayer] && [self.labelFour.text isEqualToString:previousPlayer] &&
        [self.labelSeven.text isEqualToString:previousPlayer])
    {
        return self.labelOne.text;
    }

    //Checking middle column 258
    else if ([self.labelTwo.text isEqualToString:previousPlayer] && [self.labelFive.text isEqualToString:previousPlayer] &&
             [self.labelEight.text isEqualToString:previousPlayer])
    {
        return self.labelTwo.text;
    }

    //Checking right column 369
    else if ([self.labelThree.text isEqualToString:previousPlayer] && [self.labelSix.text isEqualToString:previousPlayer] &&
             [self.labelNine.text isEqualToString:previousPlayer])
    {
        return self.labelThree.text;
    }

    //Checking diagonal from top left to bottom right 159
    else if ([self.labelOne.text isEqualToString:previousPlayer] && [self.labelFive.text isEqualToString:previousPlayer] &&
             [self.labelNine.text isEqualToString:previousPlayer])
    {
        return self.labelOne.text;
    }

    //Checking diagonal from top left to bottom right 357
    else if ([self.labelThree.text isEqualToString:previousPlayer] && [self.labelFive.text isEqualToString:previousPlayer] &&
             [self.labelSeven.text isEqualToString:previousPlayer])
    {
        return self.labelThree.text;
    }

    else
    {
        // everything is filled and
        //if it's a draw
        //then return ?
        return nil;
    }

}

- (void) resetGame: (BOOL) reset
{
    if (reset == YES)
    {
        self.labelOne.text = nil;
        self.labelTwo.text = nil;
        self.labelThree.text = nil;
        self.labelFour.text = nil;
        self.labelFive.text = nil;
        self.labelSix.text = nil;
        self.labelSeven.text = nil;
        self.labelEight.text = nil;
        self.labelNine.text = nil;
    }
}

// when the gesture is happening, these are being called
//gesture state can be here
- (void)xButtonHandler:(UIPanGestureRecognizer *)gesture {

    CGPoint point = [gesture locationInView:self.view];

    // where the finger touches, will be where the center of the frame will be
    self.xButtonLabel.center = point;

    // when gesture ends, check if it's on a label, if that label is empty, set it to the whoseplayer label property
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint endPoint = [gesture locationInView:self.view];
        UILabel *tappedLabel = [self findLabelUsingPoint:endPoint];

        //if the label is empty then set it to whichPlayerLabel text and bgColor

        if (![tappedLabel.text isEqual:@"X"] && ![tappedLabel.text isEqual:@"O"])
        {
            tappedLabel.text = self.whichPlayerLabel.text;
            tappedLabel.textColor = self.whichPlayerLabel.textColor;
            self.whichPlayerLabel.text = @"O";
            self.whichPlayerLabel.textColor = [UIColor redColor];
        }

        else if([tappedLabel.text isEqual: @"X"])
        {
            self.whichPlayerLabel.text = @"O";
            self.whichPlayerLabel.textColor = [UIColor redColor];
        }


        else if([tappedLabel.text isEqual: @"0"])
        {
            self.whichPlayerLabel.text = @"X";
            self.whichPlayerLabel.textColor = [UIColor blueColor];
        }
    }

    [self checkWhoWins:[self whoWon]];

}

- (void)oButtonHandler:(UIPanGestureRecognizer *)gesture
{

    CGPoint point = [gesture locationInView:self.view];

    // where the finger touches, will be where the center of the frame will be
    self.oButtonLabel.center = point;

    // when gesture ends, check if it's on a label, if that label is empty, set it to the whoseplayer label property
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint endPoint = [gesture locationInView:self.view];
        UILabel *tappedLabel = [self findLabelUsingPoint:endPoint];

        //if the label is empty then set it to whichPlayerLabel text and bgColor

        if (![tappedLabel.text isEqual:@"X"] && ![tappedLabel.text isEqual:@"O"])
        {
            tappedLabel.text = self.whichPlayerLabel.text;
            tappedLabel.textColor = self.whichPlayerLabel.textColor;
            self.whichPlayerLabel.text = @"X";
            self.whichPlayerLabel.textColor = [UIColor blueColor];
        }

        else if([tappedLabel.text isEqual: @"X"])
        {
            self.whichPlayerLabel.text = @"O";
            self.whichPlayerLabel.textColor = [UIColor redColor];
        }


        else if([tappedLabel.text isEqual: @"0"])
        {
            self.whichPlayerLabel.text = @"X";
            self.whichPlayerLabel.textColor = [UIColor blueColor];
        }
    }
    
    [self checkWhoWins:[self whoWon]];

}



//    NSMutableArray *ticTacToeBoardValue = [[NSMutableArray alloc] init];
//    ticTacToeBoardValue [0] = [self.labelOne.text isEqualToString:previousPlayer];
//    ticTacToeBoardValue [1] = [self.labelOne.text isEqualToString:previousPlayer];
//    ticTacToeBoardValue [2] = self.labelThree.text;
//    ticTacToeBoardValue [3] = self.labelFour.text;
//    ticTacToeBoardValue [4] = self.labelFive.text;
//    ticTacToeBoardValue [5] = self.labelSix.text;
//    ticTacToeBoardValue [6] = self.labelSeven.text;
//    ticTacToeBoardValue [7] = self.labelEight.text;
//    ticTacToeBoardValue [8] = self.labelNine.text;


@end
