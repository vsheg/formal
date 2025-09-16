#import "../src/formal-poster.typ": template
#import "@preview/cades:0.3.0": qr-code
#import "@preview/physica:0.9.3": *
#import "@preview/colorful-boxes:1.2.0": colorbox, outlinebox, stickybox
#import "@preview/lilaq:0.4.0" as lq

#let left_column = [

  = Introduction

  - The nature of space, time, and gravity has puzzled physicists since Newton's era. Classical mechanics and electromagnetism appeared incompatible, requiring a fundamental revision of our understanding of the physical universe.

  - Special relativity, developed in 1905, established that space and time are unified into spacetime, with the speed of light $c$ as a universal constant. This revolutionized our understanding of simultaneity, length contraction, and time dilation.
    #align(center, [$ E = m c^2 $])

  - General relativity extends these concepts to include gravity as the curvature of spacetime itself, rather than a force acting through space, providing a geometric interpretation of gravitational phenomena.

  - Experimental verification of relativistic predictions was crucial for acceptance of the theory, particularly the 1919 solar eclipse expedition that confirmed gravitational light bending.

  = Mathematical Framework

  - The spacetime interval in special relativity is invariant under Lorentz transformations, preserving the fundamental structure of spacetime:
    $ s^2 = c^2 t^2 - x^2 - y^2 - z^2 $

  - Lorentz transformations connect inertial reference frames moving with relative velocity $v$, ensuring the constancy of light speed:
    $
      t' & = gamma (t - v x / c^2) \
      x' & = gamma (x - v t)
    $
    where $gamma = 1 / sqrt(1 - v^2 / c^2)$ is the Lorentz factor.

  - General relativity is formulated using Riemannian geometry, with the Einstein field equations relating spacetime curvature to energy-momentum:
    $ G_(mu nu) = (8 pi G) / c^4 T_(mu nu) $
    where $G_(mu nu)$ is the Einstein tensor and $T_(mu nu)$ is the stress-energy tensor.

  - The metric tensor $g_(mu nu)$ describes the geometry of spacetime, determining proper time and geodesic paths of freely falling particles.

  - For weak gravitational fields, the theory reduces to Newtonian gravity with corrections that explain previously unexplained phenomena like Mercury's perihelion precession.

  - The photoelectric effect demonstrates the quantum nature of light, with photon energy given by Planck's relation:
    $ E = h nu $
    where $h$ is Planck's constant and $nu$ is the frequency of electromagnetic radiation.

  - Statistical mechanics provides the foundation for understanding thermal equilibrium and the behavior of quantum systems, with the Bose-Einstein distribution describing particles with integer spin.

  = Results and Implications

  - Derived the equivalence of mass and energy, fundamentally changing our understanding of matter and energy conservation in physical processes.

  - Predicted gravitational time dilation, gravitational redshift, and gravitational lensing---all subsequently confirmed by astronomical observations.

  - Established the theoretical foundation for modern cosmology, including solutions describing expanding universe models and black hole formation.

  #{
    set par(justify: true)
    grid(
      columns: (55%, 40%),
      gutter: 0.7em,
      align(right + top, qr-code("https://www.ias.edu", width: 4cm)),
      align(left + horizon, [Institute for \ Advanced Study \ Princeton, NJ]),
    )
  }

]

#let footer = [
  Research conducted at the Institute for Advanced Study, Princeton, with support from the
  Rockefeller Foundation and the Emergency Committee in Aid of Displaced Foreign Scholars.
  #v(0.5em)
  Work performed in collaboration with colleagues at Princeton University and the
  Kaiser Wilhelm Institute for Physics, Berlin.
]

#show: doc => template(
  paper: "a1",
  lang: "en",
  title: [On the Electrodynamics of Moving Bodies \ and the General Theory of Relativity],
  authors: [Albert Einstein],
  department: [Institute for Advanced Study, Princeton University],
  left_column: left_column,
  footer: footer,
  conference: "International Congress of Physics 1955",
  dates: "July 15-20, 1955, Princeton, New Jersey",
  contacts: [email: `einstein@ias.edu` \ Phone: `+1-609-734-8000`],
  doc,
)

#let boxed(content, title: "Title") = {
  outlinebox(title: title, radius: 2mm)[
    #content
  ]
}


#boxed(
  {
    lq.diagram(
      lq.plot(
        (0.3, 0.5, 0.8, 1.2, 2.0, 3.0, 4.0, 6.0),
        (1.72, 1.35, 1.05, 0.86, 0.55, 0.38, 0.30, 0.20),
        yerr: (0.20, 0.18, 0.15, 0.14, 0.12, 0.10, 0.10, 0.08),
        stroke: blue.darken(30%),
        mark: "star",
        mark-size: 5pt,
      ),
    )
  },
  title: [1919 Eclipse: Light Deflection vs. Solar Elongation],
)

#boxed(
  lq.diagram(
    lq.boxplot(
      stroke: blue.darken(50%),
      (-0.12, -0.05, 0.00, 0.03, 0.08, 0.15, 0.21, 0.30, 0.35, 0.48, 0.60),
      range(-1, 1),
      // Quartiles (Q1, median, Q3)
      (-0.05, 0.08, 0.30),
      // Outliers
      (-0.42, 0.72),
    ),
  ),
  title: [Deflection Measurement Variability],
)


#boxed(
  lq.diagram(
    lq.quiver(
      lq.arange(-3, 4),
      lq.arange(-3, 4),
      (x, y) => {
        let r2 = x * x + y * y + 0.25
        (-x / r2, -y / r2)
      },
    ),
  ),
  title: [Inverse-Square Gravitational Field],
)


#boxed(
  lq.diagram(
    width: 4cm,
    height: 4cm,
    lq.colormesh(
      lq.linspace(-4, 4, num: 40),
      lq.linspace(-4, 4, num: 40),
      (x, y) => -1 / (0.5 + x * x + y * y),
      map: color.map.magma,
    ),
  ),
  title: [Relativistic Time Effects],
)
