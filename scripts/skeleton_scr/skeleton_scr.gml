// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

global.realSpeed = 1;

function boneCreate(sprite, ox, oy, hinge_x, hinge_y, bone_depth) {
	return {
		sprite: sprite,		
		
		ox: ox,
		oy: oy,
		
		hinge_x: hinge_x,
		hinge_y: hinge_y,
		
		angle: 0,
		
		children: [],
		
		parent: undefined,
		
		bone_depth: bone_depth
	};
}

function skeletonCreate() {
	return {
		root: undefined,
		bones: [],
		// animation state
		anim_current: undefined,
		anim_frame: 0,
		anim_timer: timerCreate(0.1, true),
		turn_speed: 1,
		anim_current_spd: 1,
		anim_bones: {},
		anim_targets: {},
		anim_loop: false
	};
}

function skeletonAddBone(skeleton, bone, parent = undefined) {
	if (parent != undefined) {
		array_push(parent.children, bone);
		bone.parent = parent;
	} else {
		skeleton.root = bone;
	}
	array_push(skeleton.bones, bone);
}

function skeletonRegisterBone(skeleton, name, bone) {
	skeleton.anim_bones[$ name] = bone;
}

function boneUpdate(bone, parent_x, parent_y, parent_angle) {
	var world_x = parent_x + bone.ox;
	var world_y = parent_y + bone.oy;
	
	var total_angle = parent_angle + bone.angle;
	
	var dx = world_x - parent_x;
	var dy = world_y - parent_y;
	var dist = point_distance(0, 0, dx, dy);
	var base_angle = point_direction(0, 0, dx, dy);
	
	bone._world_x = parent_x + lengthdir_x(dist, base_angle + parent_angle);
	bone._world_y = parent_y + lengthdir_y(dist, base_angle + parent_angle);
	bone._world_angle = total_angle;
	
	var hinge_wx = bone._world_x + lengthdir_x(
		point_distance(0,0,bone.hinge_x,bone.hinge_y),
		point_direction(0,0,bone.hinge_x,bone.hinge_y) + total_angle
	);
	var hinge_wy = bone._world_y + lengthdir_y(
		point_distance(0,0,bone.hinge_x,bone.hinge_y),
		point_direction(0,0,bone.hinge_x,bone.hinge_y) + total_angle
	);
	
	for (var i = 0; i < array_length(bone.children); i++) {
		boneUpdate(bone.children[i], hinge_wx, hinge_wy, total_angle);
	}
}

function skeletonUpdate(skeleton, x, y) {
	var frames_completed = 0;
	if (skeleton.anim_current != undefined) {
		timerUpdate(skeleton.anim_timer);
		// On timer fire - update targets
		if (skeleton.anim_timer.fired) {
		    // Check if all bones reached their targets
		    var all_reached = true;
		    var snap_keys = variable_struct_get_names(skeleton.anim_targets);
		    for (var i = 0; i < array_length(snap_keys); i++) {
		        var bone_name = snap_keys[i];
		        if (variable_struct_exists(skeleton.anim_bones, bone_name)) {
		            if (abs(angle_difference(skeleton.anim_bones[$ bone_name].angle, skeleton.anim_targets[$ bone_name])) > 0.5) {
					    all_reached = false;
					    break;
					}
		        }
		    }
    
		    if (all_reached) {
				var next_frame = skeleton.anim_frame + 1;
				
				if (next_frame >= array_length(skeleton.anim_current)) {
					if (!skeleton.anim_loop) {
						skeletonStopAnim(skeleton);
						return;
					}
				}
				
		        // Load next frame
		        var frame = skeleton.anim_current[skeleton.anim_frame];
		        skeleton.anim_targets = {};
		        var keys = variable_struct_get_names(frame);
        
		        if (variable_struct_exists(frame, "spd")) {
		            skeleton.anim_current_spd = frame.spd;
		        } else {
		            skeleton.anim_current_spd = skeleton.turn_speed;
		        }
        
		        for (var i = 0; i < array_length(keys); i++) {
		            var bone_name = keys[i];
		            if (bone_name == "spd") continue;
		            skeleton.anim_targets[$ bone_name] = frame[$ bone_name];
		        }
		        skeleton.anim_frame = (skeleton.anim_frame + 1) % array_length(skeleton.anim_current);
		    }
		    // If not all reached, timer fired but we do nothing - hingeTurn keeps running
		}

		// Every step - smoothly turn toward targets
		var target_keys = variable_struct_get_names(skeleton.anim_targets);
		for (var i = 0; i < array_length(target_keys); i++) {
		    var bone_name = target_keys[i];
		    if (variable_struct_exists(skeleton.anim_bones, bone_name)) {
		        hingeTurn(skeleton.anim_bones[$ bone_name], skeleton.anim_targets[$ bone_name], skeleton.anim_current_spd);
				if (skeleton.anim_bones[$ bone_name].angle == skeleton.anim_targets[$ bone_name]) continue;
		    }
		}
	}
	
	if (skeleton.root != undefined) {
		boneUpdate(skeleton.root, x, y, 0);
	}
}

function boneDraw(bone) {
	if (bone.sprite != -1) {
		draw_sprite_ext(
			bone.sprite,
			0,
			bone._world_x,
			bone._world_y,
			1, 1,
			bone._world_angle,
			c_white,
			1
		);
	}
	
	//for (var i = 0; i < array_length(bone.children); i++) {
	//	boneDraw(bone.children[i]);
	//}
}

function skeletonDraw(skeleton) {
	array_sort(skeleton.bones, function(a, b) {
	    return a.bone_depth - b.bone_depth;
	});
	
	if (skeleton.root != undefined) {
		for (var i = 0; i < array_length(skeleton.bones); i++) {
			boneDraw(skeleton.bones[i]);
		}
	}
}

function hingeTurn(bone, targetAngle, spd) {
	var _diff = angle_difference(targetAngle, bone.angle);
	
	bone.angle += min(abs(_diff), spd * global.realSpeed) * sign(_diff);
}

function skeletonPlayAnim(skeleton, animation, loop = false) {
	skeleton.anim_current = animation;
	skeleton.anim_frame = 0;
	skeleton.anim_targets = {};
	skeleton.anim_loop = loop;
	timerReset(skeleton.anim_timer);
}

function skeletonStopAnim(skeleton) {
	timerLoopStop(skeleton.anim_timer);
	skeleton.anim_current = undefined;
	skeleton.anim_targets = {};
}