#let formal-template(
  paper: "a1",
  lang: "en",
  title: "Title",
  authors: "Authors",
  department: "Department",
  font-size: 16pt,
  font-family: "New Computer Modern",
  margin: 4cm,
  accent-color: rgb("004d80"),
  ghost-color: rgb(0, 0, 0, 60%),
  footer: "Footer",
  conference: "Conference",
  dates: "2024",
  contacts: [],
  right-column: none,
  body,
) = {
  // Paper format
  let font-size-title = font-size * 3.0
  let font-size-authors = font-size * 1.5
  let font-size-department = font-size * 1.2

  set text(font: font-family, size: font-size, lang: lang)

  let page-footer = {
    set text(fill: ghost-color)
    grid(
      columns: (2fr, 3fr),
      gutter: 1em,
      align(right + top, contacts), align(right + top)[#conference \ #dates],
    )
  }

  set page(paper: paper, margin: margin, footer: page-footer)

  // Style

  set list(marker: text(font: "Menlo", fill: accent-color)[➤])

  // Header

  {
    // Decrease line spacing for main header
    set par(leading: 0.4em)

    // Authors, affiliation, ...
    set align(center)

    grid(
      rows: 3,
      row-gutter: 1em,
      text(size: font-size-title, fill: accent-color, weight: "medium", title),
      // Empty line
      none,
      text(size: font-size-authors, style: "italic", fill: ghost-color, authors),
      text(size: font-size-department, fill: ghost-color, department),
    )
  }

  // Heading

  let font_size_heading = font-size * 1.5

  show heading.where(level: 1): it => {
    v(1.5em, weak: true)
    set text(size: font_size_heading, weight: 900, fill: accent-color)
    block[
      #smallcaps(it.body)
    ]
    v(0.5em)
  }

  show heading.where(level: 2): it => {
    v(0.9em, weak: true)
    text(size: font-size, fill: accent-color, style: "italic", it.body + [.])
  }

  v(5em, weak: true)

  // Body
  set par(justify: true)
  show par: set block(spacing: 0.65em)

  // Math
  set math.equation(numbering: "(1)")

  // Poster content
  grid(
    columns: (2fr, 3fr),
    gutter: 3em,
    {
      body
      text(fill: ghost-color, footer)
    },
    right-column,
  )
}
