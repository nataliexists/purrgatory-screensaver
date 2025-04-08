///apply_hueshift(amount)

shader_vertex_reset()
shader_pixel_set(global.hueshiftShader)
shader_pixel_uniform_f("amount",argument0/200)
