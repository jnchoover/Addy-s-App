//
//  JRHHypnosisViewController.m
//  HypnoNerd
//
//  Created by Jennifer Hoover on 3/19/14.
//  Copyright (c) 2014 Jennifer Hoover. All rights reserved.
//

#import "JRHHypnosisViewController.h"
#import "JRHHypnosisView.h"

@interface JRHHypnosisViewController () <UITextFieldDelegate>
@end

@implementation JRHHypnosisViewController


//Creating a view hierarchy programmatically vs via Xib
-(void)loadView
{
    //Create a view
    JRHHypnosisView *backgroundView = [[JRHHypnosisView alloc] init];
    
    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    
    //Setting the border style on the text field will allow us to see it more easily
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Name";
    textField.returnKeyType = UIReturnKeyDone;
    
    textField.delegate = self;
    
    [backgroundView addSubview:textField];
    
    //Set it as "the" view of this view controller
    self.view = backgroundView;
}

-(void)drawHypnoticMessage:(NSString *)message
{
    for (int i=0; i<20; i++){
        
        UILabel *messageLabel = [[UILabel alloc]init];
        
        //Configure the labels colors and text
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.text = message;
        
        //This method resizes teh label, which will be relative to the text that it is displaying
        [messageLabel sizeToFit];
        
        //Get a random x value that fits within the hypnosis view's width
        int width = (int)(self.view.bounds.size.width - messageLabel.bounds.size.width);
        int x = arc4random() % width;
        
        //Get a random y value that fits within the hypnosis view's height
        int height = (int)(self.view.bounds.size.height - messageLabel.bounds.size.height);
        int y = arc4random() % height;
        
        //Update the label's frame
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        //Add the label to the hierarchy
        [self.view addSubview:messageLabel];
        
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-40);
        motionEffect.maximumRelativeValue = @(40);
        [messageLabel addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-40);
        motionEffect.maximumRelativeValue = @(40);
        [messageLabel addMotionEffect:motionEffect];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //NSLog(@"%@", textField.text);
    [self drawHypnoticMessage:textField.text];
    
    textField.text = @"";
    [textField resignFirstResponder];
    
    return YES;
}

//Overriding the designated initializer
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
        
        //Set the tab bar item's title
        self.tabBarItem.title = @"Hypnotize";
        
        //Create a UIImage from a file. This will use Hypno@2.png on retina display devices
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];
        
        //Put that image on the tab bar item
        self.tabBarItem.image = i;
    }
    
    return self;
}

@end
