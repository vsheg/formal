#import "/src/general.typ": accent-color, arrowhead, formal-general, ghost-color

#let style-headings(body, font-size: 18pt) = {
  body
}

#let poster-header(
  title: "Title",
  authors: "Authors",
  department: "Department",
  contacts: none,
  font-size: 18pt,
) = {
  let font-size-title = font-size * 2.5
  let font-size-authors = font-size * 2.0
  let font-size-department = font-size * 1.5

  // Decrease line spacing for the main header block.
  set par(leading: 0.4em)
  set align(center)

  grid(
    rows: 3,
    row-gutter: 1em,
    text(size: font-size-title, fill: accent-color, weight: "medium", title),
    none,
    text(size: font-size-authors, authors),
    text(size: font-size-department, style: "italic", department),
    if contacts != none { text(size: font-size-department, contacts) },
  )
}

#let poster-footer(
  body: none,
  conference: none,
  dates: none,
  font-size: 18pt,
) = {
  let font-size-metadata = font-size * 1.5
  let metadata = {
    set align(right)
    set text(fill: ghost-color)
    if conference != none {
      text(size: font-size-metadata, conference)
    }
    if conference != none and dates != none {
      linebreak()
    }
    if dates != none {
      text(size: font-size-metadata, dates)
    }
  }

  if body == none {
    return metadata
  }

  grid(
    columns: (1fr, auto),
    column-gutter: 2em,
    align: (left + horizon, right + horizon),
    {
      set text(size: font-size, fill: ghost-color)
      body
    },
    metadata,
  )
}

#let header = poster-header
#let footer = poster-footer

#let formal-poster(
  paper: "a1",
  lang: "en",
  title: "Title",
  authors: "Authors",
  department: "Department",
  font-size: 18pt,
  font-family: "New Computer Modern",
  margin: 4cm,
  frame-thickness: 1.5cm,
  frame-outset: 0cm,
  footer: none,
  conference: "Conference",
  dates: "2024",
  contacts: [],
  right-column: none,
  body,
) = {
  // Apply general style
  show: formal-general.with(
    frame-thickness: frame-thickness,
    frame-outset: frame-outset,
    font-size: font-size,
  )

  // Paper format
  set text(font: font-family, size: font-size, lang: lang)

  set page(
    paper: paper,
    margin: margin,
    footer: poster-footer(
      body: footer,
      conference: conference,
      dates: dates,
      font-size: font-size,
    ),
    footer-descent: -frame-thickness / 2,
  )

  // Math
  set math.equation(numbering: "(1)")

  // Header

  poster-header(
    title: title,
    authors: authors,
    department: department,
    contacts: contacts,
    font-size: font-size,
  )

  show: style-headings.with(font-size: font-size)

  // Body
  set par(justify: true, spacing: 0.65em)

  v(2em)

  // Poster content
  grid(
    columns: (2fr, 3fr),
    gutter: 3em,
    body, right-column,
  )
}
