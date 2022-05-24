#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FirebaseArray.h"
#import "FirebaseArrayDelegate.h"
#import "FirebaseCollectionViewDataSource.h"
#import "FirebaseDataSource.h"
#import "FirebaseTableViewDataSource.h"
#import "FirebaseUI.h"
#import "XCodeMacros.h"

FOUNDATION_EXPORT double FirebaseUIVersionNumber;
FOUNDATION_EXPORT const unsigned char FirebaseUIVersionString[];

