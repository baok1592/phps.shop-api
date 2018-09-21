<?php
namespace app\lib\exception;

use think\exception\Handle;
use think\Log;
use think\facade\Request;

class ExceptionHandler extends Handle
{

    private $code;
    private $msg;
    private $errorCode;

    // 需要返回客户端当前请求的URL路径

    public function render(\Exception $e)
    {
        if ($e instanceof BaseException)
        {
            //返回自定义的异常提示信息
            $this->code = $e->code;
            $this->msg = $e->msg;
            $this->errorCode = $e->errorCode;
        } else {
            if (config('app_debug')){
                return parent::render($e);//不属于自定义异常类错误，并且当前是调试模式。则返回TP5原异常错误信息
            } else {
                $this->code = 500;
                $this->msg = '服务器内部错误，不想告诉你';
                $this->errorCode = 999;
                //$this->recordErrorLog($e); //记录错误日志
            }
        }
        $result = [
            'msg' => $this->msg,
            'error_code' => $this->errorCode,
            'request_url' => Request::url()   //获取当前访问的URL
        ];
        return json($result, $this->code);
    }



}