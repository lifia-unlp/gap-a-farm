Smalltalk vm maxExternalSemaphoresSilently: 1024.
"Install the app"
Metacello new
	baseline: 'GapAFarm';
	repository: 'github://cientopolis/gap-a-farm';
	onConflictUseLoaded;
	onWarningLog;
	load.
"Disable loading of preferences"	
PharoCommandLineHandler forcePreferencesOmission: true.
"Disable Epicea"
EpMonitor reset.
NoChangesLog install.
NoPharoFilesOpener install
