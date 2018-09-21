<?php
namespace app\api\controller\v1;
use app\api\model\Shop as ShopModel;
use app\api\validate\IDPostiveInt;
//商铺类
class Shop extends Base
{
    public function getShopInfo($id)
    {
        (new IDPostiveInt)->goCheck();
        $data = ShopModel::getShopByID($id);
        return $data;
    }
}
