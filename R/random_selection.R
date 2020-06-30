#' Randomly decide whether this node be infected
#'
#' Randomly decide whether it will infect the target node
#' use sample(c(1, 0), 1, prob = ) for every incoming link.
#' If it will be infected then return 1, otherwise return 0.
#' Finally, add the return value of each incoming link to
#' find out if this node will be infected.
#'
#' @param freq int, the number of incoming links
#' @param Inf_porb vector, the probility vector of inf_rate and 1-inf_rate
#'
#' @return results, int
#' @export
#'
#' @examples random_selection(4, c(0.12, 0.88))
random_selection = function(freq, Inf_porb) {
  # 储存每条传入感染链接的随机感染结果
  every_selection = NULL
  # 遍历每条传入感染链接
  for (i in 1:freq)
    # 按照指定概率向量随机取样，感染返回 1，否则返回 0
    every_selection[i] = sample(c(1, 0), 1, prob = Inf_porb)
  # 加总所有链接的返回值，并返回
  results = sum(every_selection)
  return (results)
}
