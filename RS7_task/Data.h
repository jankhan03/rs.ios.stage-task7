//
//  Data.h
//  RS7_task
//
//  Created by Yan Khanetski on 4.07.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Data : NSObject
@property (nonatomic, strong, readonly) NSString *login;
@property (nonatomic, strong, readonly) NSString *password;
@property (nonatomic, strong, readonly) NSString *code;
@end

NS_ASSUME_NONNULL_END
