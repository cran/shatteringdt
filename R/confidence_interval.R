#' Calculates the confidence interval for the dataset.
#'
#' @description Calculates # of samples needed to ensure learning with,
#' a certain confidence interval simulated.
#'
#' @param rpart.tree rpart.tree. A Decision tree generated by rpart package.
#' @param epsilon float. The epsilon to be used in the delta calculation.
#' @param max_confidence int. The maximum confidence to achieve in 0.01 steps length.
#'
#' @usage confidence_interval(rpart.tree, epsilon, max_confidence)
#'
#' @return No return value, the function plot the confidence interval values.
#'
#' @export confidence_interval
confidence_interval <- function(rpart.tree, epsilon=.05, max_confidence=.2){
    delta_confidence = NULL
    n_confidence_samples = NULL
    shattering_confidence = NULL

    for (epsilon in seq(0.05, max_confidence, by=0.01)){
        n_samples = 1
        delta = epsilon+0.01

        ret = search_delta_n_samples(rpart.tree, n_samples, delta, epsilon)
        delta = ret$delta
        n_samples = ret$n_samples

        delta_confidence <- c(delta_confidence, 1-epsilon)
        n_confidence_samples <- c(n_confidence_samples, n_samples)
    }

    plot(delta_confidence, n_confidence_samples, ylab="# of samples", xlab="Confidence interval (%)",
         main="Number of samples needed to ensure learning given a confidence interval value", type="l")
}
