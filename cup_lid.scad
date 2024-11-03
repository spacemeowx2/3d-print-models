// 定义杯盖的参数
outer_diameter_top = 100; // 上部外径
outer_diameter_bottom = 93; // 下部外径
height_top = 2.5;          // 上部高度
height_bottom = 2.5;       // 下部高度
straw_hole_diameter = 10; // 吸管孔的直径

// 创建杯盖
module cup_lid() {
    difference() {
        union() {
            // 上部圆柱
            cylinder(h = height_top, d = outer_diameter_top, $fn = 100);
            // 下部圆柱
            translate([0, 0, height_top])
                cylinder(h = height_bottom, d = outer_diameter_bottom, $fn = 100);
        }
        // 吸管孔
        translate([0, 0, -1]) // 向下移动1mm以确保完全切割
            cylinder(h = height_top + height_bottom + 2, d = straw_hole_diameter, $fn = 100);
    }
}

// 渲染杯盖
cup_lid();
