NOZZLES_04_ROWS = 4;

NOZZLES = [
    ".2",
    ".3",
    ".5",
    ".6",
    ".8",
];

NOZZLE_GROUP_SIZE = 3;

SOCKET_RADIUS = 3.1;

x_distance = 9;
y_distance = 9;

box = [
    (NOZZLE_GROUP_SIZE - 1) * x_distance + 16,
    (NOZZLES_04_ROWS + len(NOZZLES) - 2) * y_distance + 21, 
    6
];

module box_frame() {
    difference() {
        union() {
            cube(box);
            translate([1.1, 1.1, box.z]) 
                cube([box.x-2.2, box.y-2.2, 2]);
        }
        
        different_nozzles();
        
        translate([3, (len(NOZZLES) - 1) * y_distance + 10, 7])
            cube([NOZZLE_GROUP_SIZE * x_distance, 1, 2]);
        
        translate([0, (len(NOZZLES) - 1) * y_distance + 11, 0])
            nozzles_04();
        
        translate([box.x, box.y / 2, 2])
            cube([4, 15, 5], true);
        
        translate([box.x, box.y / 2, 2])
            cube([2, 15, 20], true);
    }
    
    for (i = [0: len(NOZZLES)-1]) {
        translate([5.5, 5 + i * y_distance, 6.5])
            rotate([0, 0, 90])
            linear_extrude(2)
            text(NOZZLES[i], size = 4, halign = "center", font = "Arial: style=Bold", $fn=50);
    }
    
    translate([5.5, (len(NOZZLES) - 1) * y_distance + 11 + (NOZZLES_04_ROWS -1 ) * y_distance / 2 + 5, 6.5])
        rotate([0, 0, 90])
        linear_extrude(2)
        text(".4", size = 4, halign = "center", font = "Arial: style=Bold", $fn=50);
}

module different_nozzles() {
    for (i = [0: len(NOZZLES)-1]) {
        for (j = [0: NOZZLE_GROUP_SIZE-1]) {
            translate([10 + j * x_distance, 5 + i * y_distance, 2])
                cylinder(10, SOCKET_RADIUS, SOCKET_RADIUS, $fn=50);
            
            translate([10 + j * x_distance, 5 + i * y_distance, 2])
                %nozzle();
        }
    }
}

module nozzles_04() {
    for (i = [0: NOZZLES_04_ROWS-1]) {
        for (j = [0: NOZZLE_GROUP_SIZE-1]) {
            translate([10 + j * x_distance, 5 + i * y_distance, 2])
                cylinder(10, SOCKET_RADIUS, SOCKET_RADIUS, $fn=50);
            
            translate([10 + j * x_distance, 5 + i * y_distance, 2])
                %nozzle();
        }
    }
}


module nozzle() {
    cylinder(7.3, 3, 3, $fn=100);
    
    translate([0, 0, 7.3])
        cylinder(3, 4, 4, $fn=6);
    
    translate([0, 0, 10.3])
        cylinder(2.2, 2.6, 0.7, $fn=100);
}

module lid() {
    union () {
        difference() {
            cube([box.x, box.y, 8]);
            
            translate([1, 1, 1])
            cube([box.x - 2, box.y - 2, 10]);
        }
    }
        
    translate([box.x - 0.5, box.y / 2, 8])
        cube([1, 14, 10], true);
    
    translate([box.x, box.y / 2 + 7, 10])
        rotate([90, 0, 0])
        linear_extrude(14)
        polygon([
            [0, 0], [-2, 1], [-1, 4], [0, 4]
        ]);
    
    translate([1, 10, 8])
    rotate([-90, 0, 0])
        linear_extrude(10)
        polygon([[0, 0], [1, 0], [0, 1]]);
    
    translate([1, box.y - 20, 8])
    rotate([-90, 0, 0])
        linear_extrude(10)
        polygon([[0, 0], [1, 0], [0, 1]]);
}


intersection() {
    union() {
        box_frame();
        
        translate([box.x + 50, 0, 0])
            rotate([0, -0, 0])
            lid();
    }
    
//    cube([box.x, box.y / 2, 100]);
    // translate([60, 30, 0]) cube([25, 25, 100]);
        // translate([28, 0, 0]) cube([20, 25, 100]);

}


