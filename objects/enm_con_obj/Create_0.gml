/// @description Insert description here
// You can write your code in this editor

function genEnm(HP, SP, SPD, DEF, DMG, ASPD, RNG, CLASS, SPRS) constructor {
	hp = HP;
	maxHp = HP;
	sp = SP;
	spd = SPD;
	def = DEF;
	dmg = DMG;
	aspd = ASPD;
	rng = RNG;
	class = CLASS;
	sprs = SPRS;
}
global.genEnems = {
	zombie: new genEnm(
		10,
		0,
		1,
		1,
		1,
		1,
		1,
		0,
		{
			torso: zombie_torso,
			head: zombie_head,
			jaw: zombie_jaw,
			luarm: zombie_left_upper_arm_spr,
			llarm: zombie_left_lower_arm_spr,
			lhand: zombie_left_hand_spr,
			ruarm: zombie_right_upper_arm_spr,
			rlarm: zombie_right_lower_arm_spr,
			uleg: limb_spr,
			lleg: limb_spr
		}
	),
	plant: new genEnm(
		10,
		0,
		1,
		1,
		1,
		1,
		1,
		0,
		{
			torso: flower_rear,
			stilk: flower_stilk,
			head: flower_head
		}
	),
	debug: new genEnm(
		10,
		0,
		1,
		1,
		1,
		1,
		1,
		0,
		{
			torso: torso_spr,
			head: head_spr,
			limb: limb_spr
		}
	)
}