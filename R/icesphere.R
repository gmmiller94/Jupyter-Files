#vector is name=c(numbers)
icesphere_weight = c(0.96, 1.51, 2.17, 3.85, 4.45, 6.02)

#function is name=function(x){formula}
diam = function(icesphere){(2/2.54) * (icesphere/(0.92) * (4/3) * (pi) )^1/3}

#loop is for (x in vector){generic function name=functionname(x) cat()}
for (icesphere in icesphere_weight){
  diameter = diam(icesphere)
  cat( "for an ice sphere with a", icesphere, "weight, had a", diameter, "diameter\n")
}

