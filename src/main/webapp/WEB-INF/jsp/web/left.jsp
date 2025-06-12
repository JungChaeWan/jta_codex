<%@page import="java.awt.print.Printable"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
var getContextPath = "${pageContext.request.contextPath}";

//right aside
function rightAside() {
    $('#floatingBT').click(function() {
        $('#rightAside').toggleClass('rightAside-open');
    });
};


$(window).on('load', function() {
	rightAside();
	// $.removeCookie("todayPrdt");
	var tp1 = $.cookie("tp1");
	var tp2 = $.cookie("tp2");
	var cookieList = $.fn.cookieList("todayPrdt");

	// $.removeCookie('todayPrdt', { path: '/' });
	var itemList = cookieList.items();
	itemList.reverse();

	if(itemList.length == 0){
		$("#todayList>ul").html("<p class=\"side-noContent\">오늘 본 상품이 없습니다.</p>");
		$(".itemNav").hide();
	}else{
		var addItem = "";
		for(var index in itemList){
			addItem += "<li><a href=\"" + getContextPath + itemList[index].url + "\" title=\"" + itemList[index].prdtNm + "\">";
			addItem += "<img class=\"photo\" src=\"" + itemList[index].savePath + "thumb/" + itemList[index].saveFileNm + "\" alt=\"" + itemList[index].prdtNm + "\"><span class=\"name\">" + itemList[index].prdtNm + "</span></a></li>";
		}
		$(".itemNav").show();
		$("#todayList>ul").html(addItem);

		$("#todayList").jCarouselLite({
			btnNext: "#itemNext a",
		    btnPrev: "#itemPrev a",
		    vertical: true,
		    circular: false
		});
	}

});
</script>


