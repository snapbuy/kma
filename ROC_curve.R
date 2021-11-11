simple_roc <- function(labels, scores){
  labels <- labels[order(scores, decreasing=TRUE)]
  data.frame(TPR=cumsum(labels)/sum(labels), FPR=cumsum(!labels)/sum(!labels), labels)
}

set.seed(1)
sim_widget_data <- function(N, noise=100){
  x <- runif(N, min=0, max=100)
  y <- 122 - x/2 + rnorm(N, sd=noise)
  bad_widget <- factor(y > 100)
  data.frame(x, y, bad_widget)
}
widget_data <- sim_widget_data(500, 10)
test_set_idx <- sample(1:nrow(widget_data), size=floor(nrow(widget_data)/4))
test_set <- widget_data[test_set_idx,]
training_set <- widget_data[-test_set_idx,]
library(ggplot2)
library(dplyr)
test_set %>% 
  ggplot(aes(x=x, y=y, col=bad_widget)) + 
  scale_color_manual(values=c("black", "red")) + 
  geom_point() + 
  ggtitle("Bad widgets related to x")



fit_glm <- glm(bad_widget ~ x, training_set, family=binomial(link="logit"))
glm_link_scores <- predict(fit_glm, test_set, type="link")
glm_response_scores <- predict(fit_glm, test_set, type="response")
score_data <- data.frame(link=glm_link_scores, 
                         response=glm_response_scores,
                         bad_widget=test_set$bad_widget,
                         stringsAsFactors=FALSE)
score_data %>% 
  ggplot(aes(x=link, y=response, col=bad_widget)) + 
  scale_color_manual(values=c("black", "red")) + 
  geom_point() + 
  geom_rug() + 
  ggtitle("Both link and response scores put cases in the same order")



library(pROC)
plot(roc(test_set$bad_widget, glm_response_scores, direction="<"),
     col="yellow", lwd=3, main="The turtle finds its way")
## 
## Call:
## roc.default(response = test_set$bad_widget, predictor = glm_response_scores,     direction = "<")
## 
## Data: glm_response_scores in 59 controls (test_set$bad_widget FALSE) < 66 cases (test_set$bad_widget TRUE).
## Area under the curve: 0.9037
glm_simple_roc <- simple_roc(test_set$bad_widget=="TRUE", glm_link_scores)
with(glm_simple_roc, points(1 - FPR, TPR, col=1 + labels))



set.seed(1)
N <- 2000
P <- 0.01
rare_success <- sample(c(TRUE, FALSE), N, replace=TRUE, prob=c(P, 1-P))
guess_not <- rep(0, N)
plot(roc(rare_success, guess_not), print.auc=TRUE)
## 
## Call:
## roc.default(response = rare_success, predictor = guess_not)
## 
## Data: guess_not in 1978 controls (rare_success FALSE) < 22 cases (rare_success TRUE).
## Area under the curve: 0.5
simp_roc <- simple_roc(rare_success, guess_not)
with(simp_roc, lines(1 - FPR, TPR, col="blue", lty=2))