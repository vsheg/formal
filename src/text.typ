
#import "general.typ": (
  accent-color, detail-stack, draft-pattern, font-size, formal-general, ghost, ghost-color,
  inline-heading, smaller-font-size,
)
#import "@preview/drafting:0.2.2": margin-note, set-margin-note-defaults, set-page-properties

#let resolve-marginalia-width(content-width, marginalia-width) = {
  if type(marginalia-width) == type(1fr) {
    return marginalia-width / 1fr * content-width
  }

  marginalia-width
}

#let style-page(
  draft: false,
  content-width: 180mm,
  content-height: 250mm,
  page-margins: 10mm,
  marginalia-width: 1fr / 3,
  marginalia-gutter: 0pt,
  body,
) = {
  let marginalia-span = resolve-marginalia-width(content-width, marginalia-width)
  let right-span = marginalia-gutter + marginalia-span
  let full-width = content-width + 2 * page-margins
  let full-height = content-height + 2 * page-margins

  set page(
    width: full-width,
    height: full-height,
    margin: (
      y: page-margins,
      left: page-margins,
      right: page-margins + right-span,
    ),
    background: if draft { draft-pattern } else { none },
  )

  set-page-properties(
    margin-right: marginalia-span,
    margin-left: page-margins,
    page-offset-x: marginalia-gutter,
  )

  set-margin-note-defaults(
    stroke: none,
    side: right,
  )

  body
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
  content-width: 180mm,
  content-height: 250mm,
  page-margins: 10mm,
  marginalia-width: 1fr / 3,
  marginalia-gutter: 0pt,
  font-size: font-size,
) = {
  show: formal-general.with(font-size: font-size)

  show: style-text.with(lang: lang)
  show: style-page.with(
    draft: draft,
    content-width: content-width,
    content-height: content-height,
    page-margins: page-margins,
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
