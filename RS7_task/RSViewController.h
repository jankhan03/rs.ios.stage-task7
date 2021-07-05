//
//  RSViewController.h
//  RS7_task
//
//  Created by Yan Khanetski on 4.07.21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSViewController : UIViewController
@property (nonatomic) UITapGestureRecognizer *tap;
- (void)keyboardWillHide:(id)sender;
- (void)didTapAnywhere:(UITapGestureRecognizer *)sender;
- (void)didTapOnButton:(UITapGestureRecognizer *)sender;
@end

NS_ASSUME_NONNULL_END
