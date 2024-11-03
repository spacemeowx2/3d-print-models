// 定义尺寸
// 洞洞板孔半径 3mm
radius = 3;
// 孔洞间距 25mm
spacing = 25;
// 宽度, 乘以间距
span = 3;

// 误差, 留点距离给打印误差
error = 0.6;
// 连接器留边 3mm
margin = 3;
// 托盘长度 45mm
holder_length = 45;

diameter = radius * 2;
total_spacing = spacing * (span - 1);
$fn = 32;

// 创建连接器
module connector() {
    translate([0, diameter, 0])
        rotate([0, 0, 180])
        rotate_extrude(angle=90, convexity=10)
        translate([diameter, 0])
        circle(d = diameter - error);

    main_length = spacing + diameter + margin;

    translate([0, -(main_length - radius - margin), -radius])
        cube([diameter, main_length, diameter]);

    translate([-radius, -spacing, 0])
        rotate([90, 0, 90])
        cylinder(h = radius, d = diameter - error);
}

module main() {
    // 创建主体
    translate([0, 0, radius])
        connector();
    translate([0, 0, radius + total_spacing])
        connector();
    translate([0, -radius, 0])
        cube([diameter, diameter, total_spacing]);
    translate([0, -radius-spacing, 0])
        cube([diameter, diameter, total_spacing]);

    // 支撑座
    translate([diameter, -spacing-radius, 0])
    difference() {
        translate([0, 0, 0])
            cube([holder_length, diameter, total_spacing + diameter], center=false);

        translate([0, -0.5, diameter])
            cube([holder_length, diameter+1, total_spacing - diameter], center=false);
    }

    // 支撑座弯曲部分
    translate([holder_length + diameter, -spacing + radius, 0])
        intersection() {
            cylinder(h = total_spacing + diameter, r = radius * 2);

            rotate([90, 0, 0])
            cube(total_spacing + diameter);
        }

    // 圆角头
    translate([holder_length + diameter, -spacing + radius, 0])
        hull() {
            cube([diameter, diameter, total_spacing + diameter]);
            translate([radius, radius + diameter, 0])
                cylinder(h = total_spacing + diameter, d = diameter);
        };
}

rotate([90, 0, 0])
    main();
