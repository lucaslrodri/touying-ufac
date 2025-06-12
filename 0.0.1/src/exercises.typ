#import "@preview/theorion:0.3.3": *
#import "constants.typ": colors
#import "alerts.typ": inline-box

#let _example-counter = counter("example")
#let _exercise-counter = counter("exercise")

#_example-counter.update(it => 1)
#_exercise-counter.update(it => 1)


// TODO: Make description
#let _title-box(body, color: colors.secondary, text-color: white) = block(
  fill: color,
  radius: 5pt,
  inset: (x: .7em),
  outset: (y: 0.4em),
  text(fill: text-color, body, weight: "bold")
)

// TODO: Make description
#let _render-exercise(full-title, color, body) = [
  #_title-box(full-title, color: color)
  #block(
    inset: (left: 1em),
    width: 100%,
    body
  )
]

// TODO: Make description
#let register-exercise(color: colors.secondary, supplement: auto, indentifier) = {
  let (_counter, _box, _exercise, _show-exercise) = make-frame(
    indentifier,
    if supplement == auto {theorion-i18n-map.at(indentifier)} else {supplement},
    render: (prefix: none, title: "", full-title: auto, body) => _render-exercise(full-title, color, body)
  )

  return (_exercise, _show-exercise)
}

// TODO: Make description
#let solution(title: "", color: colors.safe, body) = {
  let full-title = "Solução" + if title != "" [ (#title)]
  _render-exercise(full-title, color, body)
}

// TODO: Make description
#let (example, _show-example) = register-exercise("example")
// TODO: Make description
#let (problem, _show-problem) = register-exercise("problem", color: colors.primary)

// TODO: Make description
#let show-exercises(body) = {
  show : _show-example
  show : _show-problem
  body
}