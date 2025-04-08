if (window_get_width()!=windowWidth || window_get_height()!=windowHeight) {
    windowWidth  = window_get_width()
    windowHeight = window_get_height()

    window_set_region_size(windowWidth,windowHeight,0)
    window_resize_buffer(windowWidth,windowHeight,1,0)
    view_wport=windowWidth
    view_wview=windowWidth
    view_hport=windowHeight
    view_hview=windowHeight
}
