import { Token } from 'util/token.js';
var token = new Token();

App({
  onLaunch: function () {
    token.verify(); //向api验证token
  }

})
