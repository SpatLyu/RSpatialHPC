columbus = sf::read_sf(system.file("shapes/columbus.gpkg", package="spData"))
g = spEDM::gccm(columbus,"HOVAL","CRIME",libsizes = seq(5,40,5),E = 6)