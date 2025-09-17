#let template(
  paper: "a1",
  lang: "en",
  title: "Title",
  authors: "Authors",
  department: "Department",
  font_size: 16pt,
  font_family: "STIX Two Text",
  margin: 4cm,
  accent_color: rgb("004d80"),
  ghost_color: rgb(0, 0, 0, 60%),
  footer: "Footer",
  conference: "Conference",
  dates: "2024",
  contacts: [],
  right-column: none,
  body,
) = {
  // Paper format
  let font_size_title = font_size * 3.0
  let font_size_authors = font_size * 1.5
  let font_size_department = font_size * 1.2

  set text(font: font_family, size: font_size, lang: lang)

  let page_footer = {
    set text(fill: ghost_color)
    grid(
      columns: (2fr, 3fr),
      gutter: 1em,
      align(right + top, contacts), align(right + top)[#conference \ #dates],
    )
  }

  set page(paper: paper, margin: margin, footer: page_footer)

  // Style

  set list(marker: text(font: "Menlo", fill: accent_color)[➤])

  // Header

  {
    set par(leading: 0.4em)
    align(center, grid(
      rows: 3,
      row-gutter: 1em,
      text(size: font_size_title, title, fill: accent_color, weight: "medium"),
      v(1em) + text(size: font_size_authors, authors, style: "italic", fill: ghost_color),
      text(size: font_size_department, department, fill: ghost_color),
    ))
  }

  // Heading

  let font_size_heading = font_size * 1.5

  show heading.where(level: 1): it => {
    v(1.5em, weak: true)
    set text(size: font_size_heading, weight: 900, fill: accent_color)
    block[
      #smallcaps(it.body) //#text(size: 1em, font: "Menlo")[✷]
    ]
    v(0.5em)
  }

  show heading.where(level: 2): it => {
    v(0.9em, weak: true)
    text(size: font_size, fill: accent_color, style: "italic", it.body + [.])
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
      text(fill: ghost_color, footer)
    },
    right-column,
  )
}
