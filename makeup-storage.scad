// 定义长方体的尺寸
length = 112;
width = 156;
height = 50;
grid_size = 20;
divider_thickness = 2;

// 创建长方体
difference() {
    // 外围长方体
    cube([length, width, height]);
    
    // 内部格子
    for (x = [divider_thickness:grid_size+divider_thickness:length-grid_size]) {
        for (y = [divider_thickness:grid_size+divider_thickness:width-grid_size]) {
            translate([x, y, 2])
                cube([grid_size, grid_size, height + 1]);
        }
    }
}