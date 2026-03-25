#import "general.typ": (
  accent-color, detail-stack, draft-pattern, font-size, formal-general, formal-syntax, ghost,
  ghost-color, smaller-font-size,
)
#import "@preview/drafting:0.2.2": margin-note, set-page-properties
#import "@preview/shadowed:0.2.0": shadowed

#let place-margin-note(body) = {
  v(0pt, weak: true)
  margin-note(side: right, stroke: none, body)
}

#let metadata-note(..items) = {
  let content = detail-stack(..items)
  if content == none {
    return none
  }

  place-margin-note(content)
}


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
    hyphenate: true,
    lang: lang,
    costs: (hyphenation: 10%),
  )
  set par(justify: true)
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

#let style-lists(body) = {
  set list(
    marker: (
      text(
        font: "Menlo",
        size: 1.5em,
        baseline: -0.2em,
        "✴", // TODO: use a proper icon here
        fill: accent-color,
      ),
      text(size: 0.6em, baseline: +0.2em, "➤", fill: ghost-color),
    ),
  )
  body
}

#let inline-heading(content) = text(
  size: smaller-font-size,
  weight: "bold",
  fill: accent-color,
  content + [.],
)

#let style-headings(body) = {
  show heading: set text(fill: accent-color)
  set heading(numbering: "1")

  show heading.where(level: 2): it => {
    v(1em)
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
      top: if y == 0 { 0.5pt + accent-color },
      bottom: if y == 0 { 0.5pt + accent-color },
    ),
  )
  set table(align: center + horizon)
  show table.cell.where(y: 0): it => {
    set text(weight: "bold", fill: accent-color)
    it
  }
  body
}


// NOTES AND MARGINS

// Note styles
#let style-note(body) = {
  set math.equation(numbering: none)
  show math.equation.where(block: true): set block(spacing: 0.5em)
  set text(size: smaller-font-size, fill: luma(20%))
  body
}

#let note-title(title, inline: false) = {
  if title == none {
    return none
  }

  let body = inline-heading(title)
  if inline {
    return body
  }

  text(size: smaller-font-size, body)
}

// Margin notes
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

  let heading = note-title(title, inline: true)
  place-margin-note(if heading == none { body } else { heading + body })
}

#let note(cols: 1, title: none, body) = {
  show: style-note

  let heading = note-title(title)
  let content = {
    set align(left)
    show: it => columns(cols, it)
    if heading != none {
      heading
    }
    body
  }
  let panel = shadowed(
    radius: 2mm,
    inset: 2mm,
    shadow: 2mm,
    fill: gradient.linear(luma(99%), luma(98%), angle: 30deg),
    content,
  )

  set align(center)
  pad(x: -2mm, y: -1mm, panel)
}


// TEMPLATE

#let header(authors: none, date: none) = {
  metadata-note(
    if authors != none { text(weight: "medium", authors) },
    if date != none { ghost(date) },
  )
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
  show: style-lists
  show: style-headings
  show: style-tables

  header(
    authors: authors,
    date: date,
  )

  body
}
