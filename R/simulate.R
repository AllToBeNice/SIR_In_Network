#' Simulate
#'
#' Simulate the process.
#'
#' @param Var_Param List, saved important var and params
#'
#' @return Show the GIF
#' @export
#'
#' @examples Var_Param <- set_param("Random Network", c(0.2), 10, 70, 1, 0, 0.12, 0.4, 7)
#' simulate(Var_Param)
simulate <- function(Var_Param) {
  # 开始模拟
  # 等可能选取n个初始不同的结点
  # 通过改变I的初始值能够设定初始有多少个感染者
  infected = sample(igraph::V(Var_Param$Network$graph), Var_Param$I)
  # 治愈者时间节点序列 & 潜伏期计数列表需要先赋值为空的网络节点，以便于做运算
  Var_Param$Removed_list[[1]] = igraph::V(Var_Param$Network$graph)[0]
  for (i in 1:(Var_Param$Latency_Infected)) {
    Var_Param$TimeLine_Infected[[i]] = igraph::V(Var_Param$Network$graph)[0]
  }
  # 记录第1个时间单位的感染者序列和潜伏期时间
  Var_Param$Infected_list[[1]] = infected
  Var_Param$TimeLine_Infected[[Var_Param$Latency_Infected]] = infected
  # 设置边和顶点的颜色
  # 初始设置全部节点为易感状态，颜色为白色
  # 之后能够设置感染节点为红色，移除节点为黄色
  igraph::E(Var_Param$Network$graph)$color = "grey" # Edges
  igraph::V(Var_Param$Network$graph)$color = "white" # Vertices
  # 绘出初始状态图，设置绘图模式layout.fruchterman.reingold
  layout.old = igraph::layout.fruchterman.reingold(Var_Param$Network$graph,
                                                   niter = 1000)
  igraph::V(Var_Param$Network$graph)$color[igraph::V(Var_Param$Network$graph)%in%infected] = "red"
  graphics::plot(Var_Param$Network$graph, layout =layout.old)
  # 迭代
  wait_removed = NULL
  total_time = 1
  while(total_time < Var_Param$TIME){
    Var_Param$Infected_list[[total_time+1]] = SIRInNetwork::update_infected(Var_Param, total_time)
    # 取出等待判断是否治愈的结点，加入等待治愈的序列
    wait_removed = c(wait_removed, Var_Param$TimeLine_Infected[[1]])
    # 所有节点的计时器向前移动1，即下标-1
    for(i in 2:length(Var_Param$TimeLine_Infected)) {
      Var_Param$TimeLine_Infected[[i-1]] = Var_Param$TimeLine_Infected[[i]]
    }
    # 新增感染节点加入潜伏期计时序列
    Var_Param$TimeLine_Infected[[Var_Param$Latency_Infected]] =
      subset(Var_Param$Infected_list[[total_time+1]],
             !Var_Param$Infected_list[[total_time+1]] %in% Var_Param$Infected_list[[total_time]])
    # 新增治愈者加入治愈者时间序列
    if (length(wait_removed) != 0) {
      Var_Param$Removed_list = update_removed(Var_Param, wait_removed, total_time)
    }else {
      Var_Param$Removed_list[[total_time+1]] = Var_Param$Removed_list[[total_time]]
    }
    # 从当前时刻感染者序列中删去当前时刻的新增治愈者
    Var_Param$Infected_list[[total_time+1]] =
      subset(Var_Param$Infected_list[[total_time+1]],
             !Var_Param$Infected_list[[total_time+1]] %in% Var_Param$Removed_list[[total_time+1]])
    # 从等待治愈的序列中删去已治愈的节点
    wait_removed = subset(wait_removed, !wait_removed %in% Var_Param$Removed_list[[total_time+1]])
    Var_Param$TotalInfected = length(Var_Param$Infected_list[[total_time+1]])
    total_time = total_time + 1
  }
  SIRInNetwork::save_gif(Var_Param, layout.old)
}
