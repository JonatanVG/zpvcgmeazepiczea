/// @description Insert description here
// You can write your code in this editor

skeletonUpdate(skel, x, y);

//head.angle = sin(current_time / 500) * -45;

torso.ox++;

if (torso.ox >= 350) {
	torso.ox = -300;
}