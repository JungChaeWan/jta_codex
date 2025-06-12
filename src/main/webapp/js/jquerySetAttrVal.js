/**
 	1.jquery element value가 변경될때 attribute value도 변경함
	2.inputType text는 제외함
 	3.inputType hidden은 jquery가 element value, attribute value 모두 변경함
 */
$(document).ready(function(){
    $("select").change(function () {
        var selThis = $(this);
        var selIdx = $("option", this).index($("option:selected", this));
        $("> option", this).each(function () {
            if ($(this).index() == selIdx) {
                $("option:eq(" + $(this).index() + ")", selThis).attr("selected", true)
            } else {
                $("option:eq(" + $(this).index() + ")", selThis).attr("selected", false)
            }
        });
    });

    $("input:radio").change(function () {
        var selThis = $(this);
        $("input[name=" + $(this).attr("name") + "]").attr("checked", false);
        selThis.attr("checked", true);
        selThis.prop("checked", true);
    });

    $("input:checkbox").change(function () {
        if ($(this).prop("checked")) {
            $(this).attr("checked", true);
        } else {
            $(this).attr("checked", false);
        }
    });
});