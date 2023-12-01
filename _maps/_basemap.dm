//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\Mining\Lavaland.dmm"
		#include "map_files\debug\runtimestation.dmm"
		#include "map_files\debug\multiz.dmm"
		#include "map_files\Deltastation\DeltaStation2.dmm"
		#include "map_files\KiloStation\KiloStation.dmm"
		#include "map_files\MetaStation\MetaStation.dmm"
		#include "map_files\IceBoxStation\IceBoxStation.dmm"
		#include "map_files\tramstation\tramstation.dmm"
		#include "_septic\map_files\Baluarte\Baluarte.dmm"
		#include "_septic\map_files\Combat\Combat.dmm"
		#include "_septic\map_files\Polovich\Polovich.dmm"
		#include "_septic\map_files\Gringo\Gringo.dmm"
		#include "_septic\map_files\Breaker\Breaker.dmm"
		#include "_septic\map_files\SpaceBoxStation\SpaceBoxStation.dmm"

		#ifdef CIBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
