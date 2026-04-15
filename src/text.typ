
#import "general.typ": (
  accent-color, detail-stack, draft-pattern, font-size, formal-general, ghost, ghost-color,
  inline-heading, smaller-font-size,
)
#import "@preview/drafting:0.2.2": margin-note, set-margin-note-defaults, set-page-properties

#let page-margin-side(page-margin, side) = {
  if type(page-margin) == length {
    return page-margin
  }

  let keys = if side == "top" {
    ("top", "y", "rest")
  } else if side == "right" {
    ("right", "outside", "x", "rest")
  } else if side == "bottom" {
    ("bottom", "y", "rest")
  } else {
    ("left", "inside", "x", "rest")
  }

  for key in keys {
    if key in page-margin.keys() {
      return page-margin.at(key)
    }
  }
}

#let resolve-page-margin(page-margin) = {
  (
    top: page-margin-side(page-margin, "top"),
    right: page-margin-side(page-margin, "right"),
    bottom: page-margin-side(page-margin, "bottom"),
    left: page-margin-side(page-margin, "left"),
  )
}

#let resolve-marginalia-width(content-width, marginalia-width) = {
  if type(marginalia-width) == type(1fr) {
    return marginalia-width / 1fr * content-width
  }

  marginalia-width
}

#let style-page(
  draft: false,
  page-paper: "a4",
  page-width: auto,
  page-height: auto,
  page-margin: 10mm,
  marginalia-width: 0.33fr,
  marginalia-gutter: 5mm,
  body,
) = {
  let resolved-page-margin = resolve-page-margin(page-margin)
  let page-args = (background: if draft { draft-pattern } else { none })

  if page-width != auto and page-height != auto {
    page-args.width = page-width
    page-args.height = page-height
  } else {
    page-args.paper = page-paper
  }

  set page(..page-args)

  context {
    let page-content-width = page.width - resolved-page-margin.left - resolved-page-margin.right
    let marginalia-span = resolve-marginalia-width(page-content-width, marginalia-width)
    let right-span = marginalia-gutter + marginalia-span
    let text-width = (
      page.width - resolved-page-margin.left - resolved-page-margin.right - right-span
    )

    // NOTE: drafting places right-side note boxes 2% of the text width away from the text column.
    // Keep the note rect itself at zero inset so `marginalia-gutter` remains the visible gap.
    let drafting-offset = 2 * text-width / 100

    let final-page-args = (
      page-args
        + (
          margin: (
            top: resolved-page-margin.top,
            left: resolved-page-margin.left,
            bottom: resolved-page-margin.bottom,
            right: resolved-page-margin.right + right-span,
          ),
        )
    )

    set page(..final-page-args)

    set-page-properties(
      margin-right: marginalia-span,
      page-offset-x: marginalia-gutter - drafting-offset,
    )

    set-margin-note-defaults(
      rect: rect.with(inset: 0pt),
      stroke: none,
      side: right,
    )

    body
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
  let left-margin = page.margin.left
  let right-margin = page.margin.right
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
  page-margin: 10mm,
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
