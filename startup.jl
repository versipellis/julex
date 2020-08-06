pwd()
cd("./Julex/")
pwd()
using Pkg
#Pkg.activate(".")
pkg"activate ."
pkg"st"
using Genie
Genie.loadapp()
Genie.startup()
