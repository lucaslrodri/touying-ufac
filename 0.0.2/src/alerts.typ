/// Extra alerts styles considering other colors than primary.
#import "constants.typ": colors
#import "@preview/showybox:2.0.4": showybox

/// Alert content with the warning (Yellow).
///
/// Example: `#warning[content]`
#let warning(body) = {
  show: text.with(fill: colors.warning, weight: "bold")
  body
}

/// Alert content with the danger color (Red).
///
/// Example: `#danger[content]`
#let danger(body) = {
  show: text.with(fill: colors.danger, weight: "bold")
  body
}

/// Alert content with the quartenary color (Green).
///
/// Example: `#safe[content]`
#let safe(body) = {
  show: text.with(fill: colors.safe, weight: "bold")
  body
}

/// Alert content with the dark color (Black).
///
/// Example: `#dark[content]`
#let dark(body) = {
  show: text.with(fill: colors.dark, weight: "bold")
  body
}





// Boxes

/// A fancy box design inspired by elegantbook style.
///
/// - color (color): Color of the box border. Default is `colors.primary`.
/// - title (content): Title of the box. Default is empty content.
/// - breakable (boolean): Make the boxe breakable in a column or slide. Default is `false`.
/// - body (content): Content of the box.
/// 
/// -> content
/// 
#let fancy-box(
  color: colors.primary,
  title: [],
  breakable: false,
  body,
) = {
    set list(marker: (depth) => {
      if depth == 0 {
        set text(fill: color)
        scale(x:100%, sym.arrow.r)
      } else if depth == 1 {
        move(square(fill: color, size: 0.4em, radius: 0.1em), dy: 0.2em)
      } else {
        move(rotate(square(stroke: color + 2pt, size: 0.3em, radius: 0.1em), -20deg), dy: 0.4em)
      }
    })

  showybox(
    frame: (
      thickness: .05em,
      radius: .3em,
      inset: (x: 1.2em, top: if title != [] and title != "" { .7em } else { 1em }, bottom: 1em),
      border-color: color,
      title-color: color,
      body-color: colors.light,
      title-inset: (x: 1em, y: .5em),
    ),
    title-style: (
      boxed-style: (:),
      weight: "bold",
      color: colors.light,
    ),
    breakable: breakable,
    title: title,
    body-style: (
      height: 1fr,
    ),
    body
  )
}


// TODO: DESCRIPTION
#let note-box(
  color: colors.primary,
  align: left,
  body
) = {
  block(
    stroke: 0.05em + color,
    inset: (x: 1em, y: .7em),
    // sticky: true,
    radius: 5pt,
    width: 100%,
    {
      set std.align(align)
      set par(justify: true)
      body
    }
  )
}

/// Create a quote box with start border styling
///
/// Example: `quote-box(color: colors.secondary)[content]`
/// 
/// - body (content): Content to be quoted
/// - color (color): Color of the left border. Default is `colors.secondary`.
/// 
/// -> content
/// 
#let quote-box(body, color: colors.secondary, inset: (left: 1em, y: .75em)) = block(
  stroke: (left:.25em + color),
  inset: inset,
  body
)


// TODO: Make description
#let inline-box(body, color: colors.primary, text-color: white) = box(
  fill: color,
  radius: 5pt,
  inset: (x: .7em),
  outset: (y: 0.4em),
  text(fill: text-color, body, weight: "bold")
)