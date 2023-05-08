
import '../utils/storage_util.dart';

class UserService {
  static getUserInfo() async {
    return StorageUtil.getData('USER_INFO');
  }

  static setUserInfo(Map userInfo) async {
    return StorageUtil.setData('USER_INFO', userInfo);
  }

  static getUserToken() async {
    var token = await StorageUtil.getData('USER_TOKEN');
    if (token == null) {
      var userInfo = await UserService.getUserInfo();
      if (userInfo != null) {
        return userInfo['token'];
      }
      return null;
    }
    return token;
  }

  static setUserToken(String token) async {
    return StorageUtil.setData('USER_TOKEN', token);
  }

  static clearUserInfo() async {
    return StorageUtil.clearAll();
  }

  static updateHuanxinUsername(nickName) {
    //此方法传入一个字符串String类型的参数，返回成功或失败的一个Boolean类型的返回值
    // EMClient.getInstance.updateCurrentNickname(nickname: nick_name);
  }

  static login() async {
    // 推送离线消息
    // var map = await request.instance
    //     .post('portal/user/online/status', {'online_status': 1});
    //
    // UserService.setUserInfo(map);
    //
    // var user = await getUserInfo();
    // updateHuanxinUsername(user['nick_name']);
    // EMClient.getInstance.chatManager.
  } 

  static logout() async {
    // 推送离线消息
    // var map = await request.instance
    //     .post('portal/user/online/status', {'online_status': 0});
    // print(map);
    //
    // // 登出环信
    // EMClient.getInstance.logout();
    // 清除用户登录信息
    UserService.clearUserInfo();
  }


  static daySign() async {
    
    // var map = await request.instance
    //     .get('portal/sign/records');
    //
    // LogUtil.d(map);
    
  }
}
