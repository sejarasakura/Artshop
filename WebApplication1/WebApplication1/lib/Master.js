
// A $( document ).ready() block.
$(document).ready(function () {
    $(".art-list").click(function () {
        $('.art-list').each(function (i, obj) {
            $(this).removeClass("active")
        });
        $(this).addClass("active")
    })
});