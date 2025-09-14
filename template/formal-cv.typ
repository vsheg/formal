#import "../src/formal-cv.typ": *
#import "@preview/fontawesome:0.6.0": *

#show: formal-cv.with(
  name: [Albert Einstein],
  prefix: [Dr.],
  title: [Theoretical Physicist. Nobel Laureate],
  location: [Princeton, New Jersey, USA],
  contacts: (
    link(
      "mailto:albert@einstein.edu",
      ghost(fa-icon("envelope", size: 0.75em)) + h(0.5em) + "albert@einstein.edu",
    ),
    link(
      "tel:+1-999-XXX-YYYY",
      ghost(fa-icon("phone", size: 0.75em)) + h(0.5em) + "+1-999-XXX-YYYY",
    ),
  ),
  links: (
    link(
      "https://alberteinstein.com",
      ghost(fa-icon("globe", solid: true, size: 0.75em)) + h(0.5em) + "Web",
    ),
    link("https://en.wikipedia.org/wiki/Albert_Einstein", "Wikipedia"),
    link("https://www.nobelprize.org/prizes/physics/1921/einstein", "Nobel Prize 1921"),
  ),
)

#summary[
  Theoretical physicist with revolutionary contributions to modern physics spanning over 5 decades. Developed the theory of relativity, explained the photoelectric effect, and made fundamental contributions to quantum mechanics and statistical mechanics. Nobel Prize laureate and Fellow of the Royal Society. Dedicated advocate for civil rights, pacifism, and scientific internationalism.
]

== Expertise

#let skills = (
  "Physics": (
    [Relativity],
    [Quantum Mechanics],
    [Statistical Mechanics],
    [Cosmology],
    [Field Theory],
  ),
  "Math": (
    [Tensors],
    [Differential Geometry],
    [Complex Analysis],
    [Probability Theory],
    [Group Theory],
  ),
  "Music": (
    [Violin],
    [Piano],
    [Chamber Music],
    [Classical Music],
  ),
  "Other": (
    [Scientific Method],
    [Determinism],
    [Causality],
    [Pacifism],
    [Civil Rights],
  ),
)

#keyword-grid(skills, n-rows: 5, columns: (2.2fr, 2.0fr, 2.0fr, 2.0fr), column-gutter: 0.5em)

= Experience

- #list-item(
    title: [Professor],
    organization: [Institute for Advanced Study],
    organization-comment: [School of Mathematics],
    dates: [Oct '33 -- Apr '55],
    location: [Princeton, NJ],
  )
  - Developed unified field theory attempting to unify electromagnetic and gravitational forces, laying groundwork for modern theories of everything.

  - Mentored numerous young physicists who became leading figures in theoretical physics, establishing Princeton as a premier center for theoretical research.

  - Continued work on quantum mechanics foundations, famously challenging quantum theory with the EPR paradox and "God does not play dice" philosophy.

  - Collaborated with colleagues on cosmological models and contributed to understanding of gravitational phenomena.

  - Advocated for international cooperation and played key role in establishing scientific refugee programs during WWII.

- #list-item(
    title: [Professor of Theoretical Physics],
    organization: [Princeton University],
    dates: [Oct '33 -- Oct '33],
    location: [Princeton, NJ],
  )
  - Brief appointment before joining Institute for Advanced Study.

- #list-item(
    title: [Professor],
    organization: [Kaiser Wilhelm Institute],
    organization-comment: [Director of Physics],
    dates: [Apr '14 -- Dec '32],
    location: [Berlin, Germany],
  )
  - Formulated general theory of relativity (1915), revolutionizing understanding of gravity, space, and time.

  - Derived field equations describing curvature of spacetime, predicting phenomena later confirmed: gravitational lensing, Mercury's perihelion precession, gravitational redshift.

  - Received Nobel Prize in Physics (1921) for explanation of photoelectric effect and contributions to theoretical physics.

  - Made contributions to quantum theory including photon concept, wave-particle duality, and Bose-Einstein statistics.

  - Developed cosmological models with cosmological constant, laying foundation for modern Big Bang theory.

- #list-item(
    title: [Professor of Theoretical Physics],
    organization: [ETH Zurich],
    dates: [Oct '12 -- Apr '14],
    location: [Zurich, Switzerland],
  )
  - Continued development of general relativity theory while teaching advanced physics courses.

  - Conducted research on specific heats of solids and developed Einstein model for lattice vibrations.

  - Established international reputation leading to invitation to join Prussian Academy of Sciences in Berlin.

- #list-item(
    title: [Associate Professor],
    organization: [University of Prague],
    dates: [Apr '11 -- Oct '12],
    location: [Prague, Austria-Hungary],
  )
  - Further developed special relativity applications and began formulating general relativity principles.

  - Conducted research on statistical mechanics and thermodynamics of radiation.

- #list-item(
    title: [Assistant Professor],
    organization: [University of Zurich],
    dates: [May '09 -- Apr '11],
    location: [Zurich, Switzerland],
  )
  - First academic appointment while continuing work at Swiss Patent Office.

  - Published papers on quantum theory of radiation and specific heats.

= Education

- #list-item(
    title: [Physics],
    title-comment: [PhD],
    organization: [University of Zurich],
    dates: [Jan '06],
  )
  #small[_Dissertation_: A New Determination of Molecular Dimensions]

- #list-item(
    title: [Mathematics and Physics],
    title-comment: [Diploma],
    organization: [Swiss Federal Polytechnic],
    organization-comment: [ETH Zurich],
    dates: [Jul '00],
  )
  #small[_Thesis_: Consequences of Capillarity Phenomena]
