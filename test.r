library(spEDM)
npp = terra::rast(system.file("extdata/npp.tif", package = "spEDM"))
npp = terra::aggregate(npp, fact = 3, na.rm = TRUE)
nnamat = terra::as.matrix(!is.na(npp[[1]]), wide = TRUE)
nnaindice = terra::rowColFromCell(npp,which(nnamat))
set.seed(42)
indices = sample(nrow(nnaindice), size = 3000, replace = FALSE)
lib = nnaindice[-indices,]
pred = nnaindice[indices,]
startTime = Sys.time()
npp_res = gccm(data = npp,cause = "pre",effect = "npp",libsizes = seq(10,130,5),
               E = c(2,6), k = 5, pred = pred, progressbar = TRUE,threads = 32)
endTime = Sys.time()
print(difftime(endTime,startTime, units ="mins"))
npp_res
plot(npp_res,xlimits = c(9, 101),ylimits = c(-0.05,1))

