#import "/tests/text/utils.typ": sizing-case

#sizing-case(
  page-width: 90mm,
  page-height: 120mm,
  page-margin: 0mm,
)

#sizing-case(
  page-width: 90mm,
  page-height: 120mm,
  page-margin: (right: 10mm),
)

#sizing-case(
  page-width: 90mm,
  page-height: 120mm,
  page-margin: (left: 5mm, rest: 5mm),
)

#sizing-case(
  page-width: 90mm,
  page-height: 120mm,
  page-margin: (x: 3mm),
  marginalia-width: 0pt,
  marginalia-gutter: 0pt,
  note: false,
)
