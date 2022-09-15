[![Build Status](https://travis-ci.com/cientopolis/gap-a-farm.svg?branch=master)](https://travis-ci.com/cientopolis/gap-a-farm)

# GAP-a-Farm
GAP-a-Farm es una herramienta de investigación que busca explorar el rol de las TIC en la implementación de Buenas Prácticas Agrícolas. Se trata de un prototipo experimental que explora el registro simplificado de actividades de la huerta como oportunidad para ofrecer recomendaciones y alertas para la aplicación de buenas prácticas agrícolas. 

For more information, visit [our web-site](https://www.lifia.info.unlp.edu.ar/gap-a-farm/)

In your Pharo 10.0 image evaluate the following expresion to install the application.

```Smalltalk
Metacello new
	baseline: 'GapAFarm';
	repository: 'github://cientopolis/gap-a-farm';
	onConflictUseLoaded;
	load.
  ```
  
To load the tests evaluate:
  
```Smalltalk
Metacello new
	baseline: 'GapAFarmTests';
	repository: 'github://cientopolis/gap-a-farm';
	onConflictUseLoaded;
	load.
```

# Deployment

```Smalltalk
"To deploy in debug mode use this lines"

GAFDeployer new adminEmail: 'youremail@yourdomain.com'; 
	database: 'gapafarm';
	deploy.

"Set enableTestDataLoaders: to true to get a [Load demo data] button."
GAFDeployer enableTestDataLoaders: true.
"Set demoMode: to true to get a Demo Banner."
GAFDeployer demoMode: true.

"Evaluate one of the following to set the target persistency strategy"
GAFStorage inMemory.
GAFStorage mongoLocalAt: 'stress2'.

"To deploy to production, in a clear image evaluate"

WAAdmin defaultServerManager adaptors
	do: [ :each | WAAdmin defaultServerManager unregister: each ].
ZnZincServerAdaptor startOn: 8080.

(WAAdmin defaultDispatcher handlers keys copyWithoutAll: #('files'))
	do: [ :appName |
		WAAdmin defaultDispatcher
			unregister: (WAAdmin defaultDispatcher handlerAt: appName) ].
WAAdmin applicationDefaults
	removeParent: WADevelopmentConfiguration instance.

GAFDeployer new
	adminEmail: 'youremail@yourdomain.com';
	database: 'gapafarm';
	deploy.
WAAdmin defaultDispatcher defaultName: 'gaf'.
```
