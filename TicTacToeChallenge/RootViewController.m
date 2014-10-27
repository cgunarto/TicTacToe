//
//  ViewController.m
//  TicTacToeChallenge
//
//  Created by Christina Gunarto on 10/23/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "RootViewController.h"
#include <stdlib.h>

#define ksecondsForTimer 16

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
@property CGPoint point;

@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property NSTimer *timer;

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property BOOL isPlayingWithComputer;
@property (strong, nonatomic) NSMutableArray *cornerLabelArray;


@end

//[self.timer invalidate]; // stop the timer -- this works
//[self countdownTimer];

@implementation RootViewController
//?? @synthesize counterLabel; this was in the example but is it necessary?

int seconds; // ?? should this be here ?
int secondsLeft; //?? should this be here ?

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Creating Pan Gesture recognizers for xButtonLabel and oButtonLabel
    UIPanGestureRecognizer *xButtonPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(xButtonHandler:)];
    [self.xButtonLabel addGestureRecognizer:xButtonPan];
    [self disableButtonLabel:self.xButtonLabel];


    UIPanGestureRecognizer *oButtonPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(oButtonHandler:)];
    [self.oButtonLabel addGestureRecognizer:oButtonPan];
    [self disableButtonLabel:self.oButtonLabel];

     self.cornerLabelArray= [NSMutableArray arrayWithObjects:self.labelOne, self.labelThree, self.labelSeven, self.labelNine, nil];
}

# pragma mark START GAME BUTTON AND INITIAL BUTTON STATE
- (IBAction)onStartButtonPressed:(id)sender
{
    [self startGame];
}

- (void) startGame
{
    secondsLeft = ksecondsForTimer;
    [self countdownTimer];
    [self enableButtonLabel:self.xButtonLabel];
    [self disableButtonLabel:self.oButtonLabel];
    self.startButton.enabled = NO;
}

- (void)disableButtonLabel: (UILabel *)labelButton
{
    labelButton.userInteractionEnabled = NO;
    labelButton.enabled = NO;
}

- (void)enableButtonLabel: (UILabel *)labelButton
{
    labelButton.userInteractionEnabled = YES;
    labelButton.enabled = YES;
}


#pragma mark TIMER AND COUNTER METHOD

-(void)countdownTimer
{
    if([self.timer isValid])
    {
        [self.timer invalidate];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];

}

- (void)updateCounter:(NSTimer *)theTimer
{
    if(secondsLeft > 0 ){
        secondsLeft -- ;
        seconds = (secondsLeft %3600) % 60;
        self.counterLabel.text = [NSString stringWithFormat:@":%02d", seconds];
    }
    else
    {
        if (self.isPlayingWithComputer == YES)
        {
            [self computerMakeMove];
        }
        else
        {
            secondsLeft = ksecondsForTimer;
            [self switchLabelToNextPlayer];
        }
    }
}


#pragma mark SWITCHING WHOSE PLAYER LABEL

- (void) switchLabelToNextPlayer
{
    if (self.isPlayingWithComputer == NO)
    {
        [self.timer invalidate]; //TESTING - if the label switches then timer should stop
        secondsLeft = ksecondsForTimer;
        [self countdownTimer];

        NSString *currentPlayer = self.whichPlayerLabel.text;
        if ([currentPlayer isEqualToString: @"X"])
        {
            self.whichPlayerLabel.text = @"O";
            self.whichPlayerLabel.textColor = [UIColor redColor];
            [self disableButtonLabel:self.xButtonLabel];
            [self enableButtonLabel:self.oButtonLabel];
        }

        else if ([currentPlayer isEqualToString: @"O"])
        {
            self.whichPlayerLabel.text = @"X";
            self.whichPlayerLabel.textColor = [UIColor blueColor];
            [self disableButtonLabel:self.oButtonLabel];
            [self enableButtonLabel:self.xButtonLabel];
        }
    }

    else
    {
        NSLog(@"Switch label knows that we're playing against a computer");

        NSString *currentPlayer = self.whichPlayerLabel.text;

        if ([currentPlayer isEqualToString: @"X"])
        {
            self.whichPlayerLabel.text = @"O";
            self.whichPlayerLabel.textColor = [UIColor redColor];
            [self disableButtonLabel:self.xButtonLabel];
            [self enableButtonLabel:self.oButtonLabel];
        }

        else if ([currentPlayer isEqualToString: @"O"])
        {
            self.whichPlayerLabel.text = @"X";
            self.whichPlayerLabel.textColor = [UIColor blueColor];
            [self disableButtonLabel:self.oButtonLabel];
            [self enableButtonLabel:self.xButtonLabel];
        }
    }


}

#pragma mark FIND LABEL USING POINT

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


#pragma mark GESTURE: TAP ACTIONS

//Created by ctrl and dragging instead of code
//Current player to tap on empty box to change its value, if it has X or O then it won't change
- (IBAction)onLabelTapped:(UITapGestureRecognizer *)gesture
{
    self.point = [gesture locationInView:self.view];

    UILabel *tappedLabel = [self findLabelUsingPoint:self.point];

    if (tappedLabel) //confirms if tap gesture is within a label
    {
        if (![tappedLabel.text isEqual:@"X"] && ![tappedLabel.text isEqual:@"O"])
        {
        tappedLabel.text = self.whichPlayerLabel.text;
        tappedLabel.textColor = self.whichPlayerLabel.textColor;
        [self switchLabelToNextPlayer];
        }
    }
    [self checkWhoWins:[self whoWon]];
}

#pragma mark GESTURE: PAN ACTIONS

// Pan gesture recognizer was added on VDL instead of ctrl dragged
// when the gesture is happening, these are being called, gesture state can be here
//Current player drag X or O on empty box to change its value, if it has X or O then it won't change

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
            [self switchLabelToNextPlayer];
        }

    }

    [self checkWhoWins:[self whoWon]];

}

- (void)oButtonHandler:(UIPanGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:self.view];
    UILabel *tappedLabel = [self findLabelUsingPoint:point];

    // where the finger touches, will be where the center of the frame will be
    self.oButtonLabel.center = point;

    // when gesture ends, check if it's on a label, if that label is empty, set it to the whoseplayer label property
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        //This deletes the flickering for some reason
        CGPoint endPoint = [gesture locationInView:self.view];
        tappedLabel = [self findLabelUsingPoint:endPoint];

        //if the label is empty then set it to whichPlayerLabel text and bgColor
        if (![tappedLabel.text isEqual:@"X"] && ![tappedLabel.text isEqual:@"O"])
        {
            tappedLabel.text = self.whichPlayerLabel.text;
            tappedLabel.textColor = self.whichPlayerLabel.textColor;
            [self switchLabelToNextPlayer];
        }
    }
    [self checkWhoWins:[self whoWon]];
    
}

#pragma mark GAME : CHECKING WHO WINS
// If someone won, then proclaim victory with an alert, button should start new game
- (void) checkWhoWins : (NSString *)isWinner
{
    if ([isWinner isEqual:@"X"]||[isWinner isEqual:@"O"])
    {
        NSString *message= [NSString stringWithFormat:@"%@ won this round!", isWinner];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"HOORAY!!!" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"Play again", nil];
        //UIAlertController used instead of UIAlertView
        [alert show];
        
    }

    else if ([isWinner isEqual:@"draw"])
    {
        NSString *message= [NSString stringWithFormat:@"%@ won this round!", isWinner];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"IT'S A DRAW!!!" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"Play again", nil];
        //UIAlertController used instead of UIAlertView
        [alert show];
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

    //if board is not all full, check to see who is the winner
    //if board is all full, then nobody wins, return nil

    //if all the board is filled then return this below

    int gameState = 0;
    NSMutableArray *boardState = [[NSMutableArray alloc] initWithObjects:self.labelOne.text, self.labelTwo.text, self.labelThree.text, self.labelFour.text, self.labelFive.text, self.labelSix.text, self.labelSeven.text, self.labelEight.text, self.labelNine.text, nil];

    for (int i = 0; i < 9; i++)
    {
        if ([boardState[i] isEqual: @"X"] || [boardState[i]isEqual:@"O"] )
        {
            gameState = gameState + 1;
        }
    }

    if ([self.labelOne.text isEqualToString:previousPlayer] && [self.labelTwo.text isEqualToString:previousPlayer] &&
        [self.labelThree.text isEqualToString:previousPlayer])
    {
        return self.labelOne.text;

    }

    //Checking middle row 456
    else
        if ([self.labelFour.text isEqualToString:previousPlayer] && [self.labelFive.text isEqualToString:previousPlayer] &&
        [self.labelSix.text isEqualToString:previousPlayer])
        {
            return self.labelFour.text;
        }

    //Checking bottom row 789
    else
        if ([self.labelSeven.text isEqualToString:previousPlayer] && [self.labelEight.text isEqualToString:previousPlayer] &&
        [self.labelNine.text isEqualToString:previousPlayer])
        {
            return self.labelSeven.text;
        }

    //Checking left column 147
    else
        if ([self.labelOne.text isEqualToString:previousPlayer] && [self.labelFour.text isEqualToString:previousPlayer] &&
        [self.labelSeven.text isEqualToString:previousPlayer])
        {
            return self.labelOne.text;
        }

    //Checking middle column 258
    else
        if ([self.labelTwo.text isEqualToString:previousPlayer] && [self.labelFive.text isEqualToString:previousPlayer] &&
             [self.labelEight.text isEqualToString:previousPlayer])
        {
            return self.labelTwo.text;
        }

    //Checking right column 369
    else
        if ([self.labelThree.text isEqualToString:previousPlayer] && [self.labelSix.text isEqualToString:previousPlayer] &&
             [self.labelNine.text isEqualToString:previousPlayer])
        {
            return self.labelThree.text;
        }

    //Checking diagonal from top left to bottom right 159
    else
        if ([self.labelOne.text isEqualToString:previousPlayer] && [self.labelFive.text isEqualToString:previousPlayer] &&
             [self.labelNine.text isEqualToString:previousPlayer])
        {
            return self.labelOne.text;
        }

    //Checking diagonal from top left to bottom right 357
    else
        if ([self.labelThree.text isEqualToString:previousPlayer] && [self.labelFive.text isEqualToString:previousPlayer] &&
             [self.labelSeven.text isEqualToString:previousPlayer])
        {
            return self.labelThree.text;
        }

   else
   {
       if (gameState == 9)
          {
              return @"draw";
          }
          else
          {
          return nil;
          }
    }

}

#pragma mark ALERT VIEW AND RESET GAME

// defining the reset button for when Alert view is tapped
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self resetGame:YES];
    }
}

- (void) resetGame: (BOOL) reset
{
    if (reset == YES)
    {
        self.labelOne.text = @"";
        self.labelTwo.text = @"";
        self.labelThree.text = @"";
        self.labelFour.text = @"";
        self.labelFive.text = @"";
        self.labelSix.text = @"";
        self.labelSeven.text = @"";
        self.labelEight.text = @"";
        self.labelNine.text = @"";
        self.whichPlayerLabel.text = @"X";
        self.whichPlayerLabel.textColor = [UIColor blueColor];
        [self.timer invalidate];
        self.startButton.enabled = YES;

    }
}

#pragma mark PLAY AGAINST COMPUTER


- (IBAction)vsCompButtonPressed:(id)sender
{
    self.isPlayingWithComputer = YES;
    [self computerMakeMove];
    self.startButton.enabled = NO;
}

- (void)computerMakeMove
{
    // Find the empty boards and fill it with something
    NSMutableArray *boardState = [[NSMutableArray alloc] initWithObjects:self.labelOne, self.labelTwo, self.labelThree, self.labelFour, self.labelFive, self.labelSix, self.labelSeven, self.labelEight, self.labelNine, nil];
    NSMutableArray *emptyLabels = [[NSMutableArray alloc] init];

    // if it's computer X's turn and there are all open labels left, take the corner label
    if ([self.whichPlayerLabel.text isEqualToString: @"X"] && self.isPlayingWithComputer == YES )
    {
        for (int i = 0; i < 9; i++)
        {
            if ([[boardState[i] text] isEqual: @""])
            {
                [emptyLabels addObject:[boardState objectAtIndex:i]];
            }
        }

        if ([emptyLabels count] == 9)
        {
            self.labelOne.text = @"X";
            self.labelOne.textColor = [UIColor blueColor];
            [self switchLabelToNextPlayer];
        }

        else
            if (([emptyLabels count] == 7) && [[boardState[4] text] isEqual:@"O"]) //if player takes the middle box
            {
                self.labelThree.text = @"X";
                self.labelThree.textColor = [UIColor blueColor];
                [self switchLabelToNextPlayer];
            }

        else
            {
                UILabel *randomEmptyLabel = [emptyLabels objectAtIndex: arc4random() % [emptyLabels count]];
                randomEmptyLabel.text = @"X";
                randomEmptyLabel.textColor = [UIColor blueColor];
                [self switchLabelToNextPlayer];
            }

    }

    if ([emptyLabels count] > 0)
    {
        [self playerMakeMove];
    }


}

- (void)playerMakeMove
{
    [self countdownTimer];
    [self checkWhoWins:[self whoWon]];
    NSLog(@"player next move is called!");
    // Timer has 15 seconds to make move and then it switches to computer move
}

//- (void) switchToComputer
//{
////    [self.timer invalidate];
////    secondsLeft = ksecondsForTimer;
//
//    NSString *currentPlayer = self.whichPlayerLabel.text;
//    if ([currentPlayer isEqualToString: @"O"])
//    {
//        self.whichPlayerLabel.text = @"X";
//        self.whichPlayerLabel.textColor = [UIColor blueColor];
//        [self disableButtonLabel:self.oButtonLabel];
//        [self enableButtonLabel:self.xButtonLabel];
//        [self computerMakeMove];
//    }
//
//    [self playerMakeMove];
//    
//}


/*BUGS
AlertView is deprecated change it to something else
WHEN PLAYERS HIT A DRAW - nothing happens
TIMER doesn't reset when game is reset
WHEN USER IS DRAGGING THE LETTER, TIMER DOESN'T MOVE
*/

/*CODE CLEAN UP
Clean up whowins function
Add a #define value for X or Y, is there a Magic String?

Make this into its own method
 tappedLabel.text = self.whichPlayerLabel.text;
 tappedLabel.textColor = self.whichPlayerLabel.textColor;

*/

/*INTERFACE
Nicer X O buttons
MAKE ANIMATION WITH TIMER and the 0.1f interval

 */


/* Figuring out the AI stuff

USE NSARRAY OR NSDICTIONARY FOR STATES1-9 TO HOLD VARIABLE OBJECTS?
USE THIS TO CHECK BOARD OR DETERMINE WINNING NUMBER
 
check if player has winning combination of 123,456,789,147,258,369,159,357 then return TRUE
if YES, return TRUE, else FALSE
Check gameState:
*/
//
//- (BOOL) hasWinningCombination : (NSString *) player
//{
//
//    NSMutableArray *ticTacToeBoardValue = [[NSMutableArray alloc] init];
//    [ticTacToeBoardValue insertObject:self.labelOne atIndex:0];
//    [ticTacToeBoardValue insertObject:self.labelTwo atIndex:1];
//    [ticTacToeBoardValue insertObject:self.labelThree atIndex:2];
//    [ticTacToeBoardValue insertObject:<#(id)#> atIndex:<#(NSUInteger)#>]
//
//}






@end
