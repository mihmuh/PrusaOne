eps = 0.01;

height = 60;
width = 25;
depth = 25;
depth2 = 30;

r_hole = 5.4;

hole_distance = 14.333;


brace_hole_length = 200; // size not important, as long as big enough
brace_hole_length2 = 42;
brace_hole_xpos = 23;
brace_hole_ypos = -11;
brace_hole_height = 1.1*height;

angle = atan(370/120)-90; 


module corner_base(){
	translate([-width/2,-depth/2,0]) cube([width,depth,height]);
	translate([0,brace_hole_ypos,brace_hole_height]) rotate([angle,0,0]) translate([-width/2,-depth2/2,-brace_hole_length2/2-brace_hole_xpos]) cube([width,depth2,brace_hole_length2]);
}

module corner_holes(){
	translate([0,-depth/2,0]){
  		// Bottom hole
		translate([0,depth/2,hole_distance]) rotate([0,90,0]) translate([0,0,-width/2-eps]) cylinder(h = width+2*eps, r=r_hole, $fn=30);
		// Top hole
		translate([0,depth/2,3*hole_distance]) rotate([0,90,0]) translate([0,0,-width/2-eps]) cylinder(h = width+2*eps, r=r_hole, $fn=30);
 	}
	// Brace hole
	translate([0,brace_hole_ypos,brace_hole_height]) rotate([angle,0,0]) translate([0,0,-brace_hole_length/2]) cylinder(h = brace_hole_length, r=r_hole, $fn=30);
}


// Final part
module corner(){
	difference() {
		corner_base();
		corner_holes();
	}
}

echo("hole_distance=", hole_distance);
echo("angle=", angle);

translate([0,0,width/2]) rotate([0,90,0]) corner();
