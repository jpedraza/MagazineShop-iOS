//
//  MSKeychainObject.h
//  Eon
//
//  Created by Ondrej Rafaj on 06/03/2013.
//  Copyright (c) 2013 LBi. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kMSKeychainObject                                   [MSKeychainObject sharedKeychainObject]
#define kMSKeychainObjectIsLoginOk                          [[MSKeychainObject sharedKeychainObject] isLoginDataAvailable]


@interface MSKeychainObject : NSObject

@property (nonatomic, strong) NSString *authToken;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *userCredentials;

+ (MSKeychainObject *)sharedKeychainObject;

- (BOOL)isLoginDataAvailable;
- (void)logout;


@end
