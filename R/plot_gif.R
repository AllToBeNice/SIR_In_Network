# 打印动图每一帧
#' Plot GIF
#'
#' Plot each frame of GIF with grid layout.old.
#'
#' @param Var_Param List, saved important var and params
#' @param layout.old Grid Fruchterman-Reingold layout
#'
#' @return NULL
#' @export
#'
#' @examples Var_Param <- set_param("Random Network", c(0.2), 10, 70, 1, 0, 0.12, 0.4, 7)
#' layout.old = igraph::layout.fruchterman.reingold(Var_Param$Network$graph, niter = 1000)
#' plot_gif(Var_Param, layout.old)
plot_gif = function(Var_Param, layout.old){
  d = 1
  while(d <= length(Var_Param$Infected_list)){
    graphics::layout(matrix(c(1, 2, 1, 3), 2, 2, byrow = TRUE),
                     widths = c(3, 1),
                     heights = c(1, 1))
    # 设置不同状态的节点的颜色
    igraph::V(Var_Param$Networ$graph)$color = "white"
    igraph::V(Var_Param$Networ$graph)$color[igraph::V(Var_Param$Networ$graph) %in% Var_Param$Infected_list[[d]]] = "red"
    igraph::V(Var_Param$Networ$graph)$color[igraph::V(Var_Param$Networ$graph) %in% Var_Param$Removed_list[[d]]] = "yellow"
    # 输出图片
    graphics::plot(Var_Param$Networ$graph, layout = layout.old, edge.arrow.size = 0.2)
    # 设置图片标题
    graphics::title(paste(Var_Param$Networ$name,
                          "\n Infected Rate =", Var_Param$InfectedRate,
                          "\n Removed Rate =", Var_Param$RemovedRate,
                          "\n Day", d))
    SIRInNetwork::plot_time_series(Var_Param, d)
    d = d + 1
  }
}
