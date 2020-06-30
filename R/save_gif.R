# 生成GIF动图
#' Save GIF
#'
#' Generate GIF image from frames.
#'
#' @param Var_Param List, saved important var and params
#' @param layout.old Grid Fruchterman-Reingold layout
#'
#' @return GIF Image
#' @export
#'
#' @examples Var_Param <- set_param("Random Network", c(0.2), 10, 70, 1, 0, 0.12, 0.4, 7)
#' layout.old = igraph::layout.fruchterman.reingold(Var_Param$Network$graph, niter = 1000)
#' save_gif(Var_Param, layout.old)
save_gif = function(Var_Param, layout.old){
  animation::saveGIF({
    animation::ani.options("convert")
    SIRInNetwork::plot_gif(Var_Param, layout.old)
    },
    ani.width = 800, ani.height = 500)
}
