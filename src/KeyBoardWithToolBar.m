//
//  KeyBoardTopBar.m
//  CSGMobileApp
//
//  Created by apple on 12-6-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KeyBoardWithToolBar.h"

@interface KeyBoardWithToolBar (Private)

- (void)showPrevious;
- (void)showNext;
- (void)hiddenKeyBoard;
- (void)setViewStatus;

@end

@implementation KeyBoardWithToolBar

@synthesize delegate = _delegate;
@synthesize inputAccessoryView = _inputAccessoryView;

- (void)dealloc {
    [_controlList release];
    [_prevButtonItem release];
    [_nextButtonItem release];
    [_doneButtonItem release];
    [_spaceButtonItem release];
    [_inputAccessoryView release];
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        
        _prevButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上一项"
                                                           style:UIBarButtonItemStyleBordered
                                                          target:self
                                                          action:@selector(showPrevious)];
        _nextButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一项"
                                                           style:UIBarButtonItemStyleBordered
                                                          target:self
                                                          action:@selector(showNext)];
        _doneButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                           style:UIBarButtonItemStyleBordered
                                                          target:self
                                                          action:@selector(hiddenKeyBoard)];
        //doneButtonItem.tintColor = [UIColor blueColor];
        
        _spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                         target:nil
                                                                         action:nil];

        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
        toolbar.barStyle = UIBarStyleBlackTranslucent;
        toolbar.items = [NSArray arrayWithObjects:_prevButtonItem, _nextButtonItem, _spaceButtonItem,_doneButtonItem, nil];
        self.inputAccessoryView = toolbar;
        [toolbar release];
        _controlList = nil;
        _currentControl = nil;
    }
    
    return self;
}

//显示上一项
- (void)showPrevious {
    if (_controlList == nil) 
    {
        return;
    }
    NSInteger num = -1;
    for (NSInteger i=0; i<[_controlList count]; i++) 
    {
        if ([_controlList objectAtIndex:i] == _currentControl) 
        {
            num = i;
            break;
        }
    }
    if (num>0)
    {
        [[_controlList objectAtIndex:num] resignFirstResponder];
        [[_controlList objectAtIndex:num-1] becomeFirstResponder];
        [self setViewStatus:[_controlList objectAtIndex:num-1]];
    }
}
//显示下一项
- (void)showNext {
    if (_controlList==nil) 
    {
        return;
    }
    NSInteger num = -1;
    for (NSInteger i=0; i<[_controlList count]; i++) 
    {
        if ([_controlList objectAtIndex:i] == _currentControl) 
        {
            num = i;
            break;
        }
    }
    if (num < [_controlList count]-1)
    {
        [[_controlList objectAtIndex:num] resignFirstResponder];
        [[_controlList objectAtIndex:num+1] becomeFirstResponder];
        [self setViewStatus:[_controlList objectAtIndex:num+1]];
    }
}
//显示工具条
- (void)setViewStatus:(id)textField {
    _currentControl = textField;

    if (_controlList == nil) 
    {
        _prevButtonItem.enabled = NO;
        _nextButtonItem.enabled = NO;
    }
    else 
    {
        NSInteger num = -1;
        for (NSInteger i=0; i<[_controlList count]; i++) 
        {
            if ([_controlList objectAtIndex:i] == _currentControl) 
            {
                num = i;
                break;
            }
        }
        if (num > 0) 
        {
            _prevButtonItem.enabled = YES;
        }
        else 
        {
            _prevButtonItem.enabled = NO;
        }
        if (num < [_controlList count]-1) 
        {
            _nextButtonItem.enabled = YES;
        }
        else 
        {
            _nextButtonItem.enabled = NO;
        }
    }
}

//设置输入框数组
- (void)setControlList:(NSArray *)array {
    if (_controlList != nil) 
    {
        [_controlList release];
        _controlList = nil;
    }
    _controlList = [array retain];
    for (id ctrl in _controlList) 
    {
        if ([ctrl isKindOfClass:[UITextField class]]) 
        {
            ((UITextField *)ctrl).delegate = self;
            ((UITextField *)ctrl).inputAccessoryView = _inputAccessoryView;
        }
        else if ([ctrl isKindOfClass:[UITextView class]])
        {
            ((UITextView *)ctrl).delegate = self;
            ((UITextField *)ctrl).inputAccessoryView = _inputAccessoryView;
        }
    }
}

//隐藏键盘和工具条
- (void)hiddenKeyBoard {
    if (_currentControl != nil)
    {
        [_currentControl resignFirstResponder];
        _currentControl = nil;
    }

    if (_delegate != nil && [_delegate respondsToSelector:@selector(didClickDoneButton)]) 
    {
        [_delegate didClickDoneButton];
    }
    
}

#pragma mark - UITextFieldDelegate 

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self setViewStatus:textField];
    NSInteger offset = 0;
    CGRect rect = textField.frame;
    if (rect.origin.y > 40) 
    {
        offset = rect.origin.y - 40;
    }
    if (_delegate != nil && [_delegate respondsToSelector:@selector(calcContentOffset:)]) 
    {
        [_delegate calcContentOffset:offset];
    }
    if (_delegate != nil && [_delegate respondsToSelector:@selector(onEditingComponent:withOffset:)]) 
    {
        [_delegate onEditingComponent:textField withOffset:offset];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
/*
    [textField resignFirstResponder];
    
    if (_delegate != nil && [_delegate respondsToSelector:@selector(didClickDoneButton)]) 
    {
        [_delegate didClickDoneButton];
    }
*/    
    return YES;
}

#pragma mark - UITextViewDelegate 

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self setViewStatus:textView];
    NSInteger offset = 0;
    CGRect rect = textView.frame;
    if (rect.origin.y > 50) 
    {
        offset = rect.origin.y - 50;
    }
    if (_delegate != nil && [_delegate respondsToSelector:@selector(calcContentOffset:)]) 
    {
        [_delegate calcContentOffset:offset];
    }    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
/*
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
*/ 
    return YES;
}

@end
