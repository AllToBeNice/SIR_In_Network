#' Randomly decide whether this node be infected of removed
#'
#' Infection: Randomly decide whether it will infect the target node
#' use sample(c(1, 0), 1, prob = ) for every incoming link.If it will
#' be infected then return 1, otherwise return 0.Finally, add the
#' return value of each incoming link to find out if this node will
#' be infected.
#' Removed: Randomly decide whether the target node will be removed
#' from infected queue. This is a special condition with freq == 1
#'
#' @param freq int, the number of incoming links(removed: freq == 1)
#' @param vec_porb vector, the probility vector of vec_rate and 1-vec_rate
#'
#' @return results, int
#' @export

#' @examples
#' random_selection(4, c(0.12, 0.88))
random_selection = function(freq, vec_porb) {
  # 感染：储存每条传入感染链接的随机感染结果
  # 移除：储存决定是否移除的值
  every_selection = NULL
  # 感染：遍历每条传入感染链接
  # 移除：freq == 1
  for (i in 1:freq)
    # 按照概率向量随机取样，感染返回 1，否则返回 0
    every_selection[i] = sample(c(1, 0), 1, prob = vec_porb)
  # 加总所有链接的返回值，并返回
  results = sum(every_selection)
  return (results)
}
