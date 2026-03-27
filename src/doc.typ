#import "general.typ": (
  accent-color, detail-stack, draft-pattern, font-size, formal-general, formal-syntax, ghost,
  ghost-color, smaller-font-size,
)
#import "@preview/drafting:0.2.2": margin-note, set-page-properties

#let style-page(
  draft: false,
  content-width: 180mm,
  content-height: 250mm,
  margin-size: 10mm,
  margin-ratio: 0.34,
  body,
) = {
  let full-width = content-width + 2 * margin-size
  let full-height = content-height + 2 * margin-size

  set page(
    width: full-width,
    height: full-height,
    margin: (
      y: margin-size,
      left: margin-size,
      right: margin-ratio * content-width,
    ),
    background: if draft { draft-pattern } else { none },
  )

  set-page-properties()
  body
}

#let style-text(lang: "en", body) = {
  set text(
    lang: lang,
    costs: (hyphenation: 10%),
  )
  show raw: set text(font: "Menlo", size: 0.9em)
  body
}

#let style-math(body) = {
  set math.equation(numbering: "(1)")
  show ref: it => {
    let eq = math.equation
    let element = it.element

    if element != none and element.func() == eq {
      link(element.location(), numbering(
        element.numbering,
        ..counter(eq).at(element.location()),
      ))
    } else {
      it
    }
  }

  show math.equation.where(block: true): set block(spacing: 0.65em)
  body
}


#let inline-heading(delimiter: true, body) = text(
  size: smaller-font-size,
  weight: "bold",
  fill: accent-color,
  strong(body) + if delimiter { ". " } else { none },
)

#let style-headings(font-size: font-size, body) = {
  // TODO: This function is redundant, we should move this logic to formal-general
  show heading: set text(fill: accent-color, size: font-size)
  set heading(numbering: "1")

  show heading.where(level: 2): it => {
    inline-heading(it.body)
  }
  body
}

#let style-tables(body) = {
  show table: set text(size: smaller-font-size)

  set table(
    stroke: (_, y) => (
      left: none,
      right: none,
      bottom: if y == 0 { 0.5pt + accent-color },
    ),
  )
  set table(align: center + horizon)
  // TODO: Add header style
  body
}


// NOTES AND MARGINS

// Note styles
#let style-note(body) = {
  set math.equation(numbering: none)
  show math.equation.where(block: true): set block(spacing: 0.5em)
  set text(size: smaller-font-size)
  body
}

#let margin(title: none, ..content) = {
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
  margin-note(side: right, stroke: none, if title == none { body } else { title + body })
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

  margin-note(side: right, stroke: none, content)
}

#let formal-doc(
  body,
  authors: none,
  date: none,
  lang: "en",
  draft: false,
  content-width: 180mm,
  content-height: 250mm,
  margin-size: 10mm,
  margin-ratio: 0.34,
  font-size: font-size,
) = {
  show: formal-general.with(font-size: font-size)
  show: formal-syntax

  show: style-text.with(lang: lang)
  show: style-page.with(
    draft: draft,
    content-width: content-width,
    content-height: content-height,
    margin-size: margin-size,
    margin-ratio: margin-ratio,
  )
  show: style-math
  show: style-headings.with(font-size: font-size)
  show: style-tables

  header(
    authors: authors,
    date: date,
  )

  body
}
