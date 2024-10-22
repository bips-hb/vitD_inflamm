
***Forest plot for BMI categories***

import excel "D:\PROGS\STATA\VitD_inflamm\Data\Extra tables.xlsx", sheet("stratified by BMI") firstrow clear

label variable inflammtorymarkers "Inflammatory markers"

metan normal lci1 uci1, lcols(inflammtorymarkers) rcols () textsize(100) xlabel(-0.30, -0.20, -0.10, 0, 0.10, 0.2) nowt nooverall nobox nostats nohet force astext (40)  graphregion(fcolor(white)) xtitle("Children with normal weight") note (β (95% CI))
graph save Graph "D:\PROGS\STATA\VitD_inflamm\Graphs\forestplot_normalwt.gph", replace



metan obese lci2 uci2, lcols(inflammtorymarkers) rcols () textsize(100) xlabel(-0.30, -0.20, -0.10, 0, 0.10, 0.2) nowt nooverall nobox nostats nohet force astext (40)  graphregion(fcolor(white)) xtitle("Children with overweight/obesity") note (β (95% CI))
graph save Graph "D:\PROGS\STATA\VitD_inflamm\Graphs\forestplot_obese.gph", replace
