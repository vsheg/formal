#import "/src/formal.typ": formal-text, marginalia

#let bar(height) = rect(
  width: 100%,
  height: height,
  fill: luma(82%),
  stroke: none,
)

#let body = {
  stack(
    dir: ttb,
    spacing: 3mm,
    bar(18mm),
    bar(24mm),
    bar(16mm),
  )
}

#let with-marginalia = {
  marginalia(rect(width: 100%, height: 22mm, fill: luma(72%), stroke: none))
  body
}

#let text = formal-text.with(
  authors: none,
  date: none,
  font-size: 9pt,
  page-width: 90mm,
  page-height: 120mm,
  marginalia-width: 18mm,
  marginalia-gutter: 4mm,
)

// TEST 1: Zero page margin
#{
  show: text.with(page-margin: 0mm)
  with-marginalia
  pagebreak()
}

// TEST 2: Right page margin
#{
  show: text.with(page-margin: (right: 10mm))
  with-marginalia
  pagebreak()
}

// TEST 3: Left and rest page margin
#{
  show: text.with(page-margin: (left: 5mm, rest: 5mm))
  with-marginalia
  pagebreak()
}

// TEST 4: Horizontal page margin
#{
  show: text.with(
    page-margin: (x: 3mm),
    marginalia-width: 0pt,
    marginalia-gutter: 0pt,
  )
  body
}
