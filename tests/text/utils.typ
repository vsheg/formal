#import "/src/formal.typ": formal-text, marginalia

#let paragraph(height) = rect(
  width: 100%,
  height: height,
  fill: luma(82%),
  stroke: none,
)

#let body-fill(heights: (18mm, 24mm, 16mm)) = stack(
  dir: ttb,
  spacing: 3mm,
  ..heights.map(paragraph),
)

#let marginalia-fill(height: 22mm) = rect(
  width: 100%,
  height: height,
  fill: luma(72%),
  stroke: none,
)

#let sizing-case(
  body-heights: (18mm, 24mm, 16mm),
  note: true,
  note-height: 22mm,
  ..settings,
) = {
  pagebreak(weak: true)
  state("note-descent", (:)).update((:))

  formal-text.with(
    authors: none,
    date: none,
    font-size: 9pt,
    page-margin: 5mm,
    marginalia-width: 18mm,
    marginalia-gutter: 4mm,
    ..settings.named(),
  )([
    #if note {
      marginalia(marginalia-fill(height: note-height))
    }
    #body-fill(heights: body-heights)
  ])
}
