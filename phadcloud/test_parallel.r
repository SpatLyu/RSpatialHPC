library(spEDM)
npp = terra::rast(system.file("extdata/npp.tif", package = "spEDM"))
npp = terra::aggregate(npp, fact = 3, na.rm = TRUE)
nnamat = terra::as.matrix(npp[[1]], wide = TRUE)
nnaindice = which(!is.na(nnamat), arr.ind = TRUE)
set.seed(42)
indices = sample(nrow(nnaindice), size = 1500, replace = FALSE)
lib = nnaindice[-indices,]
pred = nnaindice[indices,]

startTime = Sys.time()
npp_res = gccm(data = npp,cause = "pre",effect = "npp",libsizes = seq(100,1500,100),
               E = c(2,6), k = 5, lib= pred, pred = pred, progressbar = TRUE)
endTime = Sys.time()
print(difftime(endTime,startTime, units ="mins"))
npp_res

startTime = Sys.time()
g = spEDM::gccm(data = npp,
            cause = "pre",
            effect = "npp",
            libsizes = as.matrix(expand.grid(seq(10,130,10),seq(10,160,10))),
            E = c(2,6),
            k = 5,
            lib = nnaindice,
            pred = pred,
            trend.rm = TRUE,
            progressbar = TRUE)
endTime = Sys.time()
print(difftime(endTime,startTime, units ="mins"))
g