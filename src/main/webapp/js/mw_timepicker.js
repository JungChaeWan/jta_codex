(function($) {
    function getTwoDigit(n) {
        if (n < 10) {
            return '0' + n;
        }
        return '' + n;
    }
    var TimePicker = function(target) {
        if (!(target instanceof jQuery)) {
            target = $(target);
        }

        var me = this,
            aniProp = {
                duration: 400,
                easing  : 'easeInSine'
            },
            swiper = {},
            $win = $(window),
            input;

        var template = '<div class="layCont">';

        template += '<div class="extract">';

        template += '<div class="slide-effect hour--minute">';
        template += '<div class="drawer"></div>';
        template += '</div>';

        template += '</div>';
        template += '</div>';

        var hourArray = [
                '08:00',
                '09:00',
                '10:00',
                '11:00',
                '12:00',
                '13:00',
                '14:00',
                '15:00',
                '16:00',
                '17:00',
                '18:00',
                '19:00',
                '20:00'
            ],
            minuteArray = [
                '00',
                '30'
            ],
            PI = Math.PI / 180,
            RADIUS = 150,
            RATIO = 0.8, //0.7,
            HEIGHT = 25, //28.6,
            DUMMY_H = $('<div class="dummy_h"></div>'),
            DUMMY_M = $('<div class="dummy_m"></div>'),
            currentTop = 0,
            dragDistances = [],
            startTop,
            startY,
            startT,
            endT,
            diffY,
            currentTarget,
            dragDirection,
            dragTimer,
            hourTop,
            minuteTop,
            hourSlide,
            minuteSlide,
            currentType;

        me.getGUI = function(param) {
            var pop = $(template);
            me.popup = pop;

            if (typeof input === 'undefined') {
                input = $('<input type="tel" />');
            }

            hourSlide = pop.find('.slide-effect.hour--minute');
            minuteSlide = pop.find('.slide-effect.minuteSlider');

            initSwipers(param);

            setTimeout(function() {
                setInitialTime(param);
            }, 10);

            me.swiper = swiper;
            me.getTime = function() {
                var b = hourSlide.find('.time-slide.on .time-cont').text();
                return b;
            };
            me.setTime = function(str) {
                setTimeout(function() {
                    setInitialTime({ time: str });
                }, 10);
            };

            return pop.find('.extract');
        };

        function init() {
            $.each(target, function(idx, itm) {
                if (idx > 0) {
                    return false;
                }

                var wrap = $(itm),
                    btn;
                if (wrap.data('initialized') === 'Y') {
                    return;
                }
                wrap.data('initialized', 'Y');

                input = wrap.find('>input');
                btn = wrap.find('.ui-datepicker-trigger');

                if (input.length * btn.length === 0) {
                    console.warn('Error: TimePicker, 오류가 발생 하였습니다.');
                    return false;
                }
                me.wrapper = wrap;

                btn.bind('click.timepicker', me.open);
                input.bind('click.timepicker', me.open);
            });
        }

        function rotateSlide(type) {
            if (typeof type === 'undefined') {
                return;
            }

            var s, c, a, t;

            if (type === 'h') {
                s = hourSlide;
                a = hourArray;
                t = hourTop;
            } else {
                s = minuteSlide;
                a = minuteArray;
                t = minuteTop;
            }
            c = a.length;

            var ang, ang2, rad, sin, div, n, dsp;
            s.find('.time-slide').each(function(idx, itm) {
                ang = 20 * idx + t * RATIO;
                ang2 = (ang % 360 + 360) % 360;
                rad = ang * PI;
                sin = Math.sin(rad) * RADIUS;
                div = $(itm);
                if (ang2 <= 10 || ang2 >= 350) {
                    div.addClass('on');
                    n = (Math.round(-ang / 20) % c + c + idx) % c;
                    fillSlideText(div, n, type);
                } else {
                    div.removeClass('on');
                }
                if (ang2 <= 80 || ang2 >= 280) {
                    dsp = 'block';
                } else {
                    dsp = 'none';
                }
                div.css({
                    display  : dsp,
                    top      : sin,
                    transform: 'rotateX(' + ang + 'deg)'
                });
            });
        }

        function fillSlideText(div, n, type) {
            var sub = div.find('.time-cont'),
                idx = div.index(),
                divs = div.parent().find('.time-slide'),
                len = divs.length,
                x,
                y,
                a,
                c;

            if (type === 'h') {
                a = hourArray;
            } else {
                a = minuteArray;
            }
            c = a.length;

            sub.text(a[n]);

            for (var i = 1; i <= 3; i++) {
                x = (idx + i + len) % len;
                y = (n + i + c) % c;
                divs.eq(x).find('.time-cont').text(a[y]);

                x = (idx - i + len) % len;
                y = (n - i + c) % c;
                divs.eq(x).find('.time-cont').text(a[y]);
            }
        }

        var oldY, moved;
        function slideDragStart($e) {
            var e = $e.originalEvent;
            e.preventDefault();

            moved = false;

            var s = $(e.currentTarget).closest('.slide-effect');
            if (s.hasClass('hour--minute')) {
                DUMMY_H.stop(true);
                currentType = 'h';
                currentTop = hourTop;
                startTop = hourTop;
            } else {
                DUMMY_M.stop(true);
                currentType = 'm';
                currentTop = minuteTop;
                startTop = minuteTop;
            }
            startY = e.touches[0].screenY;
            startT = e.timeStamp;
            oldY = startY;

            var tg = $(e.target);
            if (tg.hasClass('time-cont')) {
                currentTarget = tg;
            } else if (tg.hasClass('time-slide')) {
                currentTarget = tg.find('.time-cont');
            }

            dragDistances.length = 0;
            dragDirection = 0;

            $win.on('touchmove.timepicker', slideDragMove);
            $win.on('touchend.timepicker', slideDragEnd);
        }

        function slideDragMove($e) {
            var e = $e.originalEvent,
                y = e.touches[0].screenY;
            diffY = y - startY;

            if (!moved && Math.abs(diffY) > 4) {
                moved = true;
            }

            if (!moved) {
                return;
            }

            currentTop = startTop + diffY;
            if (currentType === 'h') {
                hourTop = currentTop;
            } else {
                minuteTop = currentTop;
            }
            rotateSlide(currentType);
            clearTimeout(dragTimer);

            var dir = 0,
                dif = y - oldY;
            oldY = y;
            if (dif < 0) {
                dir = -1;
            } else if (dif > 0) {
                dir = 1;
            }
            if (dragDirection != dir) {
                dragDistances.length = 0;
            }
            dragDirection = dir;
            dragDistances.unshift({
                y: diffY,
                t: new Date().getTime()
            });
            if (dragDistances.length > 5) {
                dragDistances.length = 5;
            }
            dragTimer = setTimeout(slideDragReset, 200);
        }

        function slideDragEnd($e) {
            var e = $e.originalEvent;
            endT = e.timeStamp;
            $win.off('touchmove.timepicker', slideDragMove);
            $win.off('touchend.timepicker', slideDragEnd);

            if (currentType === 'h') {
                hourTop = currentTop;
            } else {
                minuteTop = currentTop;
            }
            clearTimeout(dragTimer);

            var len = dragDistances.length,
                mul = 0,
                ave = 0,
                abs = 0,
                dur,
                y,
                d1,
                d2,
                dy,
                dt;

            if (len > 1) {
                d2 = dragDistances[0];
                d1 = dragDistances[len - 1];
                dy = d2.y - d1.y;
                dt = d2.t - d1.t;
                ave = dy / dt * 100;
                abs = Math.abs(ave);
                if (abs < 5) {
                    mul = 1;
                } else if (abs < 20) {
                    mul = 2;
                } else if (abs < 30) {
                    mul = 3;
                } else if (abs < 50) {
                    mul = 4;
                } else {
                    mul = 5;
                }
                dur = mul * 100;

                y = Math.round((currentTop + mul * ave) / HEIGHT) * HEIGHT;
            } else {
                y = Math.round(currentTop / HEIGHT) * HEIGHT;
                dur = 100;
            }

            if (len === 0) {
                currentTarget.trigger('click.timepicker');
            } else {
                slideAnimate(y, dur, currentType);
            }
        }

        function slideAnimate(y, dur, type) {
            var dummy, t;
            if (type === 'h') {
                dummy = DUMMY_H;
                t = hourTop;
            } else {
                dummy = DUMMY_M;
                t = minuteTop;
            }

            if (dur > 0) {
                dummy.stop(true);
                dummy.css('left', t);

                dummy.animate(
                    {
                        left: y
                    },
                    {
                        duration: dur,
                        easing  : 'easeOutCirc',
                        progress: slideProgress
                    }
                );
            }
        }

        function slideDragReset() {
            dragDirection = 0;
            dragDistances.length = 0;
        }

        function slideProgress(t, p) {
            var type = t.elem.className === 'dummy_h' ? 'h' : 'm';
            if (type === 'h') {
                hourTop = parseInt(DUMMY_H.css('left'), 10);
            } else {
                minuteTop = parseInt(DUMMY_M.css('left'), 10);
            }
            rotateSlide(type);
        }

        function slideClick($e) {
            var itm = $($e.currentTarget),
                itx = itm.text(),
                crs = itm.closest('.slide-effect'),
                ctx = crs.find('.time-slide.on .time-cont').text(),
                idx,
                cdx,
                dif,
                len,
                dur,
                y,
                type,
                a,
                t;

            type = crs.hasClass('hour--minute') ? 'h' : 'm';
            if (type === 'h') {
                a = hourArray;
                t = hourTop;
            } else {
                a = minuteArray;
                t = minuteTop;
            }
            idx = a.indexOf(itx);
            cdx = a.indexOf(ctx);
            dif = cdx - idx;
            len = a.length;

            if (idx === cdx) {
                return false;
            }

            if (dif > 5) {
                dif = dif - len;
            } else if (dif < -5) {
                dif = dif + len;
            }
            y = t + dif * HEIGHT;
            y = Math.round(y / HEIGHT) * HEIGHT;
            dur = 50 + Math.abs(dif) * 80;
            slideAnimate(y, dur, type);
        }

        function initSwipers(param) {
            var min = input.data('minute');
            if (typeof param !== 'undefined') {
                min = param.minute;
            }
            if (min === '1' || min === 1) {
                minuteArray.length = 0;
                for (var i = 0; i < 60; i++) {
                    minuteArray.push(getTwoDigit(i));
                }
            }

            var pop = me.popup,
                curDate = ('' + input.val()).toUpperCase(),
                param; //, arr, idx, h, m;

            pop
                .find('.slide-effect')
                .off()
                .on('touchstart.timepicker', slideDragStart);

            var str = '';
            for (var i = 0; i < 18; i++) {
                str += '<div class="time-slide"><div class="time-cont"></div></div>';
            }
            pop.find('.slide-effect .drawer').append(str);
            pop.find('.slide-effect .time-cont').on('click.timepicker', slideClick);

            param = {
                direction          : 'vertical',
                slideToClickedSlide: true
            };
            try {
                if (curDate.indexOf('PM') >= 0) {
                    param.initialSlide = 1;
                }
            } catch (e) {
                return false;
            }

        }

        function setInitialTime(param) {
            var pop = me.popup,
                curDate = ('' + input.val()).toUpperCase(),
                arr,
                idx

            if (typeof param !== 'undefined' && typeof param.time === 'string') {
                curDate = param.time.toUpperCase();
            }

            // init hour slide
            hourTop = 0;
            if (typeof hourSlide === 'undefined') {
                hourSlide = pop.find('.slide-effect.hour--minute');
            }
            try {
                arr = curDate.length > 2 ? `${curDate.substring(0,2)}:${curDate.substring(2)}` : curDate + ':00';
                idx = hourArray.indexOf(arr);
                if (idx >= 0) {
                    hourTop = -idx * HEIGHT;
                }
            } catch (e) {
                return false;
            }
            rotateSlide('h');
        }

        init();

        return me;
    };

    $(function() {
        $(document)
            .find('.time-select')
            .each(function() {
                var picker = new TimePicker();
                var $this = $(this);
                $this.append(picker.getGUI({ time: String($this.data('time')) }));
                $this.data("timepicker", {
                    setTime : (function(pk) {
                        return function(time) {
                            picker.setTime(time);
                        }
                    })(picker)
                });
            });
    });

})(window.jQuery);

var getSelectTime = function(target) {
    return $(target).find('.time-slide.on .time-cont').text();
}