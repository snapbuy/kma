confusionLabel <- function(model, # placeholder, not yet implemented
                           obs,  # vector of observed 0 and 1 values
                           pred, # vector of predicted probabilities
                           thresh) # threshold to separate predictions
{
  if (length(obs) != length(pred)) stop("'obs' and 'pred' must be of the same length (and in the same order)")
  res <- rep("", length(obs))
  res[pred >= thresh & obs == 1] <- "TruePos"
  res[pred < thresh & obs == 0] <- "TrueNeg"
  res[pred >= thresh & obs == 0] <- "FalsePos"
  res[pred < thresh & obs == 1] <- "FalseNeg"
  res
}


confusionLabel(obs = myspecies_presabs, pred = myspecies_P, thresh = 0.23)

