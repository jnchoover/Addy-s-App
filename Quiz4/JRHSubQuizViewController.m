//
//  JRHSubQuizViewController.m
//  Quiz4
//
//  Created by Jennifer Hoover on 3/20/14.
//  Copyright (c) 2014 Jennifer Hoover. All rights reserved.
//

#import "JRHSubQuizViewController.h"
@interface JRHSubQuizViewController ()

@property (nonatomic) int currentQuestionIndex;

@property (nonatomic, copy) NSArray *questions;
@property (nonatomic, copy) NSArray *answers;

@property (nonatomic, weak) IBOutlet UILabel *questionLabel;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel;

@end

@implementation JRHSubQuizViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil
                        bundle:(NSBundle *)nibBundleOrNil
{
    //Call the init menthod implemented by the superclass
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
        //Create two arrays filled with questions and answers and make the pointers point to them
        
        self.questions = @[@"1-1",
                           @"2-1",
                           @"3-1",
                           @"4-1",
                           @"5-1",
                           @"6-1",
                           @"7-1",
                           @"8-1",
                           @"9-1"];
        
        self.answers = @[@"0",
                         @"1",
                         @"2",
                         @"3",
                         @"4",
                         @"5",
                         @"6",
                         @"7",
                         @"8"];
        
        //Set the tab bar item's title
        self.tabBarItem.title = @"Subtraction";
        
        //Create a UIImage from a file. This will use Hypno@2.png on retina display devices
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];
        
        //Put that image on the tab bar item
        self.tabBarItem.image = i;
    }
    
    //return the addres of the new object
    return self;
}

-(IBAction)showQuestion:(id)sender
{
    //Step to the next question
    self.currentQuestionIndex++;
    
    //Am I past the last question:
    if(self.currentQuestionIndex ==[self.questions count]){
        
        //Go back to the first question
        self.currentQuestionIndex = 0;
    }
    
    //Get the string at that index in the quesitons array
    NSString *question = self.questions[self.currentQuestionIndex];
    
    //Display the string in the question label
    self.questionLabel.text = question;
    
    //Reset the answer label
    self.answerLabel.text = @"???";
}

-(IBAction) showAnswer:(id)sender
{
    //What is the answer to the current question?
    NSString *answer = self.answers[self.currentQuestionIndex];
    
    //Display it in the answer label
    self.answerLabel.text = answer;
}

@end
