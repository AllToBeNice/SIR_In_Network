# 更新治愈者
#' Update removed
#'
#' Randomly update removed infected nodes and return all the removed nodes.
#'
#' @param Var_Param List, saved important var and params
#' @param wait_removed Vector, the infected nodes wait to be removed
#' @param day Int, the time at now
#'
#' @return Var_Param$Removed_list List, shallow copy
#' @export
#'
#' @examples NULL
update_removed = function(Var_Param, wait_removed, day) {
  # 产生移除概率向量
  Rem_prob = c(Var_Param$RemovedRate, 1-Var_Param$RemovedRate)
  # 获得等待判断是否康复的结点
  wait_removed = data.frame(table(unlist(igraph::V(Var_Param$Network$graph)[wait_removed])))
  # 通过概率函数判断是否康复
  push = unlist(lapply(wait_removed[,2], SIRInNetwork::random_selection, vec_prob = Rem_prob))
  # 获得新康复结点
  new_removed = as.numeric(as.character(wait_removed[,1][push >= 1]))
  # 新康复者加入治愈者序列
  if (length(Var_Param$Removed_list[[day]]) == 0 && length(new_removed) == 0) {
    Var_Param$Removed_list[[day+1]] = igraph::V(Var_Param$Network$graph)[0]
  }else {
    Var_Param$Removed_list[[day+1]] = c(Var_Param$Removed_list[[day]], igraph::V(Var_Param$Network$graph)[new_removed])
  }
  return(Var_Param$Removed_list)
}
