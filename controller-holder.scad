// 定义尺寸
// 洞洞板孔半径 6mm
radius = 30;
diameter = radius * 2;
// 孔洞间距 25mm
spacing = 250;
// 主轴留边 2mm
margin = 20;
// 托盘长度 40mm
holder_length = 400;

// 创建连接器
module connector() {
    translate([-diameter, radius*4, 0])
        rotate([90, 0, 0])
        cylinder(h = radius * 2, r = radius);
    translate([0, diameter, 0])
        rotate([0, 0, 180])
        rotate_extrude(angle=90, convexity=10)
        translate([diameter, 0])
        circle(radius);
    
    main_length = spacing + radius * 2 + margin * 2;
    
    translate([0, -main_length+(radius+margin), -radius])
        cube([diameter, main_length, diameter]);
    
    translate([-diameter, -spacing, 0])
        rotate([90, 0, 90])
        cylinder(h = diameter, r = radius);
}

module main() {
    translate([0, 0, radius])
        connector();
    translate([0, 0, radius + spacing])
        connector();
    translate([0, -radius, 0])
        cube([diameter, diameter, spacing]);
    translate([0, -radius-spacing, 0])
        cube([diameter, diameter, spacing]);

    translate([radius*2, -spacing, 0])
        linear_extrude(spacing + radius * 2)
        polygon(points=[
            [0,0],
            [holder_length,0],
            [holder_length,radius*2],
            [0,radius*2],
        ]);
   
    translate([holder_length + diameter, -spacing + diameter, 0])
        intersection() {
            cylinder(h = spacing + diameter, r = radius * 2);
            
            rotate([90, 0, 0])
            cube(spacing + diameter);
        }
    
    translate([holder_length + diameter, -spacing + diameter, 0])
        cube([diameter, diameter * 2, spacing + diameter]);
}

main();