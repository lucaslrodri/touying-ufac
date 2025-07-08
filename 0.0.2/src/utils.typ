#import "@preview/touying:0.6.1": *
#import "constants.typ": *

// Private methods (For slides)
#let _line(self) = line(stroke: .1em + self.colors.primary, length: 100%)
#let _line-white(self) = line(stroke: .1em + self.colors.neutral-lightest, length: 100%)

#let _cell(self, ..args, pos: "center", pad-left: 0em, pad-right: 0em, white: false, it) = {
  let _content(it) = {
    set text(size: 0.4em, ..args)
    context{
      let get-content(it) = {
        if (type(it) == str) {
          return h(0.4em) + upper(it) + h(0.4em)
        } else if (type(it) == content) {
          if (measure(it).width > 0pt) {
            return h(0.4em) + box(upper(it)) + h(0.4em)
          }
        } else {
          return none
        }
      }
      block(
        above: 0pt,
        below: 0pt,
        outset: 0pt,
        breakable: false,
        inset: 1mm,
        height: 100%,
        get-content(it)
      )
    }
  }

  set text(fill: if white {self.colors.neutral-lightest} else {self.colors.primary}) if white

  let l = if white {
    _line-white(self)
  } else {
    _line(self)
  }

  if pos == "center" {
    grid(
      columns: (pad-left, 1fr, auto, 1fr, pad-right),
      l, l, _content(it), l, l
    )
  } else if pos == "left" {
    grid(
      columns: (pad-left, auto, 1fr, pad-right),
      l, _content(it), l, l
    )
  } else if pos == "right" {
    grid(
      columns: (pad-left, 1fr, auto, pad-right),
      l, l, _content(it), l
    )
  }
}

#let _footer(self) = {
  set text(self.colors.primary)
  set std.align(bottom)
  context({
    let ufac-logo = image(bytes(_ufac-logo), height: 1.5em)
    let last-column-size = measure(box(text(utils.last-slide-number, size: 0.6em), inset: 0.4em)).width
    move(grid(
      columns: (1em, auto, auto, auto, last-column-size, 1em),
      rows: 1.5em,
      align: horizon,
      _line(self),
      box(image(bytes(_ufac-logo), height: 0.64em), inset: 0.2em),
      _cell(self, pad-left: 1.25em, pos: "left", utils.call-or-display(self, self.store.footer-left)),
      _cell(self, pad-right: 2em, pos: "right", utils.call-or-display(self, self.store.footer-right)),
      _cell(self, pos: "center", size: 0.6em, utils.slide-counter.display()),
      _line(self)
    ), dy: -0.05em)
  })
}

#let _header(self) = {
  set std.align(horizon)
  set text(self.colors.primary, size: 1.2em, weight: "bold")
  block(
    inset: (x: 1em),
    width: 100%,
    height: 1.5em,
    // fill: self.colors.tertiary,
    utils.call-or-display(self, self.store.header),
  )
}

// Public methods
// TODO: Description
#let numbered-list(..items) = {
  enum(
    numbering: (..nums) => {
      let depth = nums.pos().len()
      if depth == 1 {
        set text(fill: colors.primary, weight: "semibold")
        numbering("1.", ..nums)
      }else if depth == 2 {
        set text(fill: colors.secondary.darken(5%))
        numbering("a.", nums.at(-1))
      }else {
        set text(fill: colors.secondary.darken(5%))
        numbering("i.", nums.at(-1))
      }
    },
    full: true,
    ..items.pos().enumerate().map(
      (item) => {
        let (index, value) = item
        enum.item(index + 1)[#value]
      }
    )
  )
}

#let bullet-list(body, color: colors.secondary) = {
  set list(marker: (depth) => {
    if depth == 0 {
      move(square(fill: color, size: 0.4em, radius: 0.1em), dy: 0.2em)
    } else if depth == 1 {
      move(rotate(square(stroke: color + 2pt, size: 0.3em, radius: 0.1em), -20deg), dy: 0.4em)
    } else {
      text("-", fill: color)
    }
  })
  body
}

//Replacing composer side-by-side (Adding division between columns)
#let side-by-side(columns: auto, height: 100%, gutter: 0em, ..bodies) = {
  let bodies = bodies.pos()
  if bodies.len() == 1 {
    return bodies.first()
  }
  let columns = if columns == auto or columns == none {
    (1fr,) * bodies.len()
  } else {
    columns
  }
  grid(
   columns: columns,
   rows: height,
   inset: (x, _) => (
    left: if (x > 0) {1em} else {0em},
    right: 1em,
    y: 0.5em
   ),
   stroke: (x, _) => (
     x: if x>0 {colors.primary + 2.2pt},
     right: none,
   ),
   gutter: gutter, 
   ..bodies
  )
}