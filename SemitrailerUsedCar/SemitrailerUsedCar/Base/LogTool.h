//
//  LogTool.h
//  DoctorPlatForm
//
//  Created by 宋志明 on 16/10/31.
//  Copyright © 2016年 songzm. All rights reserved.
//

#ifndef LogTool_h
#define LogTool_h


#ifdef DEBUG
#define FLOG(str, args...) NSLog(@"\t[%s][%d][%s]  %@", strrchr(__FILE__, '/'), __LINE__, sel_getName(_cmd), [NSString stringWithFormat:str , ##args])
#else
#define FLOG(str, args...) ((void)0)
#endif

#endif /* LogTool_h */

