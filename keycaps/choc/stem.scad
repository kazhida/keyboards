$fs = 0.05;
$fa = 4.5;

stem_height = 4.0;
stem_thickness = 1.3;
stem_interval = 7.0 - stem_thickness * 2;
stem_width = 3.0;

gloove_depth = 0.2;
gloove_width = 1.4;

base_width = 7.0;
base_height = 1.0;
base_r = 2.0;

module stem_base() {
    base_offset = base_width - base_r;
    union() {
        translate([base_r, base_r, 0])  cylinder(h = base_height, r = base_r);
        translate([base_offset, base_r, 0]) cylinder(h = base_height, r = base_r);
        translate([base_r, base_offset, 0]) cylinder(h = base_height, r = base_r);
        translate([base_offset, base_offset, 0]) cylinder(h = base_height, r = base_r);
        translate([base_r, 0, 0]) cube([base_width - 2 * base_r, base_width, base_height]);
        translate([0, base_r, 0]) cube([base_width, base_width - 2 * base_r, base_height]);
    }
}

module stem_left() {
    offsetY = (base_width - stem_width) / 2;
    offsetY2 = (stem_width - gloove_width) / 2;
    offsetX = stem_thickness - gloove_depth;
    translate([0, offsetY, 0]) difference() {
        cube([stem_thickness, stem_width, stem_height]);
        translate([0, offsetY2, 0]) cube([gloove_depth, gloove_width, stem_height]);
        translate([offsetX, offsetY2, 0]) cube([gloove_depth, gloove_width, stem_height]);
    }
}

module stem_right() {
    offsetX = base_width - stem_thickness;
    offsetY = (base_width - stem_width) / 2;
    offsetY2 = (stem_width - gloove_width) / 2;
    offsetX2 = stem_thickness - gloove_depth;
    translate([offsetX, offsetY, 0]) difference() {
        cube([stem_thickness, stem_width, stem_height]);
        translate([0, offsetY2, 0]) cube([gloove_depth, gloove_width, stem_height]);
        translate([offsetX2, offsetY2, 0]) cube([gloove_depth, gloove_width, stem_height]);
    }
}

module stem() {
    union() {
        stem_base();
        stem_left();
        stem_right();
    }
}

//stem_size = [1.15, 2.98, 3.50 + 2.00];
//stem_diff = [stem_size[0], stem_size[1] / 2.10, stem_size[2] + 1.00];
//stem_offset = [5.70 / 2, 0, stem_size[2] / 2];
//
//module stem_one_side() {
//    difference() {
//        cube(stem_size, true);
//        translate([stem_size[0] * 2.50 / 3, 0, 0])
//            cube(stem_diff, true);
//        translate([stem_size[0] * -2.50 / 3, 0, 0])
//            cube(stem_diff, true);
//    }
//}
//
//module choc_stems() {
//    translate(stem_offset)
//        stem_one_side();
//    translate([-1 * stem_offset[0], stem_offset[1], stem_offset[2]])
//        stem_one_side();
//}

for (x = [0:2], y= [0:2])
    translate([x * 10, y * 10, 0]) stem();
