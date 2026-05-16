// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function timerCreate(duration, loop = false) {
	return {
		time: duration,
		duration: duration,
		finished: false,
		loop: loop,
		fired: false
	};
}

function timerUpdate(t) {
	t.fired = false;
	t.time -= global.realSpeed;
	if (t.time <= 0) {
		t.fired = true;
		if (t.loop) {
			t.time = t.duration;
		} else {
			t.finished = true;
		}
	}
}

function timerReset(t) {
	t.time = t.duration;
	t.finished = false;
	t.fired = false;
}

function timerLoopStop(t) {
	timerReset(t);
	t.loop = false;
}