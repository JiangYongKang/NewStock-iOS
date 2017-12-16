//
//  ARCSingletonTemplate.h
//
//

//GCD Template
#ifndef XMPPEngine_ARCSingletonTemplate_h
#define XMPPEngine_ARCSingletonTemplate_h

#define SYNTHESIZE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SYNTHESIZE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#endif



//plain Template
//#define SYNTHESIZE_SINGLETON_FOR_HEADER(className) \
//\
//+ (className *)shared##className;
//
//
//#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
//\
//static classname *shared##classname = nil; \
//\
//+ (classname *)shared##classname \
//{ \
//    @synchronized(self) \
//    { \
//        if (shared##classname == nil) \
//        { \
//            shared##classname = [[self alloc] init]; \
//        } \
//    } \
//    \
//    return shared##classname; \
//} \
//\
//+ (id)allocWithZone:(NSZone *)zone \
//{ \
//    @synchronized(self) \
//    { \
//        if (shared##classname == nil) \
//        { \
//            shared##classname = [super allocWithZone:zone]; \
//            return shared##classname; \
//        } \
//    } \
//    \
//    return nil; \
//} \
//\
//- (id)copyWithZone:(NSZone *)zone \
//{ \
//    return self; \
//} \
//\
//- (id)retain \
//{ \
//    return self; \
//} \
//\
//- (NSUInteger)retainCount \
//{ \
//    return NSUIntegerMax; \
//} \
//\
//- (void)release \
//{ \
//} \
//\
//- (id)autorelease \
//{ \
//    return self; \
//}

