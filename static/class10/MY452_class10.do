// MY452_class10.do / PB, 23.3.2018
// MY452: Stata commands for class 10 (Review session)
//
// To use these commands 
//	(1) Open this file in Stata: 
//		From the menu: Window/Do-File Editor/New Do-file, and 
//			find and select this file (MY452_class10.do)
//	(2) To run individual commands or blocks of commands:
//		- higlight them in this file
//		- select Tools/Do from the menu of this (or press ctrl+D)
//
// Note: // denotes a comment, and anything after it is ignored; see help comments
//
// 0. 
// Open the data file 
//		ANES2016.dta
// using the menu File/Open

// 1. 
// Descriptive statistics of dataset: post-election survey for 2016 US election
codebook

// 2. Visualization of the main DV and IV
hist therm_trump // Trump feeling thermometer
hist animus // Index of racial resentment

// Index is computed using the following items:
// 1) V162211 Agree/disagree: blacks shd work way up w/o special favors
// 2) V162212 Agree/disagree: past slavery make more diff for blacks
// 3) V162213 Agree/disagree: blacks have gotten less than deserve
// 4) V162214 Agree/disagree: blacks must try harder to get ahead

// 3. First regression
reg therm_trump animus [pweight=weight]

// How do we interpret the coefficient?
// Can we make a causal interpretation?

// 4. Predict thermometer for someone with animus equal to 4, 10, and 20
margins, at(animus=(4 10 20))

// 5. Adding control variables
reg therm_trump animus education age female pid ///
	moral_traditionalism i.race [pweight=weight]

// how do we interpret these results?
// how does the coefficient for animus change and what does that mean?

// 6. Adding an interaction with college degree
reg therm_trump c.animus##i.college [pweight=weight]
 
margins, at(animus=(4) college=(0 1))
margins, at(animus=(15) college=(0 1))

// 7. Logit models of vote for Trump
logit vote_trump age [pweight=weight]
logit vote_trump age [pweight=weight], or
// how do we interpret these coefficients?

quietly margins, at (age=(18(1)80))
marginsplot
// what does the plot mean?

// 8. Adding one control variable: moral traditionalism
// Computed using the following items:
// V162207 Agree/disagree: world is changing and we should adjust
// V162208 Agree/disagree: newer lifestyles breaking down society
// V162209 Agree/disagree: be more tolerant of other moral stds
// V162210 Agree/disagree: more emphasis on traditional family values

logit vote_trump age moral_traditionalism [pweight=weight]
quietly margins, at (age=(18(1)80) (mean) moral_traditionalism )
marginsplot

// why did it change?


// 9. Full logit model with all control variables
logit vote_trump age moral_traditionalism education female pid ///
	i.race [pweight=weight]
	
quietly margins, at(age=(18(1)80) (mean) moral_traditionalism education pid ///
	female=1 race=1)
marginsplot
// how do we make sense of this result?





