/obj
	/// Damage can vary from min_force to force, when attacking, regardless of stats
	var/min_force
	/// Minimum bound for the force increase we get per point of strength
	var/min_force_strength = 0
	/// Maximum bound for the force increase we get per point of strength
	var/force_strength = 0
	/// Maximum final force we can reach EVER, regardless of stats
	var/max_force = 100
	/// How good a given object is at causing organ damage on carbons. Higher values equal better shots at creating serious organ damage.
	var/organ_bonus = 0
	/// If this attacks a human with no organ armor on the affected body part, add this to the organ mod. Some attacks may be significantly worse at organ damage if there's even a slight layer of armor to absorb some of it vs bare flesh.
	var/bare_organ_bonus = 0
