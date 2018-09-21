<?php

Route::get('think', function () {
    return 'hello,ThinkPHP5!';
});

Route::get(':version/banners', 'api/:version.Banner/getbanners');//获取所有广告位
Route::get(':version/banner_all_item', 'api/:version.Banner/banner_all_item');//获取所有广告
Route::get(':version/banner/:id', 'api/:version.Banner/getbanneritem'); //获取某广告位下的广告
Route::get(':version/recent', 'api/:version.Product/getRecent');    //所有商品 type="hot,new"最热 最新

Route::get(':version/newlist', 'api/:version.Article/getList');    //获取所有文章列表  type=cms为详细列表
Route::get(':version/newlist/:id', 'api/:version.Article/getNewsID');  //获取某文章详情


Route::get(':version/product/:id', 'api/:version.Product/getProduct');  //获取某商品详细信息
Route::get(':version/product/:id/item', 'api/:version.Product/getItemHalf');    //查询该商品待参团订单

Route::get(':version/category', 'api/:version.Category/getCategory');   //所有分类
Route::get(':version/category/:id', 'api/:version.Category/getCateLevel');  //某级分类
Route::get(':version/category/:id/products', 'api/:version.Product/getCatePros');//某分类下所有商品
Route::get(':version/category/cid/:id', 'api/:version.Category/getCateChildImg');//某分类下所有商品

Route::get(':version/shop/:id/product', 'api/:version.Product/getShopProduct'); //某商家所有商品
Route::get(':version/shop/:id/info', 'api/:version.Shop/getShopInfo');  //某商家信息
Route::get(':version/search/:name', 'api/:version.Search/getProductName');  //商品搜索



Route::post(':version/token', 'api/:version.WxToken/getToken');   //获取用户token
Route::post(':version/token/verify', 'api/:version.WxToken/verifyToken');   //获取用户token

//收藏
Route::group(':version/favorite', function() {
    Route::post('/get_one', 'api/:version.Favorites/scFavGood'); //查询商品是否被某用户收藏,参数type=shop为查询收藏商铺
    Route::post('/get_all', 'api/:version.Favorites/getFav');   //查询某用户收藏的所有商品与商铺
    Route::post('/add', 'api/:version.Favorites/addFavorite');  //添加收藏商品或店铺，fav_id,type,price,img_id}
    Route::post('/del', 'api/:version.Favorites/delFavorite');  //删除收藏，参数为id
});

//地址
Route::group(':version/address', function(){
    Route::post('', 'api/:version.Address/CreateAddress');//创建该用户地址,5个参数：name、city、detail等
    Route::post('/all', 'api/:version.Address/getUserAddress');//获取该用户所有地址
    Route::post('/get_default', 'api/:version.Address/getAddressDefault');//获取用户默认地址
    Route::post('/set_default', 'api/:version.Address/setUserAddressDefault');//将用户一地址设为默认地址
    Route::post('/one', 'api/:version.Address/getAddressByID');//获取用户指定的一条地址，参数为id
    Route::post('/del', 'api/:version.Address/DelAddress');//删除该用户地址，参数为id
    Route::post('/up', 'api/:version.Address/UpdateAddress');//更新用户地址,6个参数：id、name、city、detail等
});

//下单、订单
Route::group(':version/order', function(){
    Route::post('/create', 'api/:version.Order/CreateOrder'); //创建拼团,参数：goods_id、number、price、type[only或任意]
    Route::post('/push', 'api/:version.Order/PushOrder');     //参加拼团
    Route::post('/all', 'api/:version.Order/getUserOrderAll'); //查看该用户所有拼团信息
    Route::post('/get_order_one', 'api/:version.Order/getUserOrderOne'); //查看用户某一条拼团详情
    Route::post('/del_order', 'api/:version.Order/DeleteOrder'); //取消一条未支付的订单
    Route::post('/search', 'api/:version.Order/SearchOrder'); //订单搜索
});

Route::post(':version/pay/pre_order', 'api/:version.Pay/getPreOrder');
Route::post(':version/pay/notify', 'api/:version.Pay/receiveNotify');//小程序支付回调

//CMS-登陆/退出
Route::get(':version/admin/lout', 'api/:version.Common/lout');   //退出
Route::post(':version/admin/login', 'api/:version.Common/login');   //登陆
Route::post(':version/admin/login_demo', 'api/:version.Common/loginDemo');   //demo登陆



Route::group(':version/admin', function(){
//CMS-获取
    Route::post('/get_user_all', 'api/:version.User/GetUserAll');   //获取所有用户；
    Route::post('/get_user', 'api/:version.User/GetUserInfo');   //获取指定用户详细,参数id
    Route::post('/get_order_item_all', 'api/:version.Order/GetOrderItemAll');   //获取所有团单详细
    Route::post('/get_order_all', 'api/:version.Order/GetOrderAll');   //获取所有订单
    Route::post('/get_order_one', 'api/:version.Order/GetOrderOne');   //获取指定订单详细,参数id
    Route::post('/get_config', 'api/:version.system/GetConfig');   //获取商城配置信息
    Route::get('/get_category_all', 'api/:version.Category/getCate_sort');  //获取所有分类并排好序，包括隐藏，
    Route::get('/get_category', 'api/:version.Category/getCateTop');  //获取顶级分类，包括隐藏
    Route::get('/get_products', 'api/:version.Product/getProducts');   //获取所有上架商品，包含分页
    Route::get('/get_products_down', 'api/:version.Product/getProductsDown');   //获取所有上架商品，包含分页
    Route::get('/check_login', 'api/:version.Common/check_login');   //检查是否登陆
    Route::post('/get_admin', 'api/:version.Cms/GetAdminAll');   //获取所有用户；

//CMS-添加
    Route::post('/add_category', 'api/:version.Category/add');   //新增分类
    Route::post('/add_product', 'api/:version.Product/add');   //新增商品
    Route::post('/add_admin', 'api/:version.Cms/add_admin');   //新增管理员
    Route::post('/create_ad', 'api/:version.Banner/create_ad');   //新增广告
    Route::post('/add_article', 'api/:version.Article/add');   //新增文章

//CMS-删除+更新
    Route::put('/del_category', 'api/:version.Category/del');   //删除分类
    Route::put('/del_order', 'api/:version.Order/del');   //删除订单
    Route::put('/del_product', 'api/:version.Product/del');   //删除商品
    Route::put('/del_ad', 'api/:version.Banner/del_ad');   //删除广告
    Route::put('/del_article', 'api/:version.Article/del');   //删除文章
    Route::put('/del_admin', 'api/:version.Cms/del_admin');   //删除管理员

    Route::post('/edit_product', 'api/:version.Product/EditProduct');   //更新商品
    Route::put('/update_category', 'api/:version.Category/up_cms_category');   //更新分类
    Route::put('/update', 'api/:version.Common/up_one');   //更新某模型下的某布尔字段,如上下级架
    Route::post('/upload/img', 'api/:version.Common/uploadImg');   //上传图片
    Route::put('/edit_pwd', 'api/:version.Cms/edit_password');  //修改密码
    Route::post('/edit_config', 'api/:version.System/edit_config');  //修改配置信息

})->middleware('CheckCms'); //路由中间件（有弊端）



return [

];

