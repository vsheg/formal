#import "/src/formal.typ": formal-text, marginalia

#set rect(
  width: 100%,
  height: 1fr,
  fill: luma(80%),
  stroke: none,
)

#let r = rect()

#let content = {
  marginalia(lorem(10))
  r
  marginalia(lorem(20))
  r
  marginalia(lorem(30))
  r
  marginalia(lorem(40))
  r
}

// TEST 1: Default marginalia width
#{
  show: formal-text
  content
  pagebreak()
}

// TEST 2: 50% marginalia width
#{
  show: formal-text.with(marginalia-width: 0.5fr)
  content
  pagebreak()
}

// TEST 3: 25% marginalia width
#{
  show: formal-text.with(marginalia-width: 0.25fr)
  content
  pagebreak()
}

// TEST 4: 10cm marginalia width
#{
  show: formal-text.with(marginalia-width: 10cm)
  content
}
