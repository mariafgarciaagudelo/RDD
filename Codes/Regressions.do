clear all
set more off

local usuario=c(username)

if "`usuario'"=="maria" {
	global Created "C:\Users\maria\Documents\GitHub\RDD\Created"
	global Graphs "C:\Users\maria\Documents\GitHub\RDD\Graphs"
	global Regressions  "C:\Users\maria\Documents\GitHub\RDD\Regression"
	}

	
// Use the data
use "https://github.com/scunning1975/causal-inference-class/raw/master/hansen_dwi.dta", clear
gen BAC_dummy=(bac1>= 0.08 )

//Test de Macry
net install rddensity, from(https://sites.google.com/site/rdpackages/rddensity/stata) replace
net install lpdensity, from(https://sites.google.com/site/nppackages/lpdensity/stata) replace

rddensity bac1, c(0.08) plot
DCdensity  bac1 if ( bac1>0.08), breakpoint(0) generate(Xj Yj r0 fhat se_fhat)

//Histogram
hist bac1, freq bin(1000) bcolor(edkblue) graphregion(color(white)) bgcolor(white) plot(scatteri 0 0.08 2000 0.08, recast(line)) legend(off) xtitle("BAC")
graph export "$Graphs\Histogram1.png", as(png) replace


