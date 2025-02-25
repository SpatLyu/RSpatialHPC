library(spEDM)
npp = terra::rast(system.file("extdata/npp.tif", package = "spEDM"))

nnamat = terra::as.matrix(!is.na(npp[[1]]), wide = TRUE)
nnaindice = terra::rowColFromCell(npp,which(nnamat))

set.seed(42)
indices = sample(nrow(nnaindice), size = 3000, replace = FALSE)
lib = nnaindice[-indices,]
pred = nnaindice[indices,]

simplex(npp,"pre",lib,pred,k = 5)
simplex(npp,"npp",lib,pred,k = 5)

startTime = Sys.time()
npp_res = gccm(data = npp,cause = "pre",effect = "npp",libsizes = seq(20,400,20),
               E = c(7,10), k = 5, pred = pred, progressbar = TRUE,threads = 96)
endTime = Sys.time()
print(difftime(endTime,startTime, units ="mins"))

npp_res

readr::write_rds(npp_res, "./result/npp_res.rds")