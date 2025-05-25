#import "@preview/showybox:2.0.4": showybox
#import "constants.typ": *
#import "icons.typ": octique-inline

/// A fancy box design inspired by elegantbook style.
///
/// - color (color): Color of the box border. Default is `colors.primary`.
/// - icon (string): Octique Icon to display at bottom right. Default is `none`.
/// - prefix (content): Prefix text before the title. Default is `none`.
/// - title (string): Title of the box. Default is empty string.
/// - breakable (boolean): Make the boxe breakable in a column or slide. Default is `false`.
/// - body (content): Content of the box.
/// 
/// -> content
/// 
#let fancy-box(
  color: colors.primary,
  icon: none,
  prefix: none,
  title: "",
  breakable: false,
  body,
) = {
  let _icon(color) = octique-inline(
    color: color,
    icon,
  )
  let get-header() = {
    let header = ""
    let use-brakets = false
    if prefix == none and title == "" {
      return ""
    }
    if icon != none {
      header += [#_icon(colors.light) #sym.space]
    }
    if prefix != none {
      header += prefix
      if title != "" {
        header += [ (#title)]
      }
    }else{
      if title != "" {
        header += title
      }
    }
    return header
  }
  let header = get-header()
  showybox(
    frame: (
      thickness: .05em,
      radius: .3em,
      inset: (x: 1.2em, top: if header != "" { .7em } else { 1em }, bottom: 1em),
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
    title: header,
    body-style: (
      height: 1fr,
    ),
    body
  )
}


// TODO: DESCRIPTION
#let note-box(
  color: colors.primary,
  icon: none,
  title: "",
  body
) = {
  if icon == none {icon = ""}
  let _icon(color) = if icon != "" {octique-inline(
    color: color,
    icon
  )} else {""}
  block(
    stroke: 0.05em + color,
    inset: (x: 1em, y: .7em),
    // sticky: true,
    radius: 5pt,
    width: 100%,
    if icon != "" {
    box(
      baseline: 3pt,
      grid(
      columns: (auto, auto),
      align: horizon,
      _icon(color) + if icon != "" and icon != none {" "},
      if title != "" {
        text(fill: color, weight: "semibold",
        [#title]
        )
      }
    ))
    } else if title != "" {
      text(fill: color, weight: "semibold",
        [#title]
      )
    } + body
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
#let quote-box(body, color: colors.secondary) = block(
  stroke: (left:.25em + color),
  inset: (left:1em, y: .75em),
  text(colors.dark, body),
)