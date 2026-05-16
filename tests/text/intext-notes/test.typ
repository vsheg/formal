#import "/src/formal.typ": formal-text, note

#let r = lorem(55)

#let bar(height) = rect(
  width: 100%,
  height: height,
  fill: luma(82%),
  stroke: none,
)

#let text = formal-text.with(
  authors: none,
  date: none,
  font-size: 9pt,
)

#let content = {
  bar(10mm)

  note[
    Compact note in the text flow.
  ]

  bar(12mm)

  note(title: [Method])[
    Titled note keeps its inline heading.
  ]
}

#let two-column-note = {
  bar(10mm)

  note(cols: 2, title: [Checks])[
    #r

    #r

    #r
  ]
}

// TEST 1: Compact page without marginalia
#{
  show: text.with(
    page-width: 90mm,
    page-height: 120mm,
    page-margin: 8mm,
    marginalia-width: 0pt,
    marginalia-gutter: 0pt,
  )
  content
  pagebreak()
}

// TEST 2: Compact page with fixed marginalia width
#{
  show: text.with(
    page-width: 90mm,
    page-height: 120mm,
    page-margin: 8mm,
    marginalia-width: 18mm,
    marginalia-gutter: 4mm,
  )
  content
  pagebreak()
}

// TEST 3: Larger page with proportional marginalia width
#{
  show: text.with(
    page-width: 140mm,
    page-height: 190mm,
    page-margin: 10mm,
    marginalia-width: 0.25fr,
    marginalia-gutter: 5mm,
  )
  content
  two-column-note
}
