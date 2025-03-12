library(spEDM)
npp = terra::rast(system.file("extdata/npp.tif", package = "spEDM"))
npp = terra::aggregate(npp, fact = 3, na.rm = TRUE)
nnamat = terra::as.matrix(npp[[1]], wide = TRUE)
nnaindice = which(!is.na(nnamat), arr.ind = TRUE)
set.seed(2025)
indices = sample(nrow(nnaindice), size = 1500, replace = FALSE)
libindice = nnaindice[-indices,]
predindice = nnaindice[indices,]

startTime = Sys.time()
g = spEDM::gccm(data = npp,
            cause = "pre",
            effect = "npp",
            libsizes = as.matrix(expand.grid(seq(10,130,10),seq(10,160,10))),
            E = c(2,10),
            k = 8,
            lib = nnaindice,
            pred = predindice,
            progressbar = TRUE)
endTime = Sys.time()
print(difftime(endTime,startTime, units ="mins"))
g

startTime = Sys.time()
npp_res1 = gccm(data = npp,cause = "pre",effect = "npp",libsizes = seq(100,1500,100),
                E = c(4,6), k = 5, lib= predindice, pred = predindice, progressbar = TRUE)
endTime = Sys.time()
print(difftime(endTime,startTime, units ="mins"))

startTime = Sys.time()
npp_res2 = gccm(data = npp,cause = "pre",effect = "npp",libsizes = seq(100,1500,100), E = c(4,6), k = 5, 
                lib= predindice, pred = predindice, parallel.level = "high",progressbar = TRUE)
endTime = Sys.time()
print(difftime(endTime,startTime, units ="mins"))

npp_res1
npp_res2