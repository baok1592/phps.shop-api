<?php

namespace app\api\validate;


class ProductValidate extends BaseValidate
{
    protected $rule = [
        'goods_name' => 'require|isNotEmpty',
        'category_id' => 'require|isPositiveInteger',  //分类id
        'description' => 'max:200', //描述
      //  'content' => 'max:200', //详情
        'people' => 'require|isNotEmpty', //拼团人数
        'shipping_fee' => 'require',  //运费
        'max_buy' => 'isPositiveInteger',  //限买
        'sales' => 'max:200',  //销量

        'sku' => 'min:0', //规格
        'img_id' => 'isPositiveInteger',  //图片ID
        'market_price' => 'require|isNotEmpty', //市场价格
        'price' => 'require', //单价
        'only_price' => 'require', //单独购买
        'stock' => 'require',  //库存
        'content' => 'min:0',  //商品详情

    ];
}
