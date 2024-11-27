# GAP-a-Farm
GAP-a-Farm es una herramienta de investigación que busca explorar el rol de las TIC en la implementación de Buenas Prácticas Agrícolas. Se trata de un prototipo experimental que explora el registro simplificado de actividades de la huerta como oportunidad para ofrecer recomendaciones y alertas para la aplicación de buenas prácticas agrícolas. 

For more information, visit [our web-site](https://www.lifia.info.unlp.edu.ar/gap-a-farm/)

In your Pharo 11 image evaluate the following expresion to install the application.

```Smalltalk
Metacello new
	baseline: 'GapAFarm';
	repository: 'github://lifia-unlp/gap-a-farm';
	onWarningLog;
	onConflictUseIncoming;
	load.
  ```
  
To load the tests evaluate:
  
```Smalltalk
Metacello new
	baseline: 'GapAFarmTests';
	repository: 'github://lifia-unlp/gap-a-farm';
	onWarningLog;
	onConflictUseIncoming;
	load.
```

# Deployment

To deploy/run the app evaluate the code in [build-deploy/docker/run.st](./build-deploy/docker/run.st)

# Telegram branch

This branch includes specific prototipical funcionality for the integration of telegram bots. Currently, it is limited to the reporting of new harvests. It serves the purpose of deploying a demostrator to use during interviews to empathize. One such videos is shown [here](https://youtu.be/h7rsQEUx338).
