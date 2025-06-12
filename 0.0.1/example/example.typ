// TODO: Improve this example

#import "@preview/touying:0.6.1": *
#import "@local/touying-ufac:0.0.1": *

#show: ufac-theme.with(
  aspect-ratio: "16-9",
  progress-bar: false,
  config-info(
    title: [Revisão],
    subtitle: [Unidade temática I],
    author: [Prof. Dr. Lucas Lima Rodrigues],
    subject: [Controle Linear I],
    subject-code: [CCET510]
  ),
)

#title-slide()

= Apresentação do curso

#image("../assets/apresentacao-curso.jpg", width: 12em, height: 60%)

== Plataforma didática

=== Unidades temáticas


Consiste em 8 unidades temáticas:

+ Conceitos básicos de sinais e sistemas.
  + Resposta a entradas senoidais.
    + Resposta a entradas não senoidais.
+ Representação por equações diferenciais e equações de diferenças.

- Resposta a entradas senoidais.
  - Resposta a entradas não senoidais.
    - Resposta a entradas senoidais.

---

Você será convidado automaticamente se tiver o e-mail institucional.


== Cronograma

#table(
  columns: (1fr, 1fr),
  [Unidade temática], [Encontros],
  [1], [2],
  [2], [2],
  [3], [2],
)

== Estrutura do curso

O curso é dividido em 4 módulos, cada um com 3 aulas.

== Estrutura do curso

#slide[
  === Direita: #text("bla bla", black)

  Teste #secondary("Aaaa") #tertiary("Teste")

  Teste #alert("teste")
][
  === Esquerda

  Teste
]

== Outro exemplo

#side-by-side[
  === Direita: #text("bla bla", black)

  Teste #secondary("Secondary (Yellow)") #tertiary("Tertiary (Red)")

  Teste #alert("Primary")

  *#alert("Primary + bold")* and *#secondary("Secondary + bold")* 
][
  === Meio

  Teste
][
  === Esquerda

  Teste
]

== Adnomotions

#fancy-box(
  icon: "book",
  prefix: "Theorem",
  title: "Euclid's Theorem",
)[Hello world!]

#fancy-box(
  prefix: "Exercício",
  title: "Ogata 4.67",
  color: colors.secondary
)[Hello world!]

#fancy-box(
  prefix: "Tarefa",
  color: colors.quarternary
)[Hello world!]

#fancy-box(
  prefix: "Resposta",
  color: colors.tertiary
)[Hello world!]

#note-box(
  icon: "light-bulb",
  color: colors.secondary
)[Hello 2]

#note-box(icon: "alert", title: "Atenção: ", color: colors.tertiary)[
  Remember that mathematical proofs should be both rigorous and clear.
  Clarity without rigor is insufficient, and rigor without clarity is ineffective.
]

#note-box(color: colors.tertiary)[
  Remember that mathematical proofs should be both rigorous and clear.
  Clarity without rigor is insufficient, and rigor without clarity is ineffective.
]

#note-box(
  icon: "comment",
  color: colors.quarternary,
  title: "Relembrando: "
)[Relembrando que $x=2$]

#note-box[
  Remember that mathematical proofs should be both rigorous and clear.
  Clarity without rigor is insufficient, and rigor without clarity is ineffective.
]

#quote-box[
  Mathematics is the queen of sciences, and number theory is the queen of mathematics.
  — Gauss
]

#show: show-exercises

#blank-slide()[
  #example(title: "Ogata 4.6")[
    Considere o sistema abaixo:
    $
      H(s) = 1/(s^2+3s+4)
    $
  ]
]

#blank-slide()[
  #example[
    Considere o sistema abaixo:
    $
      H(s) = 1/(s^2+3s+4)
    $
  ]<exampl> 
]

#blank-slide()[
  #solution(title: [@exampl])[
    A solução é bla bla bla
  ]
]
#blank-slide()[
  #problem[
    Considere o sistema abaixo:
    $
      H(s) = 1/(s^2+3s+4)
    $
  ]
]


#blank-slide()[
  #solution[
    A solução é bla bla bla
  ]
]

#blank-slide()[
  #fancy-box(
    prefix: "Exercício",
    title: "Ogata 4.67",
    breakable: true,
    color: colors.secondary,
  )[Considerar o sistema de controle abaixo:
  $
    H(s) = 1/(s^2+2s+1)
  $
  
  + Determine a resposta do sistema a uma entrada senoidal de frequência $omega =1 pi$ rad/s.
  + Determine a resposta do sistema a uma entrada senoidal de frequência 2 rad/s.

  #_internals.numbered-list[
    A
    + A
      + C
      + D
    + B
  ][B]
  
  ]
]

#exercise-slide(source: [Ogata])[
  #lorem(300)
]

#exercise-slide(type: "exercise", source: [Omar])[
  #lorem(300)
]

#exercise-slide(type: "solution-example")[
  Omar é um gato que gosta de brincar com o computador do professor. Ele sempre tenta abrir o editor de texto e escrever mensagens engraçadas. O que você acha que ele escreveria se pudesse?
]