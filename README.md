[![Build Status](https://travis-ci.org/cientopolis/gap-a-farm.svg?branch=master)](https://travis-ci.org/cientopolis/gap-a-farm)

# GAP-a-Farm
GAP-a-Farm es una herramienta de investigación que busca explorar el rol de las TIC en la implementación de Buenas Prácticas Agrícolas. Se trata de un prototipo experimental que explora el registro simplificado de actividades de la huerta como oportunidad para ofrecer recomendaciones y alertas para la aplicación de buenas prácticas agrícolas. 

For more information, visit [our web-site](https://www.lifia.info.unlp.edu.ar/gap-a-farm/)

In your Pharo 7.0 image evaluate the following expresion to install the application.

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
