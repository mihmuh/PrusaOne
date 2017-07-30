angle = atan(370/120)-90; 

// mounting bracket
width = 40;
height = 20;
depth = 8;
hole_distance = 20;
r_hole = 1.8;
hole_posx = (width - hole_distance) / 2 - width / 2;
hole_posz = height / 2;


// brace
width2 = 25;
depth2 = 25;
height2 = 30;
r_hole2 = 5.4;

brace_hole_posx = -20;
brace_hole_posz = 30;
brace_hole_offset = -1.5;


// mounting bracket 2
hole_posz2 = height + height2*cos(angle) + height / 2;


// zip tie
ziptie_height = 2.0;
ziptie_width = 3.5;
hole_posz3 = 3 + height + height2*cos(angle) + height / 2;


eps = 2.0;


module z_top_base(){
	// bracket
	translate([-depth/2,-width/2,0]) cube([depth,width,height]);
	translate([-depth/2,-width2/2,height+height2*cos(angle)]) cube([depth,width2,height]);
	// brace
	translate([brace_hole_posx,0,brace_hole_posz]) rotate([0,angle,0]) translate([-depth2/2,-width2/2,-height2/2]) cube([depth2,width2,height2]);
	translate([-depth2+depth/2,-width2/2,height]) cube([depth2,width2,height2*cos(angle)]);
}


module z_top_holes(){
	// Screw holes
	translate([-eps-depth/2,hole_posx,hole_posz]) rotate([0,90,0]) cylinder(h=depth+2*eps, r=r_hole, $fn=30);
	translate([-eps-depth/2,hole_posx+hole_distance,hole_posz]) rotate([0,90,0]) cylinder(h=depth+2*eps, r=r_hole, $fn=30);
	translate([-eps-depth/2,0,hole_posz2]) rotate([0,90,0]) cylinder(h=depth+2*eps, r=r_hole, $fn=30);
	// brace
	translate([brace_hole_posx,0,brace_hole_posz]) rotate([0,angle,0]) translate([brace_hole_offset,0,-height2/2-eps]) cylinder(h = height2+2*eps, r=r_hole2, $fn=30);
	translate([brace_hole_posx,0,brace_hole_posz]) rotate([0,angle,0]) translate([-depth2/2-eps,-width2/2-eps,height2/2]) cube([depth2+2*eps,width2+2*eps,height2]);

	// Ziptie
	translate([-ziptie_height/2,-width2/2-eps, hole_posz3]) cube([ziptie_height,width2+2*eps,ziptie_width]);
}




// Final part
module z_top(){
	translate([0,0,depth/2]) rotate([0,90,0]) difference(){
		z_top_base();
		z_top_holes();
	}
}


z_top();


