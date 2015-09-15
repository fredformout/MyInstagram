//
//  Created by fredformout on 23.12.12.
//  
//

#import "MIFileUtility.h"

@interface MIFileUtility ()

@end

@implementation MIFileUtility

+ (NSString *)makeDocumentsPathForFilename:(NSString *)filename
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fullPath = [NSString stringWithFormat:@"%@/%@", documentDirectory, filename];
    
    return fullPath;
}

+ (void)deleteFile:(NSString *)fileName
{
    if (fileName
        && ![fileName isEqualToString:@""])
    {
        NSString *fullPath = [self makeDocumentsPathForFilename:fileName];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath])
        {
            NSError *err = nil;
            BOOL success = [[NSFileManager defaultManager] removeItemAtPath:fullPath
                                                                      error:&err];
            
            if (!success)
            {
                NSLog(@"Unable to delete file %@. Error: %@", fileName, err.userInfo);
            }
        }
    }
}

+ (void)deleteAllFiles
{
    NSError *error = nil;
    
    NSString *documentsDirectory = [self pathForDocumentsDirectory];
    
    for (NSString *file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory
                                                                               error:&error])
    {
        BOOL success = [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", documentsDirectory, file]
                                                                  error:&error];
        
        if (!success
            || error)
        {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
    }
}

+ (BOOL)fileExistsAtAbsolutePath:(NSString*)filename
{
    BOOL isDirectory;
    BOOL fileExistsAtPath = [[NSFileManager defaultManager] fileExistsAtPath:filename
                                                                 isDirectory:&isDirectory];
    
    return fileExistsAtPath && !isDirectory;
}

+ (BOOL)directoryExistsAtAbsolutePath:(NSString*)filename
{
    BOOL isDirectory;
    BOOL fileExistsAtPath = [[NSFileManager defaultManager] fileExistsAtPath:filename
                                                                 isDirectory:&isDirectory];
    
    return fileExistsAtPath && isDirectory;
}

+ (void)createDirectoryInDocumentsWithName:(NSString *)directoryName
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

    NSString *folderPath = [NSString stringWithFormat:@"%@/%@", documentDirectory, directoryName];

    if (![MIFileUtility directoryExistsAtAbsolutePath:folderPath])
    {
        NSError *error = nil;

        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:&error];

        if (error)
        {
            NSLog(@"%@", error);
        }
    }
}

+ (BOOL)moveFileToDocumentsDirectoryFromURL:(NSURL *)fromURL
{
    return [self moveFileFromURL:fromURL
                           toURL:[self urlFromDocumentsForFilename:[fromURL lastPathComponent]]];
}

+ (BOOL)moveFileFromURL:(NSURL *)fromURL
                  toURL:(NSURL *)toURL
{
    BOOL returnValue = [[NSFileManager defaultManager] moveItemAtURL:fromURL
                                                   toURL:toURL
                                                   error:nil];
    return returnValue;
}

+ (BOOL)copyFileToDocumentsDirectoryFromURL:(NSURL *)fromURL
                                   fileName:(NSString *)fileName
{
    return [self copyFileFromURL:fromURL
                           toURL:[self urlFromDocumentsForFilename:fileName]];
}

+ (BOOL)copyFileFromURL:(NSURL *)fromURL
                  toURL:(NSURL *)toURL
{
    BOOL returnValue = [[NSFileManager defaultManager] copyItemAtURL:fromURL
                                                               toURL:toURL
                                                               error:nil];

    return returnValue;
}

+ (NSString *)pathFromDocumentsForFilename:(NSString *)filename
{
    NSString *documentsDirectory = [self pathForDocumentsDirectory];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:filename];
    
    return filePath;
}

+ (NSString *)pathForDocumentsDirectory
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

    return documentDirectory;
}

+ (NSURL *)urlFromDocumentsForFilename:(NSString *)filename
{
    NSString *filePath = [self pathFromDocumentsForFilename:filename];
    
    return [NSURL fileURLWithPath:filePath];
}

+ (NSString *)pathFromInboxForFilename:(NSString *)filename
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *folderPath = [NSString stringWithFormat:@"%@/Inbox", documentDirectory];
    NSString *filePath = [folderPath stringByAppendingPathComponent:filename];

    return filePath;
}

+ (NSURL *)urlFromInboxForFilename:(NSString *)filename
{
    NSString *filePath = [self pathFromInboxForFilename:filename];

    return [NSURL fileURLWithPath:filePath];
}

+ (NSString *)pathFromBundleForFilename:(NSString *)filename
                          extension:(NSString *)extension
{
    return [[NSBundle mainBundle] pathForResource:filename
                                           ofType:extension];
}

+ (NSURL *)urlFromBundleForFilename:(NSString *)filename
                          extension:(NSString *)extension
{
    NSString *filePath = [self pathFromBundleForFilename:filename
                                               extension:extension];
    
    return [NSURL fileURLWithPath:filePath];
}

+ (NSString *)processedFilename:(NSString *)filename
{
    return [[filename stringByReplacingOccurrencesOfString:@":"
                                                withString:@""] stringByReplacingOccurrencesOfString:@"/"
            withString:@""];
}

@end