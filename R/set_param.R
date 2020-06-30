#' Set important params
#'
#' Set important params of simulation and create a list as
#' a structure in C to pass the important variables and params.
#' It contains:
#'     N Total number of nodes
#'     TIME Total time of simulation
#'     S I R Imitial number of S、I、R
#'     InfectedRate Infected rate
#'     RemovedRate Removed rate
#'     Latency_Infected Latency of infected
#'     TotalInfected The total number of infected
#'     Infected_list Store the number of infected changeing over time
#'     Removed_list Store the number of removed changeing over time
#'     TimeLine_Infected Store the latency over time for every node
#'     TimeLine_Removed
#'
#' @param Net_Name String, 网络名称
#' @param Net_Params Vector, 网络参数向量
#' @param N Int, 模拟节点数
#' @param TIME Int, 模拟总时间
#' @param I Int, 初始感染人数
#' @param R Int, 初始移除人数
#' @param InfectedRate Float, 感染率
#' @param RemovedRate Float, 移除率
#' @param Latency_Infected Int, 潜伏期
#'
#' @return Var_Param List
#' @export
#'
#' @examples set_param("Random Network", c(0.7), 10, 70, 1, 0, 0.12, 0.4, 7)
set_param = function(Net_Name, Net_Params,
                     N, TIME, I, R,
                     InfectedRate, RemovedRate,
                     Latency_Infected) {
  # 根据参数创建指定网络
  # 将节点数量加入网络参数
  Net_Params <- c(N, Net_Params)
  Network <- SIRInNetwork::generate_network(Net_Name, Net_Params)
  # 创建列表，作为结构体传递重要参数和变量
  Var_Param <- list(Network,
                    N, TIME, I, R, N-I-R,
                    InfectedRate, RemovedRate,
                    Latency_Infected,
                    I,
                    list(), list(),
                    list())
  # 元素重命名
  names(Var_Param) <- c('Network',
                        'N', 'TIME', 'I', 'R', 'S',
                        'InfectedRate', 'RemovedRate',
                        'Latency_Infected',
                        'TotalInfected',
                        'Infected_list', 'Removed_list',
                        'TimeLine_Infected')
  return(Var_Param)
}
