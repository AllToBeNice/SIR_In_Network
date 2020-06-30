

#################打印时间序列图片函数###################
plot_time_series = function(Infected_list, Removed_list, total_time){
  # 获取每天感染的节点数
  num_inf = unlist(lapply(1:total_time, function(x) length(Infected_list[[x]])))
  # 获取每天感染的比例
  p_inf = num_inf / N
  p = diff(c(0, p_inf))
  # 按时间线绘图
  time = 1:total_time
  plot(p_inf~time, type = "b",
       ylab = "Inf", xlab = "Time",
       xlim = c(0,total_time), ylim =c(0,1))
  plot(p~time, type = "h", frame.plot = FALSE,
       ylab = "Dif", xlab = "Time",
       xlim = c(0,total_time), ylim =c(0,1))
}


plot_gif = function(Infected_list, Removed_list){
  d = 1
  while(d <= length(Infected_list)){
    layout(matrix(c(1, 2, 1, 3), 2, 2, byrow = TRUE),
           widths = c(3, 1),
           heights = c(1, 1))
    # 设置不同状态的节点的颜色
    V(g)$color = "white"
    V(g)$color[V(g) %in% Infected_list[[d]]] = "red"
    V(g)$color[V(g) %in% Removed_list[[d]]] = "yellow"
    # 输出图片
    plot(g, layout =layout.old, edge.arrow.size = 0.2)
    # 设置图片标题
    title(paste(graph_name,
                "\n Infected Rate =", InfectedRate,
                "\n Removed Rate =", RemovedRate,
                "\n Day", d))
    plot_time_series(Infected_list, Removed_list, d)
    d = d + 1
  }
}

# 保存GIF动图
save_git = function(Infected_list, Removed_list){
  animation::saveGIF({
    ani.options("convert")
    plot_gif(Infected_list, Removed_list)
    },
    ani.width = 800, ani.height = 500)
}
