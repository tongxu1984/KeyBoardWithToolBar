//
//  KeyBoardTopBar.h
//  CSGMobileApp
//
//  Created by apple on 12-6-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KeyBoardWithToolBarDelegate <NSObject>

@optional
- (void)calcContentOffset:(NSInteger)offset;
- (void)didClickDoneButton;

- (void)onEditingComponent:(UIView *)component withOffset:(float)offset;

@end

@interface KeyBoardWithToolBar : NSObject <UITextFieldDelegate, UITextViewDelegate> {        
    NSArray             *_controlList;                  //输入框数组
    UIBarButtonItem     *_prevButtonItem;               //上一项按钮
    UIBarButtonItem     *_nextButtonItem;               //下一项按钮
    UIBarButtonItem     *_doneButtonItem;               //完成按钮
    UIBarButtonItem     *_spaceButtonItem;              //空白按钮
    id                  _currentControl;                //当前输入框
}

@property (nonatomic, assign) id<KeyBoardWithToolBarDelegate> delegate;
@property (nonatomic, retain) UIView *inputAccessoryView;

- (id)init; 
- (void)setControlList:(NSArray *)array;

@end
