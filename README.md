# anylang

Sintaxis abierta, agrupable, recursiva y minimalista.

## ¿Qué?

Eso, una sintaxis formal:

  - abierta: permite símbolos con acentos, comas, incluso puntos que son separadores de sentencia los admite, admite punto y comas, guiones, puntos altos, comillas dobles y simples
  - agrupable: permite agrupar palabras y grupos con los 3: {}, [] y ().
  - recursiva: permite agrupar grupos recursivamente.
  - minimalista: Vas a ver que 

## Instalar

```sh
npm i -g @allnulled/anylang
```

## Importar

En node.js:

```js
require("@allnulled/anylang");
```

En browser:

```html
<script src="node_modules/@allnulled/anylang/anylang.js"></script>
```

## Uso

```js
const ast = AnylangParser.parse("ya puedes parsear");
```

## Sintaxis

Finales de sentencia: `EOS = ("." / "!" / "?" / "") !(!(___/EOF/")"/"}"/"]")) { return text() }`

Palabras: `Word_character = [A-Za-z0-9Ññ_\$\-ÁÉÍÓÚáéíóúÀÈÌÒÙàèìòùÂÊÎÔÛâêîôûÄËÏÖÜäëïöü·'"=\*] { return text() }`

Separadores: `Separator = (("."(!__))/","/";"/":"/"/"/"*"/"=") {}`

## Ejemplos

Un ejemplo de sql:

```
SELECT * FROM table WHERE (
    columna1 = 'x' AND (
        columna2 = 'y' OR
        columna2 = 'z'
    )
)
```

Un ejemplo para imitar javascript:

```
module.exports = function(a, b, c) {
    let x = 100.
    print("Ma whereva").
}
```

Un ejemplo para imitar java:

```
import com.package.wherever.Server.
import com.package.wherever.List.
import com.package.wherever.Thread.

clase Main {

 static HARDCODED = 100.

 private static void main (String [] args) {
  List wherever = new List(1, 2, 3).
  Server server = new Server().
  Server.start(this.HARDCODED).
  Server.start(new Thead() {
   System.out.println("Uh-ye").
  }).
 }.

}
```

Esto se parsea bien. Un poco, si pillas, pillas. Puedes parsear muchas cosas. Quiero decir, en este caso, solo cambiando el `;` por el `.`, el JSON es este:

```json
[
  {
    "import com.package.wherever.Server": null
  },
  {
    "import com.package.wherever.List": null
  },
  {
    "import com.package.wherever.Thread": null
  },
  {
    "clase Main": [
      {
        "static HARDCODED = 100": null
      },
      [
        {
          "private static void main": [
            {
              "String": []
            },
            {
              "args": null
            }
          ]
        },
        [
          {
            "List wherever = new List": {
              "1, 2, 3": null
            }
          },
          {
            "Server server = new Server": []
          },
          {
            "Server.start": {
              "this.HARDCODED": null
            }
          },
          {
            "Server.start": [
              {
                "new Thead": []
              },
              {
                "System.out.println": {
                  "\"Uh-ye\"": null
                }
              }
            ]
          }
        ]
      ]
    ]
  }
]
```

Así que con nada, puedes parsear muchas cosas, y te las ordena bastante guai. No es el AST ideal para Java, pero te daría ya una forma de algunas cosas.

## Explicación más profunda

Varias cosas:

  - **Máxima representabilidad.** Con este, sí puedes representar cualquier lenguaje.
  - **Máxima flexibilidad.** Es pronto para decirlo, pero ya cubre casuísticas caóticas que antes eran dificultosas. Tipo `{ esto } o { aquello }`.
  - **Máximo reporte.** No solo era permitir parsear, sino dar un reporte limpio. Lo consigue. Difícilmente más limpio, me atrevo.
  - **Menos de 30 líneas.** La solución era sencilla, pero la conclusión no estaba tan accesible.

## Expectativas

Estoy bastante disgustado todavía. No aprecio mucho este presente. Pero de criticar, diría que no me deja aprovechar la diferencia de paréntesis, por ejemplo. Pero también sé por qué los he omitido, y es para simplificar el parser, te ahorro 1 nivel en cada vuelta recursiva de grupo. Pero no lo sé, quizá más adelante se pueda mejorar también.

De momento, es bastante culmen para mí. Mi último intento fue `universal-programming-language` y no cumplía todas las expectativas de accesibilidad, diría. Este es más fácil, más difícil equivocarse, y más fácil de leer la salida.

Este es mejor que `universal-programming-language`, y ahora mismo me parece bastante cumbre. Pero siendo solo 30 líneas, aún puede dar para mucho.