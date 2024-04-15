/// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
/// !!!!!!!!!!HEY LISTEN!!!!!!!!!!!!!!!!!!!!!!!!
/// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

// If you modify this file you ALSO need to modify code/modules/goonchat/browserAssets/browserOutput.css and browserOutput_white.css
// BUT you have to use PX font sizes with are on a x8 scale of these font sizes
// Sample font-size: DM: 8 CSS: 64px

/client/script = {"<style>
body					{font-family: "Eurostile Round Extended Medium";}

h1, h2, h3, h4, h5, h6	{color: #a4a4a4;	font-family: "Eurostile Round Extended Medium";}

em						{font-style: normal;	font-weight: bold;}

.motd					{color: #638500;	font-family: "Eurostile Round Extended Medium";}
.motd h1, .motd h2, .motd h3, .motd h4, .motd h5, .motd h6
	{color: #638500;	text-decoration: underline;}
.motd a, .motd a:link, .motd a:visited, .motd a:active, .motd a:hover
	{color: #638500;}

.italics				{					font-style: italic;}

.bold					{					font-weight: bold;}

.grayd {color: #8c8c8c;}

.prefix					{					font-weight: bold;}
.oocplain				{}
.warningplain			{}
.ooc					{					font-weight: bold;}
.adminobserverooc		{color: #0099cc;	font-weight: bold;}
.adminooc				{color: #700038;	font-weight: bold;}

.adminsay				{color:	#FF4500;	font-weight: bold;}
.admin					{color: #386aff;	font-weight: bold;}

.name					{					font-weight: bold;}

.say					{color: #939277;}
.deadsay				{color: #5c00e6;}
.binarysay				{color: #20c20e;	background-color: #000000;}
.binarysay a			{color: #00ff00;}
.binarysay a:active, .binarysay a:visited {color: #88ff88;}
.radio					{color: #008000;}

.sciradio				{color: #993399;}
.comradio				{color: #948f02;}
.secradio				{color: #a30000;}
.medradio				{color: #337296;}
.engradio				{color: #fb5613;}
.suppradio				{color: #a8732b;}
.servradio				{color: #6eaa2c;}
.syndradio				{color: #6d3f40;}
.centcomradio			{color: #686868;}
.aiprivradio			{color: #ff00ff;}
.redteamradio			{color: #ff0000;}
.blueteamradio			{color: #4f6e73;}
.greenteamradio			{color: #00ff00;}
.yellowteamradio		{color: #d1ba22;}
.gangradio				{color: #ac2ea1;}

.yell					{color: #b39277;	font-weight: bold;}

.alert					{color: #e09579;}
h1.alert, h2.alert		{color: #5a005a;}

.emote					{}
.lowpain				{color: #a4a562;}
.lowestpain				{color: #a4a562; font-size: 85%;}
.artery					{color: #9B5455;}
.userdanger				{color: #ba55d3; font-size: 110%;}
.boned				    {color: #F6ECBE; font-size: 110%;}
.evilblack				{color: #930000;}
.bolddanger 			{color: #c51e1e; font-weight: bold;}
.pinkdang 				{color: #c2006b; font-weight: bold;}
.bigdanger				{color: #c51e1e; font-size: 140%;}
.steal					{color: #3a1b4e;}
.bobux					{color: #e86e0a; font-size: 3;}
.danger					{color: #930000;}
.cyanicdream			{color: #1ad06f;}
.infection				{color: #77c72b;}
.necrosis				{color: #497a1a;}
.dead					{color: #b280df;}
.bloody					{color: #cc0f0f;}
.shitty					{color: #815131;}
.cummy					{color: #fffae8;}
.femcummy				{color: #fffcf0;}
.tinydanger				{color: #930000; font-size: 85%;}
.smalldanger			{color: #930000; font-size: 90%;}
.warning				{color: #930000; font-style: italic;}
.boldwarning			{color: #930000; font-style: italic; font-weight: bold}
.announce				{color: #228b22;	font-weight: bold;}
.boldannounce			{color: #930000;	font-weight: bold;}
.minorannounce			{					font-weight: bold;  font-size: 3;}
.greenannounce			{color: #00ff00;	font-weight: bold;}
.rose					{color: #ff5050;}
.info					{color: #7c6fc9;}
.notice					{color: #718fa6;}
.tinynotice				{color: #718fa6; font-size: 85%;}
.tinynoticeital			{color: #718fa6; font-style: italic; font-size: 85%;}
.smallnotice			{color: #718fa6; font-size: 90%;}
.smallnoticeital		{color: #718fa6; font-style: italic;	font-size: 90%;}
.boldnotice				{color: #718fa6; font-weight: bold;}
.hear					{color: #718fa6; font-style: italic;}
.adminnotice			{color: #4f6e73;}
.adminhelp				{color: #ff0000;	font-weight: bold;}
.unconscious			{color: #916f9a;	font-weight: bold;}
.suicide				{color: #ff5050;	font-style: italic;}
.green					{color: #03ff39;}
.red					{color: #FF0000;}
.blue					{color: #4f6e73;}
.yellow					{color: #d9d200;}
.white					{color: rgb(199, 199, 199);}
.nicegreen				{color: #14a833;}
.cult					{color: #973e3b;}
.cultlarge				{color: #973e3b;	font-weight: bold;	font-size: 3;}
.narsie					{color: #973e3b;	font-weight: bold;	font-size: 15;}
.narsiesmall			{color: #973e3b;	font-weight: bold;	font-size: 6;}
.colossus				{color: #7F282A;	font-size: 5;}
.hierophant				{color: #660099;	font-weight: bold;	font-style: italic;}
.hierophant_warning		{color: #660099;	font-style: italic;}
.purple					{color: #5e2d79;}
.holoparasite			{color: #35333a;}
.bounty					{color: #ab6613;	font-style: italic;}

.revennotice			{color: #1d2953;}
.revenboldnotice		{color: #1d2953;	font-weight: bold;}
.revenbignotice			{color: #1d2953;	font-weight: bold;	font-size: 3;}
.revenminor				{color: #823abb}
.revenwarning			{color: #760fbb;	font-style: italic;}
.revendanger			{color: #760fbb;	font-weight: bold;	font-size: 3;}

.sentientdisease		{color: #446600;}

.deconversion_message	{color: #5000A0;	font-size: 3;	font-style: italic;}

.ghostalert				{color: #5c00e6;	font-style: italic;	font-weight: bold;}

.alien					{color: #543354;}
.noticealien			{color: #00c000;}
.alertalien				{color: #00c000;	font-weight: bold;}
.changeling				{color: #800080;	font-style: italic;}

.spider					{color: #4d004d;}

.interface				{color: #330033;}

.sans					{font-family: sans-serif;}
.papyrus				{font-family: "Papyrus";}
.robot					{font-family: "Courier New";}

.command_headset		{font-weight: bold;	font-size: 3;}
.small					{font-size: 1;}
.medium					{font-size: 2;}
.big					{font-size: 3;}
.reallybig				{font-size: 4;}
.extremelybig			{font-size: 5;}
.greentext				{color: #00FF00;	font-size: 3;}
.redtext				{color: #FF0000;	font-size: 3;}
.clown					{color: #FF69Bf;	font-size: 3;	font-family: sans-serif;	font-weight: bold;}
.singing				{font-family: sans-serif; font-style: italic;}
.his_grace				{color: #15D512;	font-family: sans-serif;	font-style: italic;}
.hypnophrase			{color: #3bb5d3;	font-weight: bold;}

.phobia					{color: #ba653b;	font-weight: bold;}
.icon					{height: 1em;	width: auto;}
.infobox				{border: 1px; background: rgba(44, 27, 48, 0.3); margin: 2px 8px;}

.infohr 				{border: 0; height: 1px; color: #be7d64;}

.memo					{color: #638500;	text-align: center;}
.memoedit				{text-align: center;	font-size: 2;}
.abductor				{color: #800080;	font-style: italic;}
.mind_control			{color: #A00D6F;	font-size: 3;	font-weight: bold;	font-style: italic;}
.slime					{color: #00CED1;}
.drone					{color: #848482;}
.monkey					{color: #975032;}
.swarmer				{color: #2C75FF;}
.resonate				{color: #298F85;}

.monkeyhive				{color: #774704;}
.monkeylead				{color: #774704;	font-size: 2;}
.infoplain				{}

.userlove				{color: #ff57cd; font-style: italic; font-size: 110%;}

.love					{color: #ff45c7; font-style: italic;}

.horny					{color: #ff4591; font-style: italic;}

.bling					{color: #D5AD6D; font-weight: bold; font-size: 110%;}

.achievementrare		{color: #D5AD6D; font-weight: bold; font-size: 150%;}

.achievementinteresting	{color: #880000; font-weight: bold; font-size: 120%;}

.achievementgood		{color: #7cdd7c; font-weight: bold; font-size: 125%;}

.achievementneutral		{color: #9fffdf; font-weight: bold; font-size: 125%;}

.achievementbad			{color: #ff3a4a; font-weight: bold; font-size: 125%;}

.largeinfo				{color: #9ab0ff; font-size: 125%;}

.effortgained			{color: #5df4ff;font-size: 110%;}

.effortlost				{color: #5df4ff; font-size: 110%;}

.animatedpain 			{color: #BA55D3;font-size: 110%;}

.flashinguserdanger		{color: #BA55D3; font-size: 125%;}
</style>"}
