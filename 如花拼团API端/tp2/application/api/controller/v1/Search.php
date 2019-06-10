<?php
namespace app\api\controller\v1;

use app\api\validate\NameValidate;
use app\api\model\Goods as GoodsModel;
//搜索类
class Search extends Base
{
    public function getProductName($name)
    { 
        (new NameValidate)->goCheck();
        $data=GoodsModel::getProductByName($name);
        return $data;
    }
}
