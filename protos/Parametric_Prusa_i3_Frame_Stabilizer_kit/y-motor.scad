// PRUSA iteration3
// Y motor mount
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

$fn=30;

eps = 0.01;

r_screw_hole = 1.7;
r_screw_hole2 = 3.5;
wall_thickness = 2.5;

r_hole = 5.4;
hole_distance = 2*14.33;
width = 12; //10;

extraOffsetX = 3;
extraOffsetY = 14;


module y_motor_base(){
 // Motor holding part
 translate(v = [29,-21+50,0]){
  translate(v = [-21+4.5+extraOffsetX,extraOffsetY,width/2]) cube(size = [9,31,width], center=true);
  translate(v = [-15.5+extraOffsetX,-15.5+extraOffsetY,0]) cylinder(h = width, r=r_screw_hole2+wall_thickness);
  translate(v = [-15.5+extraOffsetX,+15.5+extraOffsetY,0]) cylinder(h = width, r=r_screw_hole2+wall_thickness);
 }

 // Front holding part
 translate(v = [0,10,0]) cylinder(h = width, r=r_hole+wall_thickness);
 translate(v = [0,10+hole_distance/2,width/2]) cube(size = [16,hole_distance,width], center=true);
 translate(v = [0,10+hole_distance,0]) cylinder(h = width, r=r_hole+wall_thickness);

  // Joins motor holder and rod plate; draw polygon between all middle points of cylinders
  translate([0,0,width/2]) linear_extrude(height=width, center=true, convexity=10, twist=0) polygon([[29-15.5+extraOffsetX,-21+50-15.5+extraOffsetY],[29-15.5+extraOffsetX,-21+50+15.5+extraOffsetY],[0,10+hole_distance],[0,10]]);

}

module y_motor_holes(){
 translate(v = [29,-21+50,0]){
  // Screw head holes
  translate(v = [-15.5+extraOffsetX,-15.5+extraOffsetY,-eps]) cylinder(h = width + 2*eps, r=r_screw_hole);
  translate(v = [-15.5+extraOffsetX,+15.5+extraOffsetY,-eps]) cylinder(h = width + 2*eps, r=r_screw_hole);
  // Screw holes
  translate(v = [-15.5+extraOffsetX,-15.5+extraOffsetY,width-5]) cylinder(h = 7+eps, r=r_screw_hole2);
  translate(v = [-15.5+extraOffsetX,+15.5+extraOffsetY,width-5]) cylinder(h = 7+eps, r=r_screw_hole2);
 }
 translate(v = [0,10,-eps]) cylinder(h = width + 2*eps, r=r_hole);
 translate(v = [0,10+hole_distance,-eps])cylinder(h = width + 2*eps, r=r_hole);
}

// Final part
module y_motor(){
 difference(){
  y_motor_base();
  y_motor_holes();
 }
}

y_motor();
