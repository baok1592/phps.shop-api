如花拼团商城系统 v1.0&emsp;作者:光爵&emsp;QQ群:728615087
================================================== 

如花拼团是一款基于ThinkPHP5.1.24 + vue cli3 + Mysql开发的开源拼团商城系统，PHP版本要求提升到5.6。<br/>
目前1.0版功能有限，后期会不断完善打磨，推出更多功能。<br/>
系统结构为4端分离： api + 后台管理 + 小程序 + 微信网页版。<br/>
这是第一次用vue做项目，边学边做。代码很粗糙，后期会不断优化。<br/>
做这个开源项目，纯粹是为了学习交流，很多不足的地方欢迎大家指教。<br/>  


API端：https://github.com/baok1592/phps.shop-api <br/>
小程序端：https://github.com/baok1592/phps.shop-program <br/>
CMS端：https://github.com/baok1592/phps.shop-cms <br/>
微信网页端：https://github.com/baok1592/phps.shop-wxwap （完善中）


## API端的安装使用  
1、将源码放到服务器空间 <br/>
2、访问你的网址，正常会显示json数据 (msg: "访问页面不存在") <br/>
3、导入mysql文件，访问 http://域名/v1/banner/1  显示'首页banner位'即安装成功 <br/>
4、安装小程序端，将小程序配置文件api网址改为真实网址，小程序端即可访问成功 <br/>
5、配置支付信息、商品信息等需要安装cms端
 

## 版权信息
如花拼团商城系统同ThinkPHP一样，遵循Apache2开源协议发布，并提供免费使用 <br/>
系统使用到的框架有：Thinkphp、 vue、 element、 小程序、 less <br/>
如花拼团属个人开发，版权所有Copyright © 2018 by 如花拼团商城系统 (http://www.phps.shop) All rights reserved
