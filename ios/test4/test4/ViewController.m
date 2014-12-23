//
//  ViewController.m
//  test4
//
//  Created by yanyiwu on 14/12/23.
//  Copyright (c) 2014年 yanyiwu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()



@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    CGRect textViewFrame = CGRectMake(0.0f, 0.0f, 300.0f, 100.0f);
    UITextView *textView = [[UITextView alloc] initWithFrame:textViewFrame];
    CGRect bounds = self.view.bounds;
    textView.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds) * 1 / 2);
    textView.returnKeyType = UIReturnKeyDone;
    textView.backgroundColor = [UIColor whiteColor];
    textView.delegate = self;
    [self.view addSubview:textView];
    self.view.backgroundColor = [UIColor grayColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"textViewShouldBeginEditing:");
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"textViewDidBeginEditing:");
    //textView.backgroundColor = [UIColor greenColor];
}


- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSLog(@"textViewShouldEndEditing:");
    //textView.backgroundColor = [UIColor whiteColor];
    textView.text = @"ok";
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"textViewDidEndEditing:");
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    
    if (textView.text.length + text.length > 140){
        if (location != NSNotFound){
            [textView resignFirstResponder];
        }
        return NO;
    }
    else if (location != NSNotFound){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    NSLog(@"textViewDidChange:");
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    NSLog(@"textViewDidChangeSelection:");
}

@end

