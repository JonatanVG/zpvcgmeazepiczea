/// @description Insert description here
// You can write your code in this editor

me = variable_clone(global.genEnems.plant); // Placeholder, overwritten at runtime by main_con_obj

skel = skeletonCreate();

torso = boneCreate(me.sprs.torso, 0, 0, 0, 0, 0);
stilk = boneCreate(me.sprs.stilk, 0, 0, 0, 0, 0);
head  = boneCreate(me.sprs.head,  0, -44, 0, 0, 0);


skeletonAddBone(skel, torso);
skeletonAddBone(skel, stilk, torso);
skeletonAddBone(skel, head, stilk);