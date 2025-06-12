(function ($) {
    $.fn.extend({
        cookieList: function (cookieName) {
        
            return {
                add: function (val) {
                    var array    = this.items();

                    //this.hasitem(val);
                    if(typeof(this.hasitem(val))== "undefined"){
                        array.push(val);
                        
                        var inStr = JSON.stringify(array);
                        $.cookie(cookieName, inStr, { expires:1, path: '/' });
                        
                        
                    }else{
                        
                    }
            
                },
                remove: function (val) {
                    var items = this.items();
                    
                    // var index = items.indexOf(val);
                    var index = -1;
                    for(var i=0;i<items.length;i++){
                    	if(items[i] == val){
                    		index = i;
                    		break;
                    	}
                    }
                    
                    if (index != -1) {
                        items.splice(index, 1);
                        $.cookie(cookieName, items.join(','), { expires: 1, path: '/' });
                    }
                },
                indexOf: function (val) {
                	var items = this.items();
                	
                	var index = -1;
                    for(var i=0;i<items.length;i++){
                    	if(items[i] == val){
                    		index = i;
                    		break;
                    	}
                    }
                    return index;
                },
                clear: function () {
                    $.cookie(cookieName, null, { expires: 1, path: '/' });
                },
                items: function () {
                    var cookie = $.cookie(cookieName);
                    return cookie ? JSON.parse(cookie):[];
                },
                hasitem: function (val){
                    for (var k in this.items()){
                        var entry1 = JSON.stringify(this.items()[k]);
                        var val1 = JSON.stringify(val);
                        if(val1 == entry1){
                            return k;
                        }
                    }
                },
                length: function () {
                    return this.items().length;
                },
            };
        }
    });
})(jQuery);