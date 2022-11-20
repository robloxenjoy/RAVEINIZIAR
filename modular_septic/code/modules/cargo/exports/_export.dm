/**
 * Code for the commodity price variation was based mostly on this article:
 * https://towardsdatascience.com/how-to-simulate-a-stock-market-with-less-than-10-lines-of-python-code-5de9336114e5
 */
/datum/export
	/// Previous cost, for the sake of checking whether the cost has gone up or down since last update
	var/previous_cost
	/// Maximum price this export can ever reach, set to null to generate automatically
	var/maximum_cost
	/// Minimum price this export can ever reach, 0 or below WILL create infinite money exploits
	var/minimum_cost = 1 CENTS
	/// Important information for graphing out an export
	var/list/cost_history = list()
	/// Standard deviation of price variation, which uses normal distribution
	var/standard_deviation = 0.01
	/// Mean of price variation, which uses normal distribution
	var/mean = 0.001
	/// Should this export be invisible to the cargo export console?
	var/secret = FALSE

/datum/export/New()
	. = ..()
	previous_cost = cost
	if(isnull(maximum_cost))
		if(cost >= 1 DOLLARS)
			maximum_cost = cost ** DEFAULT_MAXIMUM_COST_EXPONENT
		else
			maximum_cost = cost * 2
	minimum_cost = max(1 CENTS, minimum_cost)
	START_PROCESSING(SSmarket, src)

/datum/export/Destroy()
	. = ..()
	STOP_PROCESSING(SSmarket, src)

/datum/export/process(delta_time)
	previous_cost = cost
	if(k_elasticity)
		cost = min(init_cost, cost * NUM_E**(k_elasticity * (1/30)))
	else if(standard_deviation)
		cost = round_to_nearest(clamp(cost*(1+gaussian(mean, standard_deviation)), minimum_cost, maximum_cost), 1 CENTS)
	LAZYINITLIST(cost_history)
	cost_history += cost
	/// We update every 30 seconds, so each graph gives us a view of the last 30 minutes if possible
	while(length(cost_history) > EXPORT_GRAPH_DEPTH)
		cost_history.Cut(1, 2)
	if(!k_elasticity && !standard_deviation)
		return PROCESS_KILL
