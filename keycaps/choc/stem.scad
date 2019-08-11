$fs = 0.05;
$fa = 4.5;

stem_height = 4.0;
stem_thickness = 1.2;
stem_interval = 7.0 - stem_thickness * 2;
stem_width = 2.8;

gloove_depth = 0.2;
gloove_width = 1.4;

base_width = 8.0;
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
    offsetX = (base_width - stem_interval - 2 * stem_thickness) / 2;
    offsetY = (base_width - stem_width) / 2;
    offsetY2 = (stem_width - gloove_width) / 2;
    offsetX1 = stem_thickness - gloove_depth;
    offsetX2 = stem_thickness - gloove_depth;
    translate([offsetX, offsetY, 0]) difference() {
        cube([stem_thickness, stem_width, stem_height]);
        translate([0, offsetY2, 0]) cube([gloove_depth, gloove_width, stem_height]);
        translate([offsetX2, offsetY2, 0]) cube([gloove_depth, gloove_width, stem_height]);
    }
}

module stem_right() {
    offsetX = (base_width + stem_interval) / 2;
    offsetY = (base_width - stem_width) / 2;
    offsetY2 = (stem_width - gloove_width) / 2;
    offsetX1 = stem_thickness - gloove_depth;
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

for (x = [0:5], y= [0:5])
    translate([x * 10 + 2, y * 10 + 2, 0]) stem();
