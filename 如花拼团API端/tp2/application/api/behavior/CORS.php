<?php
/**
 * Created by 七月.
 * Author: 七月
 * Date: 2017/6/16
 * Time: 20:41
 */

namespace app\api\behavior;


class CORS
{
    public function appInit($params)
    {
        header('Access-Control-Allow-Origin: *');
        header("Access-Control-Allow-Headers: token,Origin, X-Requested-With,X_Requested_With, Content-Type, Accept");
        header('Access-Control-Allow-Methods: POST,GET,PUT');
        if(request()->isOptions()){
            exit();
        }
    }
}