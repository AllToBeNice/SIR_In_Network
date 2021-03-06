% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_time_series.R
\name{plot_time_series}
\alias{plot_time_series}
\title{Plot Images by time series}
\usage{
plot_time_series(Var_Param, total_time)
}
\arguments{
\item{Var_Param}{List, saved important var and params}

\item{total_time}{Int, the number of passed times}
}
\description{
Plot daily proportion of infected and
daily increased proportion of infected by time series.
}
\examples{
Var_Param <- set_param("Random Network", c(0.2), 10, 70, 1, 0, 0.12, 0.4, 7)
infected = sample(igraph::V(Var_Param$Network$graph), Var_Param$I)
Var_Param$Infected_list[[1]] = infected
plot_time_series(Var_Param, 1)
}
