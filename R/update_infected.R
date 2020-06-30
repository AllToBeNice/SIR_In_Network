# 更新感染后的节点，返回感染后全部受到感染的结点
#' Update infected
#'
#' Randomly update newly infected nodes and return all the infected nodes.
#'
#' @param Var_Param List, saved important var and params
#' @param total_time Int, the time at now
#'
#' @return infected, Vector, the new infected nodes at now
#' @export
#'
#' @examples Var_Param <- set_param("Random Network", c(0.2), 10, 70, 1, 0, 0.12, 0.4, 7)
#' infected <- sample(igraph::V(Var_Param$Network$graph), Var_Param$I)
#' Var_Param$Infected_list[[1]] = infected
#' for (i in 1:Var_Param$Latency_Infected) {
#' Var_Param$TimeLine_Infected[[i]] = igraph::V(Var_Param$Network$graph)[0]
#' }
#' Var_Param$TimeLine_Infected[[Var_Param$Latency_Infected]] = infected
#' Var_Param$Removed_list[[1]] = igraph::V(Var_Param$Network$graph)[0]
#' update_infected(Var_Param, 1)
update_infected = function(Var_Param, total_time) {
  # 产生感染概率向量
  Inf_prob = c(Var_Param$InfectedRate, 1-Var_Param$InfectedRate)
  # 产生当前处于感染状态的节点
  infected <- Var_Param$Infected_list[[total_time]]
  # 选取当前感染节点的领接节点
  nearest_neighbors = data.frame(table(unlist(igraph::neighborhood(Var_Param$Network$graph, 1, infected))))
  # 删去已感染的结点
  nearest_neighbors = subset(nearest_neighbors, !(nearest_neighbors[,1] %in% infected))
  # 删去已治愈的结点
  nearest_neighbors = subset(nearest_neighbors, !(nearest_neighbors[,1] %in% Var_Param$Removed_list[[total_time]]))
  # 返回更新的感染节点
  keep = unlist(lapply(nearest_neighbors$Freq, SIRInNetwork::random_selection, vec_prob = Inf_prob))
  new_infected = as.numeric(as.character(nearest_neighbors[,1][keep >= 1]))
  # 去除重复的感染节点
  infected = unique(c(infected, igraph::V(Var_Param$Network$graph)[new_infected]))
  return(infected)
}
