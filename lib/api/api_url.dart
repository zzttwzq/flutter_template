class ApiUrl {
  //-----服务器-------
  //获取服务端时间
  static const String getST = '/support/ts';
  //-----登录-登出-------
  //1.登录-邮箱登录
  static const String login = '/user/login';

  //2.退出登录
  static const String logout = '/user/logout';
  //3.第三方登录-微信登录
  //生成微信二维码接口
  static const String wechatCode = '/user/wx/getWxLoginParam';
  //微信登录回调接口
  static const String wechatLogin = '/user/wx/callback';

  //注册
  static const String register = '/user/register';
  //检测用户是否已注册
  static const String checkUserExist = '/user/check';
  //发送邀请码
  static const String sendVerification = '/verification/send';
  //校验邀请码
  static const String checkVerification = '/verification/check';
  //找回密码
  static const String retrievePassword = '/user/password/forget';
  //修改密码
  static const String changePassword = '/user/password/update';

  /// -----用户相关------
  //1.获取用户信息
  static const String userInfo = '/user/info';
  //1.更新用户信息
  static const String updateUserInfo = '/user/update';
  //1.更新用户头像
  static const String updateUserAvatar = '/user/avatar/update';
  //获取用户的sharecode
  static const String userShareCode = '/user/shareCode';

  /// -----团队相关-------
  //1.获取团队列表
  static const String teamList = '/team/teamList';
  //2.创建团队
  static const String createTeam = '/team/invitationTeam';
  //3.获取团队成员列表
  static const String teamMemberList = '/team/teamMemberList';
  //4.更新team的信息
  static const String updateTeam = '/team/updataTeam';
  //5.获取team详情
  static const String teamDetail = '/team/teamDetail';
  //6.删除团队
  static const String deleteTeam = '/team/deleteTeam';
  //6.离开团队
  static const String exitTeam = '/team/deleteUserFromTeam';
  //7.移交Team管理权
  static const String transferTeamOwner = '/team/transferTeam';
  //8.邮件发送团队邀请码
  static const String inviteTeamMember = '/invite/team/create';
  //邀请成员加入团队
  static const String joinTeamToLink = '/invite/team';
  //检查团队邀请码
  static const String checkTeamInviteCode = '/team/checkInvitationCode';
  static const String upgradeTeamByInviteCode = '/team/upgradeByInvitationCode';

  //生成团队邀请码
  static const String inviteCodeTeam = '/invite/open/generateTeamCode';
  //邀请码加入团队
  static const String inviteCodeJoinTeam = '/invite/team/largeScreenCode';

  // 如果用户没有team 创建新的team
  static const String userCreateTeam = '/user/createTeam';

  /// -----项目组相关-------
  //1.获取项目组列表
  static const String projectList = '/group/list';
  //1.获取项目组列表
  static const String projectInfo = '/group/info';
  //2.获取项目组成员列表
  static const String projectMembersList = '/group/members';
  //添加项目组成员
  static const String addProjectMember = '/invite/group/inviteIntoGroup';
  //移除项目组成员
  static const String removeProjectMember = '/group/member/remove';
  //2.获取项目组成员列表
  static const String createProject = '/group/save';
  //移交项目组管理权
  static const String transferProjectOwner = '/group/owner';
  // 退出前检查用户白板
  static const String checkUserProjectBoard = '/group/user/check';
  // 退出项目组
  static const String exitProject = '/group/exit';
  // 删除项目组
  static const String deleteProject = '/group/remove';

  /// -----白板相关-------
  //1.获取白板列表
  static const String boardList = '/meeting/list';
  //2.白板收藏
  static const String boardCollection = '/meeting/collection';
  //3.创建白板
  static const String createBoard = '/meeting/save';
  //复制白板
  static const String copyBoard = '/template/copy/meeting';
  //移动白板
  static const String moveBoard = '/group/transfer';
  //3.删除白板
  static const String deleteBoard = '/meeting/remove';
  //获取白板基本信息
  static const String boardBaseInfo = '/meeting/base';
  //获取白板详情
  static const String boardInfo = '/meeting/info';
  //邀请白板成员-分享白板
  static const String inviteBoardMember = '/invite/open/create';
  //设置白板公开权限
  static const String setBoardPermissions = '/meeting/permissions/setting';
  //判断是否可以加入白板
  static const String canJoinBoard = '/meeting/public/join/check';
  //加入白板
  static const String joinBoard = '/meeting/join';
  static const String getPublicBoardInfo = '/meeting/code';

  //生成白板邀请码
  static const String inviteCodeBoard = '/invite/open/generateInvitationCode';
  //邀请码加入白板
  static const String inviteCodeJoinBoard = '/invite/meeting/largeScreenCode';
  //生成白板二维码
  static const String getBoardQRCode = '/invite/open/meetingTwoDimensionalCode';
  //存储白板页面标识
  static const String updatePageSign = '/meeting/updatePageSign';

  /// -----模版相关-------
  //1.获取模版列表
  static const String templateList = '/template/official/category/list';

  /// -----回收站相关-------
  //1.获取回收站列表
  static const String recyclerList = '/recycle/list';
  //1.还原白板
  static const String recoverRecyclerBoard = '/recycle/recover';
  //1.彻底删除白板
  static const String deleteRecyclerBoard = '/recycle/remove';

  /// -----上传相关------
  /// 获取oss配置
  static const String ossConfig = 'oss/policy';

  /// 上传oss
  // static const String logout = 'logout';
}
