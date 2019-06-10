class Common {

  //设置用户缓存
  _set_usercache(userinfo){
    const time = Date.parse(new Date()) / 1000
    let json = {
      nickName: userinfo.nickName,
      avatarUrl: userinfo.avatarUrl,
      create_time: time
    }
    wx.setStorageSync('usercache', json);
  };

  //判断缓存时效性，没过期返回true
  _CheckCacheTime(times){
    const time = Date.parse(new Date()) / 1000
    const end_time = times + 3600 * 2  
    return time < end_time ? true : false
  }

}

export { Common };