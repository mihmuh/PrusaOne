// PRUSA iteration3
// Y frame corners
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

eps = 0.01;

height = 60; //47;
width = 25; //18;
depth = 22; //22;
r_hole = 5.4;

hole_distance = (height - 17) / 3;

bevel_cube = 100; // size not important, as long as big enough
bevel_cube_offset = bevel_cube/2 * cos(45);
bevel_cut = 1;

ziptie_height = 2.0;
ziptie_width = 3.5;



module corner_base(){
 translate([-width/2,-depth/2,0])cube([width,depth,height]);
}

module corner_holes(){
 translate([0,-depth/2,0]){
  // Bottom hole
  translate([0,depth/2,hole_distance]) rotate([0,90,0]) translate([0,0,-width/2-eps]) cylinder(h = width+2*eps, r=r_hole, $fn=30);
  // Top hole
  translate([0,depth/2,3*hole_distance]) rotate([0,90,0]) translate([0,0,-width/2-eps]) cylinder(h = width+2*eps, r=r_hole, $fn=30);
  // Middle hole
  translate([0,-eps,2*hole_distance]) rotate([0,0,90]) rotate([0,90,0]) cylinder(h = depth+2*eps, r=r_hole, $fn=30);

  // Washer hole
//  translate([0,-3,2*hole_distance]) rotate([0,0,90]) rotate([0,90,0]) translate([0,0,-5]) cylinder(h = 10, r=2*r_hole+0.2, $fn=30);

  // Top smooth rod insert
  // Smooth rod place
  translate([0,2,height-2]) rotate([0,90,90]) cylinder(h = depth, r=4.2, $fn=30);
  // Ziptie
  translate([-width/2-eps,depth/2-ziptie_width/2,height-8]) cube([width+2*eps,ziptie_width,ziptie_height]);
 }
}

module corner_fancy(){
  // Side corner cutouts
  translate([width/2+bevel_cube_offset-bevel_cut,-depth/2-bevel_cube_offset+bevel_cut,height/2]) rotate([0,0,-45-180]) translate([-bevel_cube/2,-bevel_cube/2,-bevel_cube/2]) cube([bevel_cube,bevel_cube,bevel_cube]);
  translate([-width/2-bevel_cube_offset+bevel_cut,-depth/2-bevel_cube_offset+bevel_cut,height/2]) rotate([0,0,45-180]) translate([-bevel_cube/2,-bevel_cube/2,-bevel_cube/2]) cube([bevel_cube,bevel_cube,bevel_cube]);

 // Top corner cutouts
  translate([width/2+bevel_cube_offset-bevel_cut,0,bevel_cube_offset+height-bevel_cut]) rotate([0,45,0]) translate([-bevel_cube/2,-bevel_cube/2,-bevel_cube/2]) cube([bevel_cube,bevel_cube,bevel_cube]);
  translate([-width/2-bevel_cube_offset+bevel_cut,0,bevel_cube_offset+height-bevel_cut]) rotate([0,-45,0]) translate([-bevel_cube/2,-bevel_cube/2,-bevel_cube/2]) cube([bevel_cube,bevel_cube,bevel_cube]);
  rotate([0,0,90]) translate([-depth/2-bevel_cube_offset+bevel_cut,0,bevel_cube_offset+height-bevel_cut]) rotate([0,-45,0]) translate([-bevel_cube/2,-bevel_cube/2,-bevel_cube/2]) cube([bevel_cube,bevel_cube,bevel_cube]);
}


// Final part
module corner(){
 // Rotate the part for better printing
// translate([0,0,depth/2]) rotate([-90,0,0]) difference(){
 difference() {
  corner_base();
  corner_holes();
  corner_fancy();
 }
}

echo("hole_distance=", hole_distance);

corner();
