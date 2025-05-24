#import "@preview/touying:0.6.1": *
#import "../src/lib.typ": *

#show: ufac-theme.with(
  aspect-ratio: "16-9",
  progress-bar: true,
  config-info(
    title: [Título da unidade temática],
    subtitle: [Unidade temática I],
    author: [Prof. Dr. Seu Nome],
    subject: [Nome da disciplina],
    subject-code: [CCETXXX]
  ),
)

#title-slide()

= Nome da primeira seção

[Imagem de fundo]

== Slide 1

Conteúdo do slide 1.