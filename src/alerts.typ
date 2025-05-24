/// Extra alerts styles considering other colors than primary.
#import "constants.typ": colors

/// Alert content with the secondary color (Yellow).
///
/// Example: `alerts.secondary[content]`
#let secondary(body) = {
  show: text.with(fill: colors.secondary)
  body
}

/// Alert content with the tertiary color (Red).
///
/// Example: `alerts.tertiary[content]`
#let tertiary(body) = {
  show: text.with(fill: colors.tertiary)
  body
}

/// Alert content with the quartenary color (Green).
///
/// Example: `alerts.quarternary[content]`
#let quarternary(body) = {
  show: text.with(fill: colors.quarternary)
  body
}