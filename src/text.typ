
#import "general.typ": (
  accent-color, detail-stack, draft-pattern, font-size, formal-general, ghost, ghost-color,
  inline-heading, smaller-font-size,
)
#import "@preview/drafting:0.2.2": margin-note, set-margin-note-defaults, set-page-properties

#let auto-page-margin(page-width, page-height) = 2.5 / 21 * calc.min(page-width, page-height)

#let page-margin-dict-entry(page-margin, side) = {
  if side in ("top", "bottom") {
    if side in page-margin.keys() {
      return page-margin.at(side)
    }
    if "y" in page-margin.keys() {
      return page-margin.y
    }
  } else {
    if side in page-margin.keys() {
      return page-margin.at(side)
    }
    if "x" in page-margin.keys() {
      return page-margin.x
    }
  }

  if "rest" in page-margin.keys() {
    return page-margin.rest
  }

  auto
}

#let effective-page-binding() = {
  if page.binding != auto {
    return page.binding
  }

  if text.dir == rtl {
    right
  } else {
    left
  }
}

#let page-margin-setting(page-margin) = {
  if page-margin == auto {
    return auto
  }

  if type(page-margin) != dictionary {
    return (
      top: page-margin,
      bottom: page-margin,
      inside: page-margin,
      outside: page-margin,
    )
  }

  let top = page-margin-dict-entry(page-margin, "top")
  let bottom = page-margin-dict-entry(page-margin, "bottom")

  if "left" in page-margin.keys() or "right" in page-margin.keys() {
    let left = page-margin-dict-entry(page-margin, "left")
    let right = page-margin-dict-entry(page-margin, "right")

    if left == right {
      return (
        top: top,
        bottom: bottom,
        inside: left,
        outside: right,
      )
    }

    return (
      top: top,
      bottom: bottom,
      left: left,
      right: right,
    )
  }

  (
    top: top,
    bottom: bottom,
    inside: page-margin-dict-entry(page-margin, "inside"),
    outside: page-margin-dict-entry(page-margin, "outside"),
  )
}

#let resolve-page-margin-value(value, page-width, page-height) = {
  if value == auto {
    return auto-page-margin(page-width, page-height)
  }

  if type(value) == relative {
    return value.length
  }

  value
}

#let resolve-page-margin(page-margin, page-width, page-height, page-number) = {
  if type(page-margin) != dictionary {
    let margin = resolve-page-margin-value(page-margin, page-width, page-height)
    return (
      top: margin,
      right: margin,
      bottom: margin,
      left: margin,
    )
  }

  let binding = effective-page-binding()
  let top = resolve-page-margin-value(
    if "top" in page-margin.keys() { page-margin.top } else { auto },
    page-width,
    page-height,
  )
  let bottom = resolve-page-margin-value(
    if "bottom" in page-margin.keys() { page-margin.bottom } else { auto },
    page-width,
    page-height,
  )

  let (left, right) = if "left" in page-margin.keys() or "right" in page-margin.keys() {
    let left = resolve-page-margin-value(
      if "left" in page-margin.keys() { page-margin.left } else { auto },
      page-width,
      page-height,
    )
    let right = resolve-page-margin-value(
      if "right" in page-margin.keys() { page-margin.right } else { auto },
      page-width,
      page-height,
    )
    (left, right)
  } else {
    let is-bound-left = calc.odd(page-number) == (binding == left)
    let inside = resolve-page-margin-value(
      if "inside" in page-margin.keys() { page-margin.inside } else { auto },
      page-width,
      page-height,
    )
    let outside = resolve-page-margin-value(
      if "outside" in page-margin.keys() { page-margin.outside } else { auto },
      page-width,
      page-height,
    )

    if is-bound-left {
      (inside, outside)
    } else {
      (outside, inside)
    }
  }

  (
    top: top,
    right: right,
    bottom: bottom,
    left: left,
  )
}

#let resolve-marginalia-width(content-width, marginalia-width) = {
  if type(marginalia-width) == type(1fr) {
    return marginalia-width / 1fr * content-width
  }

  marginalia-width
}

#let marginalia-rect(stroke: none, fill: none, width: auto, body) = rect(
  stroke: stroke,
  fill: fill,
  width: width,
  inset: 0pt,
  align(left, block(width: 100%, body)),
)

#let style-page(
  draft: false,
  page-paper: "a4",
  page-width: auto,
  page-height: auto,
  page-margin: auto,
  marginalia-width: 0.33fr,
  marginalia-gutter: 5mm,
  body,
) = {
  let page-args = (
    background: if draft { draft-pattern } else { none },
    margin: page-margin-setting(page-margin),
  )

  if page-width != auto and page-height != auto {
    page-args.width = page-width
    page-args.height = page-height
  } else {
    page-args.paper = page-paper
  }

  set page(..page-args)

  context {
    let resolved-page-margin = resolve-page-margin(
      page.margin,
      page.width,
      page.height,
      here().page(),
    )
    let page-body-width = page.width - resolved-page-margin.left - resolved-page-margin.right
    let marginalia-column-width = resolve-marginalia-width(page-body-width, marginalia-width)
    let text-width = page-body-width - marginalia-gutter - marginalia-column-width

    // NOTE: drafting places right-side note boxes 2% of the text width away from the text column.
    // It also shrinks the effective note box by the same amount on both sides, so compensate here
    // to keep the configured gutter and marginalia width visible on the page.
    let drafting-gap = 2 * text-width / 100
    let note-region-width = marginalia-column-width + 2 * drafting-gap

    block(
      width: text-width,
      {
        set-page-properties(
          margin-left: resolved-page-margin.left,
          margin-right: note-region-width,
          margin-inside: resolved-page-margin.left,
          margin-outside: note-region-width,
          page-width: text-width,
          page-offset-x: marginalia-gutter - drafting-gap,
        )

        set-margin-note-defaults(
          rect: marginalia-rect,
          stroke: none,
          side: right,
        )

        body
      },
    )
  }
}

#let style-text(lang: "en", body) = {
  set text(
    lang: lang,
    costs: (hyphenation: 10%),
  )
  body
}

#let style-tables(smaller-font-size: smaller-font-size, body) = {
  show table: set text(size: smaller-font-size)
  show table.cell.where(y: 0): strong

  set table(
    stroke: (_, y) => (
      left: none,
      right: none,
      bottom: if y == 0 { 0.5pt + accent-color },
    ),
  )

  set table(align: horizon)
  // TODO: Add header style
  // Currently not supported: https://github.com/typst/typst/issues/3640
  body
}


// NOTES AND MARGINALIA

// Note styles
#let style-note(body) = {
  set math.equation(numbering: none)
  show math.equation.where(block: true): set block(spacing: 0.5em)
  set text(size: smaller-font-size)
  body
}

#let wide(body) = context {
  let margins = resolve-page-margin(page.margin, page.width, page.height, here().page())
  let left-margin = margins.left
  let right-margin = margins.right
  block(width: 100% + calc.max(0pt, right-margin - left-margin), body)
}

#let marginalia(title: none, ..content) = {
  show: style-note

  let body = if content.pos().len() == 1 {
    content.at(0)
  } else {
    if title == none {
      title = content.at(0)
    }
    content.pos().slice(1).join(linebreak())
  }

  let title = inline-heading(title)
  v(0pt, weak: true)
  margin-note(if title == none { body } else { title + body })
}

// Paragraph-level note
#let note(cols: 1, title: none, body) = {
  show: style-note

  let heading = inline-heading(title)
  let content = {
    set align(left)
    show: it => columns(cols, it)
    if heading != none {
      heading
    }
    body
  }

  block(
    fill: ghost-color.transparentize(95%),
    inset: 3mm,
    radius: 2mm,
    content,
  )
}


// TEMPLATE

#let header(authors: none, date: none) = {
  let content = detail-stack(
    if authors != none { text(weight: "medium", authors) },
    if date != none { ghost(date) },
  )

  if content == none {
    return none
  }

  margin-note(content)
}

#let formal-text(
  body,
  authors: none,
  date: none,
  lang: "en",
  draft: false,
  page-paper: "a4",
  page-width: auto,
  page-height: auto,
  page-margin: auto,
  marginalia-width: 0.33fr,
  marginalia-gutter: 5mm,
  font-size: font-size,
) = {
  show: formal-general.with(font-size: font-size)

  show: style-text.with(lang: lang)
  show: style-page.with(
    draft: draft,
    page-paper: page-paper,
    page-width: page-width,
    page-height: page-height,
    page-margin: page-margin,
    marginalia-width: marginalia-width,
    marginalia-gutter: marginalia-gutter,
  )
  show: style-tables

  header(
    authors: authors,
    date: date,
  )

  body
}
