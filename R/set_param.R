set_param = function(Network,
                     N, TIME, I, R,
                     InfectedRate, RemovedRate,
                     Latency_Infected) {
  # 根据参数创建指定网络

  # 创建列表，作为结构体传递重要参数和变量
  Var_Param <- list(Network,
                    N, TIME, I, R, N-I-R,
                    InfectedRate, RemovedRate,
                    Latency_Infected)
  # 元素重命名
  names(Var_Param) <- c('Network',
                        'N', 'TIME', 'I', 'R', 'S',
                        'InfectedRate', 'RemovedRate',
                        'Latency_Infected')
  return(Var_Param)
}
# 模拟节点数
N = 20
# 模拟节点数
TIME = 70
# S、I、R 初始数量
I = 1
R = 0
S = N - I - R
# 感染率
InfectedRate = 0.2586
# 移除率（治愈率或死亡率）
RemovedRate = 0.0821
# 潜伏期时间
Latency_Infected = 7
# 治愈期时间（预计用于带隔离项的模拟，此处暂未用到）
Time_Removed = 6
#####################状态变量########################
# 记录总感染人数
TotalInfected = 1
# 治愈者随时间变化的列表
Removed_list = NULL
# 感染者随时间变化的列表
infected_list = NULL
# 用来为每个结点的潜伏期时间计数
TimeLine_Infected = NULL
# 用来为每个结点的治愈期时间计数（预计用于带隔离项的模拟，此处暂时未使用）
TimeLine_Removed = NULL
