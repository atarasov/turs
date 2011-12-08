/*
* JLight
*Этот скрипт является модификацией jcycle.
*Слайдер совмешает в себе lightbox и jcycle
*Работает элементарно:
* Чтобы создать слайдшоу необходимо добавить несколько картинок
* в див с классом apartment-left,
* на каждую картинку необходимо поцепить класс slide-img.
* Дальше скрипт все выполнит сам
*/
function initPics(){
    $('.slide-img').live('click', function() {
        $parent = $(this).parent();
        $title =$parent.parent().find('.apartment-head h2').text(); //Если есть class notepad
        if($title == '')
            $title =$parent.parent().find('.apartment-head a').text(); //Если есть нет class notepad

         $('body').find('#popup h2').text('Фотографии: '+$title) ;

        //получаем все картинки для слайдшоу
        $images_arr = $parent.find('.slide-img');
        $images_arr = $parent.find('.slide-img-big');

        $html = '';
        $.each($images_arr, function() {
            $html += '<img src="' + ($(this).attr('value')) + '" width="200" height="200"/>';

        });
        $('.pics-wrapper .pics').html($html);

        /*подключаем JCYCLE*/
        $('.pics').cycle({
                    fx:      'fade',
                    speed:   1500,
                    next: '#next_slide',
                    prev: '#prev_slide',
                    pager: '#nav-popup',
                    pagerAnchorBuilder: function(idx, slide) {
                        return '<li><a href="#"><img src="' + slide.src + '" width="100" height="70" /></a></li>';
                    }
                });
    });


    /*по клику на картинку появится попап содержаший jcycle*/
    $('.slide-img').click(function() {
        $('#overlay').css('display', 'block');
        $('#popup').css('display', 'block');
        $('.pics-wrapper .pics').children('img').remove();
        $('#nav-popup ').find('li').remove();
    });
    $('#close-slide').live('click', function() {

        $('#overlay').css('display', 'none');
        $('#popup').css('display', 'none');
        $('.pics-wrapper .pics').children('img').remove();
        $('#nav-popup ').find('li').remove();
    });

}

$(document).ready(function() {


    $(document).ready(function() {
if ($('.pics-wrapper .pics') && ($('.pics-wrapper .pics').children().length == 1)) {
    $('.pics-wrapper .pics :first').show();
}

    //создаем подложку
    $('body').append('<div id="overlay"></div>');
    $('body').append('<div id="popup" style="width: 632px; height: 580px; top: 0pt;">     <img src="/images/close-slide-btn.png" id="close-slide" alt=""/>        <h2> </h2>      <div class="slider">        <div class="pics-wrapper">            <img src="/images/prev-slide-btn.png" id="prev_slide" alt=""/>            <div class="pics">            </div>            <img src="/images/next-slide-btn.png" id="next_slide" alt=""/></div>        <div id="nav-popup"></div>    </div></div>');
    initPics();

});

});

function initPopups()
{
	initPopup({
		openEvent:'click'
	});
	initPopup({
		popupHolderClass:'popup-hover'
	});
}
if (window.addEventListener)
	window.addEventListener("load", initPopups, false);
else if (window.attachEvent)
	window.attachEvent("onload", initPopups);

function initPopup(_popup) {
	if (!_popup.popupHolderTag) _popup.popupHolderTag = 'div';
	if (!_popup.popupTag) _popup.popupTag = 'div';
	if (!_popup.popupHolderClass) _popup.popupHolderClass = 'popup-holder';
	if (!_popup.popupClass) _popup.popupClass = 'popup';
	if (!_popup.linkOpenClass) _popup.linkOpenClass = 'open';
	if (!_popup.linkCloseClass) _popup.linkCloseClass = 'close';
	if (!_popup.openClass) _popup.openClass = 'active';
	if (!_popup.openEvent) _popup.openEvent = 'hover';

	var timer = [];
	var _popupHolderTag = document.getElementsByTagName(_popup.popupHolderTag);
	if (_popupHolderTag) {
		for (var i=0; i<_popupHolderTag.length; i++) {
			if (_popupHolderTag[i].className.indexOf(_popup.popupHolderClass) != -1) {
				var _popupLink = _popupHolderTag[i].getElementsByTagName('a');
				for (var j=0; j<_popupLink.length; j++) {
					_popupLink[j].parent = _popupHolderTag[i];
					if (_popupLink[j].className.indexOf(_popup.linkOpenClass) != -1) {
						if (_popup.openEvent == 'click') {
							_popupLink[j].onclick = function(){
								if (this.parent.className.indexOf(_popup.openClass) != -1) {
									this.parent.className = this.parent.className.replace(_popup.openClass,'');
								} else {
									this.parent.className += ' '+_popup.openClass;
								}
								return false;
							}
						} else {
							var _popupTag = _popupHolderTag[i].getElementsByTagName(_popup.popupTag);
							for (var k=0; k<_popupTag.length; k++) {
								if (_popupTag[k].className.indexOf(_popup.popupClass) != -1) {
									_popupTag[k].parent = _popupHolderTag[i];
									_popupTag[k].onmouseover = function(){
										if (timer[j]) clearTimeout(timer[j]);
										if (this.parent.className.indexOf(_popup.openClass) == -1) {
											this.parent.className += ' '+_popup.openClass;
										}
									}
									_popupTag[k].onmouseout = function(){
										var _this = this;
										timer[j] = setTimeout(function(){
											_this.parent.className = _this.parent.className.replace(_popup.openClass,'');
										},2);
									}
								}
							}
							_popupLink[j].onmouseover = function(){
								if (timer[j]) clearTimeout(timer[j]);
								if (this.parent.className.indexOf(_popup.openClass) == -1) {
									this.parent.className += ' '+_popup.openClass;
								}
							}
							_popupLink[j].onmouseout = function(){
								var _this = this;
								timer[j] = setTimeout(function(){
									_this.parent.className = _this.parent.className.replace(_popup.openClass,'');
								},2);
							}
						}
					} else if (_popupLink[j].className.indexOf(_popup.linkCloseClass) != -1) {
						_popupLink[j].onclick = function(){
							if (this.parent.className.indexOf(_popup.openClass) != -1) {
								this.parent.className = this.parent.className.replace(_popup.openClass,'');
							} else {
								this.parent.className += ' '+_popup.openClass;
							}
							return false;
						}
					}
				}
			}
		}
	}
}