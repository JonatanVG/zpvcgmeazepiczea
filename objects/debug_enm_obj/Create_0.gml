/// @description Insert description here
// You can write your code in this editor

me = variable_clone(global.genEnems.debug);

skel = skeletonCreate();

neckHeight     = -32;
shoulderHeight = -20;
waistHeight    =  34;

torso = boneCreate(me.sprs.torso, 0, 0, 0, 0, 0);
head  = boneCreate(me.sprs.head,  0, neckHeight, 0, 0, 1);
luarm = boneCreate(me.sprs.limb, -28, shoulderHeight, 0, 0, 1);
llarm = boneCreate(me.sprs.limb,  0, 34, 0, 0, 1);
ruarm = boneCreate(me.sprs.limb,  28, shoulderHeight, 0, 0, 1);
rlarm = boneCreate(me.sprs.limb,  0, 34, 0, 0, 1);
luleg = boneCreate(me.sprs.limb,  10, waistHeight, 0, 0, 1);
llleg = boneCreate(me.sprs.limb,  0, 34, 0, 0, 1);
ruleg = boneCreate(me.sprs.limb, -10, waistHeight, 0, 0, 1);
rlleg = boneCreate(me.sprs.limb,  0, 34, 0, 0, 1);

skeletonAddBone(skel, torso);
skeletonAddBone(skel, head, torso);
skeletonAddBone(skel, luarm, torso);
skeletonAddBone(skel, llarm, luarm);
skeletonAddBone(skel, ruarm, torso);
skeletonAddBone(skel, rlarm, ruarm);
skeletonAddBone(skel, luleg, torso);
skeletonAddBone(skel, llleg, luleg);
skeletonAddBone(skel, ruleg, torso);
skeletonAddBone(skel, rlleg, ruleg);

skeletonRegisterBone(skel, "torso", torso);
skeletonRegisterBone(skel, "head", head);
skeletonRegisterBone(skel, "luarm", luarm);
skeletonRegisterBone(skel, "llarm", llarm);
skeletonRegisterBone(skel, "ruarm", ruarm);
skeletonRegisterBone(skel, "rlarm", rlarm);
skeletonRegisterBone(skel, "luleg", luleg);
skeletonRegisterBone(skel, "llleg", llleg);
skeletonRegisterBone(skel, "ruleg", ruleg);
skeletonRegisterBone(skel, "rlleg", rlleg);

skeletonPlayAnim(skel, global.debug_anims.wave);