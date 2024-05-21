# https://www.desmos.com/calculator/sbya2gb5pi
#' @export
exp = new.env()
#' @export
level = new.env()

# Erratic
#' @title Erratic
#' @description This function calculates the erratic experience points for a given level. The erratic experience group requires 600,000 experience points to reach level 100.
#' @param n The level for which to calculate the experience points.
#' @param flux A logical value indicating whether to use the flux calculation.
#' @return The calculated experience points.
#' @importFrom dplyr case_when
#' @export
exp$erratic <- function(n, flux = FALSE) {
	if(any(n<0))warning("Negative values passed, negative values will be returned")
	case_when(
		# (x^{3}*(100-x))/50\left\{0<x<50\right\}
		n < 50 ~ (n^3 * (100 - n)) / 50,
		# (x^{3}*(150-x))/100\left\{50\le x<68\right\}
		n < 68 ~ (n^3 * (150 - n)) / 100,
		# (x^{3}*\operatorname{floor}((1911-10*x)/3))/500\left\{68\le x<98\right\}
		n < 98 ~ (n^3 * floor((1911 - 10 * n) / 3)) / 500,
		# (x^{3}*(160-x))/100\left\{98\le x<110\right\}
		(!flux | n < 110) ~ (n^3 * (160 - n)) / 100,
		# (x^{2}*(x+165))/5\left\{110\le x\right\}
		TRUE ~ n^2 * (n + 165) / 5
	)
}

# Level Erratic
#' @title Level Erratic
#' @description This function calculates the level for a given amount of erratic experience points.
#' @param e The amount of experience points.
#' @param flux A logical value indicating whether to use the flux calculation.
#' @return The calculated level.
#' @importFrom stats uniroot
#' @export
level$erratic <- function(e, flux = FALSE) {
	# Define the ranges for each piece of the function
	ranges <- list(c(0, 50), c(50, 68), c(68, 98), c(98, 110), c(110, 10^256))

	# Find the range where e falls
	for (range in ranges) {
		if (e >= exp$erratic(range[1], flux) && e <= exp$erratic(range[2], flux)) {
			# Use uniroot to find the root of the function erratic(n) - e
			root <- uniroot(function(n) exp$erratic(n, flux) - e, range)
			return(floor(root$root))
		}
	}

	# Return NA if no solution was found
	return(NA)
}

# Fast
#' @title Fast
#' @description This function calculates the fast experience points for a given level. The fast experience group requires 800,000 experience points to reach level 100.
#' @param n The level for which to calculate the experience points.
#' @return The calculated experience points.
#' @export
exp$fast <- function(n) {
	if(any(n<0))warning("Negative values passed, negative values will be returned")
	return((4 * n^3) / 5)
}

# Level Fast
#' @title Level Fast
#' @description This function calculates the level for a given amount of fast experience points.
#' @param e The amount of experience points.
#' @return The calculated level.
#' @export
level$fast <- function(e) {
	if(any(e<0))warning("Negative values passed, negative values will be returned")
	floor(((5 * e) / 4)^(1/3))
}

# Medium Fast
#' @title Medium Fast
#' @description This function calculates the medium fast experience points for a given level. The medium fast experience group requires 1,000,000 experience points to reach level 100.
#' @param n The level for which to calculate the experience points.
#' @return The calculated experience points.
#' @export
exp$medium_fast <- function(n) {
	if(any(n<0))warning("Negative values passed, negative values will be returned")
	return(n^3)
}

# Level Medium Fast
#' @title Level Medium Fast
#' @description This function calculates the level for a given amount of medium fast experience points.
#' @param e The amount of experience points.
#' @return The calculated level.
#' @export
level$medium_fast <- function(e) {
	if(any(e<0))warning("Negative values passed, negative values will be returned")
	floor(e^(1/3))
}

# Medium Slow
#' @title Medium Slow
#' @description This function calculates the medium slow experience points for a given level. The medium slow experience group requires 1,059,860 experience points to reach level 100.
#' @param n The level for which to calculate the experience points.
#' @return The calculated experience points.
#' @importFrom dplyr case_when
#' @export
exp$medium_slow <- function(n){
	if(any(n<0))warning("Negative values passed, negative values will be returned")
	case_when(
		0<=n & n<2 ~ 9*n,
		TRUE ~ (6/5) * n^3 - 15 * n^2 + 100 * n - 140
	)
}

# Level Medium Slow
#' @title Level Medium Slow
#' @description This function calculates the level for a given amount of medium slow experience points.
#' @param e The amount of experience points.
#' @return The calculated level.
#' @importFrom stats uniroot
#' @export
level$medium_slow <- function(e) {
	# Define the ranges for each piece of the function
	ranges <- list(c(0, 2), c(2, 10^256))

	# Find the range where e falls
	for (range in ranges) {
		if (e >= exp$medium_slow(range[1]) && e <= exp$medium_slow(range[2])) {
			# Use uniroot to find the root of the function medium_slow(n) - e
			root <- uniroot(function(n) exp$medium_slow(n) - e, range)
			return(floor(root$root))
		}
	}

	# Return NA if no solution was found
	return(NA)
}

# Slow
#' @title Slow
#' @description This function calculates the slow experience points for a given level. The slow experience group requires 1,250,000 experience points to reach level 100.
#' @param n The level for which to calculate the experience points.
#' @return The calculated experience points.
#' @export
exp$slow <- function(n){
	if(any(n<0))warning("Negative values passed, negative values will be returned")
	(5 * n^3) / 4
}

# Level Slow
#' @title Level Slow
#' @description This function calculates the level for a given amount of slow experience points.
#' @param e The amount of experience points.
#' @return The calculated level.
#' @export
level$slow <- function(e) {
	if(any(e<0))warning("Negative values passed, negative values will be returned")
	floor(((4 * e) / 5)^(1/3))
}


# Fluctuating
#' @title Fluctuating
#' @description This function calculates the fluctuating experience points for a given level. The fluctuating experience group requires 1,640,000 experience points to reach level 100.
#' @param n The level for which to calculate the experience points.
#' @param flux A logical value indicating whether to use the flux calculation.
#' @return The calculated experience points.
#' @importFrom dplyr case_when
#' @export
exp$fluctuating <- function(n, flux = FALSE) {
	if(any(n<0))warning("Negative values passed, negative values will be returned")
	# (x^{3}*(\operatorname{floor}((x+1)/3)+24))/50\left\{1\le x<15\right\}
	case_when(
		n < 15 ~ (n^3 * (floor((n + 1) / 3) + 24)) / 50,
		# (x^{3}*(x+14))/50\left\{15\le x<36\right\}
		n < 36 ~ (n^3 * (n + 14)) / 50,
		# (x^{3}*(\operatorname{floor}(x/2)+32))/50\left\{36\le x<100\right\}
		(!flux | n < 100) ~(n^3 * (floor(n / 2) + 32)) / 50,
		# (x^{3}*(\operatorname{floor}(x/4)+57))/50\left\{100\le x\right\}
		TRUE ~ (n^3 * (floor(n / 4) + 57)) / 50
	)
}

# Level Fluctuating
#' @title Level Fluctuating
#' @description This function calculates the level for a given amount of fluctuating experience points.
#' @param e The amount of experience points.
#' @param flux A logical value indicating whether to use the flux calculation.
#' @return The calculated level.
#' @importFrom stats uniroot
#' @export
level$fluctuating <- function(e, flux = FALSE) {
	# Define the ranges for each piece of the function
	ranges <- list(c(0, 15), c(15, 36), c(36, 100), c(100, 10^256))

	# Find the range where e falls
	for (range in ranges) {
		if (e >= exp$fluctuating(range[1], flux) && e <= exp$fluctuating(range[2], flux)) {
			# Use uniroot to find the root of the function fluctuating(n) - e
			root <- uniroot(function(n) exp$fluctuating(n, flux) - e, range)
			return(floor(root$root))
		}
	}

	# Return NA if no solution was found
	return(NA)
}


# Calculates the difference of exp between levels
#' @title Difference of Experience Points
#' @description This function calculates the difference of experience points between two levels.
#' @param a The starting level.
#' @param b The ending level. If not specified, it defaults to a+1.
#' @param fun The function to use for the calculation. It defaults to exp$slow.
#' @return The difference of experience points between the two levels.
#' @export
exp$dif <- function(a,b = a+1,fun = exp$slow){
	if(any(a>b))warning("a>b, Negative values will be returned")
	return(fun(b)-fun(a))
}

# Calculates the exp for the next level
#' @title Experience Points to Next Level
#' @description This function calculates the experience points required to reach the next level.
#' @param lvl The current level.
#' @param exp The current experience points.
#' @param fun The function to use for the calculation. It defaults to exp$slow.
#' @return The experience points required to reach the next level.
#' @export
level$toNext <- function(lvl, exp = 0, fun = exp$slow){
	exp$dif(lvl, fun = fun) - exp
}

# Level Up
#' @title Level Up
#' @description This function calculates the new level and remaining experience points after gaining a certain amount of experience.
#' @param lvl The current level.
#' @param e The amount of experience points gained.
#' @param fun The function to use for the calculation. It defaults to exp$slow.
#' @param inv The inverse function to use for the calculation. It defaults to the inverse of the fun function.
#' @return A list containing the new level and the remaining experience points.
#' @importFrom stats uniroot
#' @importFrom stringr str_remove
#' @importFrom base get
#' @export
level$up = function(
		lvl,
		e,
		fun = exp$slow,
		inv = get(str_remove(deparse(substitute(fun)), "^[^$]+\\$"), envir = level)
){
	cur_exp = fun(lvl)
	new_lvl = inv(cur_exp+e)
	rem_exp = cur_exp+e - fun(new_lvl)
	list(level = new_lvl, exp = rem_exp)
}

# Lock the environment
lockEnvironment(exp, bindings = TRUE)
lockEnvironment(level, bindings = TRUE)
