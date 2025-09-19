#show: template.with(
  name: [Albert Einstein],
  prefix: [Prof. Dr.],
  contacts: (
    link(
      "mailto:einstein@ias.edu",
      ghost(fa-icon("envelope", size: 0.75em)) + h(0.5em) + "einstein@ias.edu",
    ),
    link(
      "tel:+1-609-734-8000",
      ghost(fa-icon("phone", size: 0.75em)) + h(0.5em) + "+1-609-734-8000",
    ),
  ),
  title: [Theoretical Physicist. Nobel Laureate],
  location: [Princeton, New Jersey, USA],
  links: (
    link(
      "https://www.ias.edu",
      ghost(fa-icon("globe", solid: true, size: 0.75em))
        + h(0.5em)
        + "Institute for Advanced Study",
    ),
    link("https://royalsociety.org/people/albert-einstein-11907", "Royal Society Fellow"),
    link("https://www.nobelprize.org/prizes/physics/1921/einstein", "Nobel Prize 1921"),
  ),
)

#set page(margin: 3cm)
#set text(hyphenate: true)
#set par(justify: true)

#v(0.6fr)

#{
  set align(center)
  [= Cover Letter]
}
