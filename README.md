# CheckAuthorization
检测相册以及相机的权限，如果用户没有打开，则跳转到设置打开  
开发环境：Xcode 8.3.3 swift 3.0

1、在info.plist添加权限设置  
Privacy - Camera Usage Description  相机
Privacy - Photo Library Usage Description 相册

2、导入两个权限库  
import Photos      相册  
import AVFoundation  相机

3、调用对应的方法  
检查相册权限  
func checkPhoto()->Bool

检查相机权限
func checkCapture()->Bool
