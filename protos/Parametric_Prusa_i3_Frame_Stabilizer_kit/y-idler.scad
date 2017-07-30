$fn=30;

eps = 0.01;

r_screw_hole = 1.5;
r_bearing_screw_hole = 2.0;
wall_thickness = 3.5;
wall_thickness2 = 4.5;

r_hole = 5.4;
r_bearing_hole = 11;

width = 20;
length_slot = 5 * r_hole;
height = 2 * (r_hole + wall_thickness);
length = wall_thickness + r_bearing_hole + 2*wall_thickness + length_slot + wall_thickness;


module y_idler_base(){
	cube([width,length,height/2]);
	translate([0,height/2,height/2]) cube([width,length-height,height/2]);
	translate([0,height/2,height/2]) rotate([0,90,0]) cylinder(h=width,r=height/2);
	translate([0,length-height/2,height/2]) rotate([0,90,0]) cylinder(h=width,r=height/2);
}


module draw_slot() {
	translate([-eps,length-height/2,height/2]) rotate([0,90,0]) cylinder(h=width+2*eps,r=r_hole);
	translate([-eps,length-height/2-length_slot+2*r_hole,height/2]) rotate([0,90,0]) cylinder(h=width+2*eps,r=r_hole);
	translate([-eps,length-length_slot-height/2+2*r_hole,height/2-r_hole]) cube([width+2*eps,length_slot-2*r_hole,2*r_hole]);
}


module y_idler_holes(){
	draw_slot();
	// bearing hole
	translate([-eps,wall_thickness+r_bearing_screw_hole,height/2]) rotate([0,90,0]) cylinder(h=width+2*eps,r=r_bearing_screw_hole);
	translate([wall_thickness2,wall_thickness+r_bearing_screw_hole,height/2]) rotate([0,90,0]) cylinder(h=width-2*wall_thickness2,r=r_bearing_hole);
	// screw hole
	translate([width/2,length-wall_thickness-eps,height/2]) rotate([-90,0,0]) cylinder(h=wall_thickness+2*eps,r=r_screw_hole);
}


module y_idler(){
	translate(v = [0,0,0]) rotate([0,0,0]) difference(){
  		y_idler_base();
  		y_idler_holes();
 	}
}


y_idler();
