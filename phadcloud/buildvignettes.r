setwd('./spEDM-2.0')

.prebuild_vignettes = \(name){
  out = paste0("vignettes/",name,".Rmd")
  inp = paste0(out,".orig")
  knitr::knit(inp,out)
}
.prebuild_vignettes("GCMC")