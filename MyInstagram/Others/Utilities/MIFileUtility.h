//
//  Created by fredformout on 23.12.12.
//  
//

#import <Foundation/Foundation.h>

@interface MIFileUtility : NSObject

+ (void)deleteFile:(NSString *)fileName;

+ (BOOL)fileExistsAtAbsolutePath:(NSString*)filename;

+ (BOOL)directoryExistsAtAbsolutePath:(NSString*)filename;

+ (void)createDirectoryInDocumentsWithName:(NSString *)directoryName;

+ (BOOL)copyFileToDocumentsDirectoryFromURL:(NSURL *)fromURL
                                   fileName:(NSString *)fileName;

+ (BOOL)moveFileToDocumentsDirectoryFromURL:(NSURL *)fromURL;

+ (BOOL)moveFileFromURL:(NSURL *)fromURL
                  toURL:(NSURL *)toURL;

+ (BOOL)copyFileFromURL:(NSURL *)fromURL
                  toURL:(NSURL *)toURL;

+ (NSString *)pathForDocumentsDirectory;

+ (NSString *)pathFromDocumentsForFilename:(NSString *)filename;

+ (NSURL *)urlFromDocumentsForFilename:(NSString *)filename;

+ (NSString *)pathFromInboxForFilename:(NSString *)filename;

+ (NSURL *)urlFromInboxForFilename:(NSString *)filename;

+ (NSString *)pathFromBundleForFilename:(NSString *)filename
                              extension:(NSString *)extension;

+ (NSURL *)urlFromBundleForFilename:(NSString *)filename
                          extension:(NSString *)extension;

@end