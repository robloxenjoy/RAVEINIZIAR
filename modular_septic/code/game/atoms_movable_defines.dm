/atom/movable
	/**
	 * The minimum Strength required to use the weapon properly.
	 * If you try to use a weapon that requires more ST than you have,
	 * you will be at -1 to weapon skill per point of ST you lack.
	 */
	var/minimum_strength = 10
	/**
	 * Maximum strength amount for the purposes of damage calculations
	 */
	var/maximum_strength = ATTRIBUTE_MAX

	/// Thrown damage can vary from min_throwforce to throwforce when attacking, regardless of stats
	var/min_throwforce
	/// Minimum bound for the throwforce increase we get per point of strength
	var/min_throwforce_strength = 0
	/// Maximum bound for the throwforce increase we get per point of strength
	var/throwforce_strength = 0
	/// Maximum final throwforce we can reach EVER, regardless of stats
	var/max_throwforce = 100
