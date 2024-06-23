Class {
	#name : #GAFMustacheLibrary,
	#superclass : #MustacheLibrary,
	#instVars : [
		'hour'
	],
	#category : #'GapAFarm-telegram'
}

{ #category : #templates }
GAFMustacheLibrary >> harvestMessageExtractionPrompt [
^'A continuación, te proporcionaré un mensaje de texto enviado por un agricultor que acaba de efectuar una cosecha. Necesito que extraigas la información específica del mensaje y la presentes en formato JSON válido (solo incluye JSON válido en tu respuesta). 

Los datos a extraer son:

1. El producto cosechado (crop): Puede ser uno de los siguientes: tomate, lechuga (o alguna variante específica de lechuga), berenjena, pimientos o ajíes o morrones, o albahaca.
2. La cantidad cosechada (quantity): Puede estar en kilos (kilogramos), toneladas, o canastos. La cantidad debe tener un valor y una unidad.
3. El lugar de la cosecha (plot): Puede referirse como lote o invernadero, indicando un número, nombre, o característica distintiva.

Si no es posible reconocer alguno de los datos, no incluyas la propiedad en el JSON de salida. A continuación, te doy un ejemplo del formato JSON esperado:

{
  "crop": "Tomate",
  "quantity": {
    "value": "2",
    "unit": "canastos"
  },
  "plot": "Lote del fondo"
}

Aquí tienes un ejemplo de el mensaje del agricultor:

"Acabo de cosechar 150 kilos de tomates del invernadero número 3."

---

**Respuesta esperada en formato JSON:**

{
  "crop": "tomates",
  "quantity": {
    "value": "150",
    "unit": "kilos"
  },
  "plot": "invernadero número 3"
}

'
]

{ #category : #templates }
GAFMustacheLibrary >> harvestMessageExtractionPrompt_exampleContext [
^'{"name" : "Juan"}'

]
