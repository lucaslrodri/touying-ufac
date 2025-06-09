#import "@preview/touying:0.6.1": *
#import "utils.typ" as _internals
#import "constants.typ": colors
#import "alerts.typ": inline-box, quote-box


/// Default slide function for the presentation.
///
/// - config (dictionary): The configuration of the slide. You can use `config-xxx` to set the configuration of the slide. For more several configurations, you can use `utils.merge-dicts` to merge them.
///
/// - repeat (int, auto): The number of subslides. Default is `auto`, which means touying will automatically calculate the number of subslides.
///
////   The `repeat` argument is necessary when you use `#slide(repeat: 3, self => [ .. ])` style code to create a slide. The callback-style `uncover` and `only` cannot be detected by touying automatically.
///
/// - setting (function): The setting of the slide. You can use it to add some set/show rules for the slide.
///
/// - composer (function): The composer of the slide. You can use it to set the layout of the slide.
///
///   For example, `#slide(composer: (1fr, 2fr, 1fr))[A][B][C]` to split the slide into three parts. The first and the last parts will take 1/4 of the slide, and the second part will take 1/2 of the slide.
///
///   If you pass a non-function value like `(1fr, 2fr, 1fr)`, it will be assumed to be the first argument of the `components.side-by-side` function.
///
///   The `components.side-by-side` function is a simple wrapper of the `grid` function. It means you can use the `grid.cell(colspan: 2, ..)` to make the cell take 2 columns.
///
///   For example, `#slide(composer: 2)[A][B][#grid.cell(colspan: 2)[Footer]]` will make the `Footer` cell take 2 columns.
///
///   If you want to customize the composer, you can pass a function to the `composer` argument. The function should receive the contents of the slide and return the content of the slide, like `#slide(composer: grid.with(columns: 2))[A][B]`.
///
/// - bodies (array): The contents of the slide. You can call the `slide` function with syntax like `#slide[A][B][C]` to create a slide.
#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {


  let self = utils.merge-dicts(
    self,
    config-page(
      header: _internals._header,
      footer: _internals._footer,
    )
  )

  touying-slide(self: self, config: config, repeat: repeat, setting: setting, composer: composer, ..bodies)
})


/// Title slide for the presentation. You should update the information in the `config-info` function. You can also pass the information directly to the `title-slide` function.
///
/// Example:
///
/// ```typst
/// #title-slide()
/// ```
/// 
/// - config (dictionary): is the configuration of the slide. Use `config-xxx` to set individual configurations for the slide. To apply multiple configurations, use `utils.merge-dicts` to combine them.
///
/// - extra (string, none): is the extra information for the slide. This can be passed to the `title-slide` function to display additional information on the title slide.
#let title-slide(
  config: (:),
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  set page(fill: self.colors.primary)

  let footer(self) = {
    set std.align(bottom)
    move(grid(
      columns: (1em, auto, 1fr),
      rows: 1.5em,
      align: horizon,
      _internals._line-white(self),
      box(image(bytes(_internals._ufac-logo.replace("#0c4da2", "#fff")), height: 0.64em), inset: 0.2em),
      _internals._line-white(self)
    ), dy: -0.05em)
  }

  let header(self) = {
    set text(self.colors.neutral-lightest)
    set std.align(center + top)

    show: block.with(
      width: 100%,
      height: 1.3em,
    )
    grid(
      columns: (auto, auto),
      rows: 1.5em,
      align: horizon,
      _internals._cell(self, pad-left: 1em, pos: "left", white: true, utils.call-or-display(self, self.store.footer-left)),
      _internals._cell(self, pad-right: 1em, pos: "right", white: true, utils.call-or-display(self, self.store.footer-right)),
    )
  }

  let self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
    config-common(freeze-slide-counter: true),
  )

  let body = {
    std.align(center + horizon, {
      block(
        inset: 0em, breakable: false, {
          text(size: 2em, fill: self.colors.neutral-lightest, weight: "bold",
            utils.call-or-display(self, self.info.subject)
          )
          if self.info.subtitle != none {
            parbreak()
            text(size: 1.2em, fill: self.colors.secondary,
              utils.call-or-display(self, self.info.subtitle)
            )
            linebreak()
          }
          if self.info.title != none {            
            text(size: 1.2em, fill: self.colors.neutral-lightest,
              utils.call-or-display(self, self.info.title)
            )
          }
        }
      )
    })
  }

  touying-slide(self: self, body)
})

/// New section slide for the presentation. You can update it by updating the `new-section-slide-fn` argument for `config-common` function.
///
/// Example: `config-common(new-section-slide-fn: new-section-slide.with(numbered: false))`
///
/// - config (dictionary): is the configuration of the slide. Use `config-xxx` to set individual configurations for the slide. To apply multiple configurations, use `utils.merge-dicts` to combine them.
/// 
/// - level (int, none): is the level of the heading.
///
/// - numbered (boolean): is whether the heading is numbered.
///
/// - body (auto): is the body of the section. This will be passed automatically by Touying.
#let new-section-slide(config: (:), level: 1, numbered: true, body) = touying-slide-wrapper(self => {
  let slide-body = {
    set std.align(left + horizon)
    show: pad.with(left: 2%, top: -4em)
    set image(width: 12em, height: 66%)
    grid(columns: (1fr, auto),{
      set text(size: 2em, fill: self.colors.primary, weight: "bold")
      let _title = context{
        let current-page = here().page()
        let heading-num = query(heading).filter(h => h.location().page() <= current-page and h.level == 1).len()
      [Parte #heading-num: \
        #utils.display-current-heading(level: level, numbered: numbered)
      ] 
      }

      if self.store.progress-bar {        
      stack(
      dir: ttb,
      spacing: .65em,
      _title,
        block(
          height: 2pt,
          width: 100%,
          spacing: 0pt,
          components.progress-bar(height: 4pt, self.colors.secondary, self.colors.secondary.lighten(70%)),
        )
      )
      }else{ _title }
    }, move(pad(top: 1.5em, body), dx: 2em))
  }
  let self = utils.merge-dicts(
    self,
    config-page(
      footer: _internals._footer,
    )
  )

  touying-slide(self: self, config: config, slide-body)
})

#let blank-slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {

  let args = (:)
  let self = utils.merge-dicts(
    self,
    config-page(
      margin: (top: 1.25em, x: 1.25em, ..args),
      footer: _internals._footer,
    )
  )

  touying-slide(self: self, repeat: repeat, setting: setting, composer: composer, ..bodies)
})

/// Ufac theme.
///
/// Example:
///
/// ```typst
/// #show: ufac-theme.with(aspect-ratio: "16-9")
/// ```
///
/// - aspect-ratio (string): is the aspect ratio of the slides. Default is `16-9`.
///
/// - progress-bar (boolean): is whether to show the progress bar. Default is `false`.
///
/// - header (content, function): is the header of the slides. Default is `utils.display-current-heading(level: 2)`.
///
/// - footer-left (content, function): is the left part of the footer. Default is the suject (`self.info.subject`) + subject code (`self.info.subject-code`).
///
/// - footer-right (content, function): is the right part of the footer. Default is the author name (`self.info.author`).
#let ufac-theme(
  aspect-ratio: "16-9",
  progress-bar: false,
  header: self => utils.display-current-heading(
    setting: utils.fit-to-width.with(grow: false, 100%),
    level: 2,
    depth: self.slide-level,
  ),
  footer-left: self => {
    let code = ""
    if self.info.subject-code != [] and self.info.subject-code != none and self.info.subject-code != "" {
      code = self.info.subject-code + " - "

    }
    code + self.info.subject
  },
  footer-right: self => self.info.author,
  ..args,
  body,
) = {
  set text(size: 20pt)

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      header-ascent: 0em,
      footer-descent: 0em,
      margin: (top: 3.25em, bottom: 1.75em, x: 1.8em)
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(
          font: ("New Computer Modern Sans", "Carlito", "Calibri", "Libertinus Sans"),
          size: 22pt,
          weight: 500,
          lang: "pt"
        )

        set enum(numbering: (..nums) => {
          let depth = nums.pos().len()
          if depth == 1 {
            set text(fill: self.colors.primary)
            numbering("a)", ..nums)
          }else if depth == 2 {
            set text(fill: self.colors.secondary.darken(5%))
            numbering("i.", nums.at(-1))
          }else {
            set text(fill: self.colors.secondary.darken(5%))
            numbering("1.", nums.at(-1))
          }
        }, full: true)

        set list(marker: (depth) => {
          if depth == 0 {
            set text(fill: self.colors.primary)
            scale(x:100%, sym.arrow.r)
          } else if depth == 1 {
            move(square(fill: self.colors.secondary, size: 0.4em, radius: 0.1em), dy: 0.2em)
          } else {
            move(rotate(square(stroke: self.colors.secondary + 2pt, size: 0.3em, radius: 0.1em), -20deg), dy: 0.4em)
          }
        })

        show quote: it => {
          // set text(fill: self.colors.primary, weight: "bold")
          quote-box(["#it.body"
          #set std.align(right)
          #it.attribution])
        }

        set terms(
          tight: false,
        )

        show terms.item: it => {
          text(weight: "bold", fill: self.colors.neutral-darkest, it.term + ": ")
          it.description
          linebreak()
        }

        show table.cell.where(y: 0): set text(
          fill: self.colors.neutral-lightest,
          weight: "bold",
        )

        show figure.caption: it => [
          #it.body
        ]

        set table(
          fill: (_, y) => {
            if y == 0 {
              self.colors.primary
            }
          },
          stroke: (x, y) => (
            y: self.colors.primary,
            x: if x>0 and y==0 {
              self.colors.neutral-lightest
            }else {
              self.colors.primary
            },
            right: self.colors.primary,
          ),
          inset: 0.5em
        )


        show heading.where(level: 1): it => {
          set text(fill: self.colors.primary, weight: "bold")

          return [#it.numbering]
        }

        show heading.where(level: 3): it => {
          block(below: 1em,
          inline-box(it.body, color: self.colors.primary)
          )
        }
        show heading.where(level: 4): it => {
          set text(fill: self.colors.secondary, weight: "bold")
          block(below: 1em, text(it.body))
        }
        show heading.where(level: 5): it => {
          set text(fill: self.colors.neutral-darkest, weight: "bold")
          block(text(it.body))
        }

        show math.equation: set text(font: ("New Computer Modern Math", "Libertinus Math"))

        show heading.where(level: 2): set text(
          fill: self.colors.primary,
          weight: "bold",
        )
        body
      },
      alert: (self: none, it) => text(fill: self.colors.primary, it, weight: "bold"),
      cover: utils.semi-transparent-cover.with(alpha: 85%)
    ),
    config-colors(
      primary: colors.primary,
      secondary: colors.secondary,
      tertiary: colors.danger,
      neutral-lightest: colors.light,
      neutral-darkest: colors.dark,
    ),
    config-store(
      progress-bar: progress-bar,
      footer-left: footer-left,
      footer-right: footer-right,
      header: header,
    ),
    config-info(
      author: [],
      title: [],
      subtitle: [],
      subject: [],
      subject-code: [],
      course: "Curso de Engenharia Elétrica",
      institution: "Universidade Federal do Acre",
      logo: image(bytes(_internals._ufac-logo)),
    ),
    ..args,
  )

  body
}