/**
 *  自定义一个过滤器：如果货币的长度太长就截取
 *  使用方法：
 * 	     1.在要使用的模块中添加注入：angular.module('xxx', ['priceFilters']).
 *       2.在页面上：{{ expression | splitmoney }}
 */
angular.module('priceFilters', []).filter('splitmoney', function() {
  return function(input) {
  	var result = '';

  	input = input+'';

  	var dian = input.indexOf('.');

  	//判断小数点后面的长度
  	if(input.length - dian > 2){
  		result = input.substring(0, dian+3);
  	}else{
  		result = input;
  	}

    return result;
  };
});