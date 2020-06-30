# 打印时间序列图片
#' Plot Images by time series
#'
#' Plot daily proportion of infected and
#' daily increased proportion of infected by time series.
#'
#' @param Var_Param List, saved important var and params
#' @param total_time Int, the number of passed times
#'
#' @return NULL
#' @export
#'
#' @examples Var_Param <- set_param("Random Network", c(0.2), 10, 70, 1, 0, 0.12, 0.4, 7)
#' infected = sample(igraph::V(Var_Param$Network$graph), Var_Param$I)
#' Var_Param$Infected_list[[1]] = infected
#' plot_time_series(Var_Param, 1)
plot_time_series = function(Var_Param, total_time){
  # 获取每天感染的节点数
  num_inf = unlist(lapply(1:total_time, function(x) length(Var_Param$Infected_list[[x]])))
  # 获取每天感染的比例
  p_inf = num_inf / Var_Param$N
  # 获取每天新增比例
  p = diff(c(0, p_inf))
  # 按时间线绘图
  time = 1:total_time
  graphics::plot(p_inf~time, type = "b",
       ylab = "Inf", xlab = "Time",
       xlim = c(0, total_time), ylim =c(0,1))
  graphics::plot(p~time, type = "h", frame.plot = FALSE,
       ylab = "Dif", xlab = "Time",
       xlim = c(0, total_time), ylim =c(0,1))
}
