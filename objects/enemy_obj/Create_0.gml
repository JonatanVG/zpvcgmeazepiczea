/// @description Insert description here
// You can write your code in this editor

me = variable_clone(global.genEnems.zombie); // Placeholder, overwritten at runtime by main_con_obj

skel = skeletonCreate();

torso  = boneCreate(me.sprs.torso, 0, 0, 0, 0, -2);
head   = boneCreate(me.sprs.head, -2, -10, 7, -2, 0);
jaw    = boneCreate(me.sprs.jaw,   0, 0, 0, 0, -1);
luarm  = boneCreate(me.sprs.luarm, 4, -4, 0, 0, 1);
llarm  = boneCreate(me.sprs.llarm, 0, 12, 0, 0, 2);
lhand  = boneCreate(me.sprs.lhand, 0, 10, 0, 0, 3);
ruarm  = boneCreate(me.sprs.ruarm,-4, -4, 0, 0, -3);
rlarm  = boneCreate(me.sprs.rlarm, 0, 12, 0, 0, -2);

skeletonAddBone(skel, torso);
skeletonAddBone(skel, head, torso);
skeletonAddBone(skel, jaw, head);
skeletonAddBone(skel, luarm, torso);
skeletonAddBone(skel, llarm, luarm);
skeletonAddBone(skel, lhand, llarm);
skeletonAddBone(skel, ruarm, torso);
skeletonAddBone(skel, rlarm, ruarm);

skeletonRegisterBone(skel, "torso", torso);
skeletonRegisterBone(skel, "head", head);
skeletonRegisterBone(skel, "jaw", jaw);
skeletonRegisterBone(skel, "luarm", luarm);
skeletonRegisterBone(skel, "llarm", llarm);
skeletonRegisterBone(skel, "lhand", lhand);
skeletonRegisterBone(skel, "ruarm", ruarm);
skeletonRegisterBone(skel, "rlarm", rlarm);

skeletonPlayAnim(skel, global.debug_anims.wave);