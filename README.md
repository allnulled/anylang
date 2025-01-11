# anylang

Sintaxis abierta que siempre devuelve objetos de arrays.

## Instalar

```sh
npm i -g @allnulled/anylang
```

## Uso desde consola

Si lo instalas globalmente (`--g`) luego puedes:

```sh
anylang compile file1.any file2.any file3.any
```

Y generaría los `.json` respectivos.

## Uso desde API

### Importar

En node.js:

```js
require("@allnulled/anylang");
```

En browser:

```html
<script src="node_modules/@allnulled/anylang/anylang.js"></script>
```

### Usar

Una vez importado, tienes o en `window` o en `global` inyectada la variable `AnylangParser`, así que en ambos puedes hacer:

```js
const ast = AnylangParser.parse("ya puedes parsear");
```

## Sintaxis

En general, la idea es que los paréntesis `{}`, `[]` y `()` pueden usarse para agrupar cosas.

Y el texto se puede partir en cachos con `;\n`.

Y el párser te lo agrupa.

Estas son las normas, 2 realmente.

### Explicación más profunda

Lo que hace el párser es agrupar `texto` + `grupos lógicos`. 

Los `grupos lógicos` son los paréntesis.

Finalmente, el texto se puede romper con `;\n`.

A la hora de presentarlo:

  - Agrupa `texto` y `grupos lógicos` con un objeto, usando `texto` como propiedad, y `grupos lógicos` como valor en forma de lista, con grupos de esta estructura igual.
  - Cada grupo lógico se separa en diferentes objetos.
  - Pero los textos de un mismo grupo lógico se aplanan (flaten) en un objeto.


Esto es importante, porque esto significa que esta entrada:

```any
object {1}
object {2}
object {3}
object {4}
object {5}
```

Sacará esto:

```json
{
  "object": [
    {
      "5": []
    }
  ]
}
```

Así que ojo. Mientras entiendas esto, es bastante simple de intuir la estructura, y puedes iterar rápidamente con JavaScript.

## Ejemplos

Uno de java:

```java
clase Main {
    public static void main (String [] args) {
        System.out.println("Hola!");
    }
}
```

No es perfecto, pero algo te pilla:

```json
{
  "clase Main": [
    {
      "private void int wherever = 10": [],
      "public static void main": [
        {
          "String": [
            null
          ],
          "args": []
        },
        {
          "System.out.println": [
            {
              "\"Hola!\"": []
            }
          ]
        }
      ]
    }
  ]
}
```

Uno de JavaScript:

```js
module.exports = function(a, b, c) {
    let x = 100;
    print("Ma whereva");
}
```

Devuelve: 

```json
{
  "module.exports = function": [
    {
      "a, b, c": []
    },
    {
      "let x = 100": [],
      "print": [
        {
          "\"Ma whereva\"": []
        }
      ]
    }
  ]
}
```

Uno de SQL:

```sql
SELECT * FROM table WHERE (
    columna1 = 'x' AND (
        columna2 = 'y' OR
        columna2 = 'z'
    )
)
```


