#import "@preview/formal:0.2.0": formal-doc, margin, note

#show: formal-doc.with(
  authors: [J. Willard Gibbs],
  date: [October 1898],
  font-size: 9pt,
)

= On the Equilibrium of Heterogeneous Substances

The conditions which determine the equilibrium of a body are of two kinds: those
relating to its internal state, and those which concern its relations to external
bodies. Thermodynamic equilibrium obtains when no spontaneous change can
diminish the energy of the system at constant entropy, or equivalently, when no change
can increase the entropy at constant energy @gibbs1878.

#margin[
  Fundamental criterion
][
  A system attains equilibrium when its thermodynamic potential reaches a minimum
  consistent with the imposed constraints. The appropriate potential depends on which
  variables --- temperature, pressure, or volume --- are held fixed by the
  surroundings.
]

== The fundamental equation
For a homogeneous body of variable composition, the energy $U$ is expressed as a
function of entropy $S$, volume $V$, and the masses $m_1, m_2, dots, m_n$ of the
independently variable components. The total differential takes the form of @fundamental,
where $T$ is the absolute temperature, $p$ the pressure, and $mu_j$ the chemical
potential of the $j$-th component.

$
  dif U = T dif S - p dif V + sum_(j=1)^n mu_j dif m_j
$ <fundamental>

#note(title: [Example])[
  Consider a vessel containing water and steam in contact. At equilibrium the
  temperature and pressure are uniform throughout, and the chemical potential of
  water is equal in both phases. Any transfer of mass between phases leaves the total
  energy unchanged to first order, which is precisely the condition @fundamental
  encodes.
]

The quantity $mu_j$ governs the tendency of the $j$-th component to pass from one
phase to another. Equality of chemical potentials across coexisting phases is therefore
the necessary and sufficient condition for material equilibrium @clausius1865. That
condition is not merely formal: it determines solubility limits, vapor composition, and
the direction of every diffusive process.

#margin[
  Reading equation @fundamental
][
  Each term pairs an intensive quantity (temperature, pressure, chemical potential)
  with the differential of its conjugate extensive variable (entropy, volume, mass).
  The equation thus encodes every reversible exchange of energy the system can undergo.
]

== Thermodynamic potentials
When temperature rather than entropy is the controlled variable, it is advantageous to
pass from the energy $U$ to the free energy $F = U - T S$, whose minimum at constant
$T$ and $V$ characterizes equilibrium. For processes at constant $T$ and $p$, the Gibbs
energy $G = U - T S + p V$ is the natural quantity @gibbs1878.

#note(title: [Practical observation])[
  The choice of potential is dictated by the experimental arrangement. In a sealed
  calorimeter one controls volume; in an open reaction vessel one controls pressure.
  Selecting the wrong potential obscures the equilibrium condition rather than
  clarifying it. When in doubt, identify which variables the surroundings impose before
  writing any equation.
]

#table(
  columns: 4,
  [Potential], [Natural variables], [Eq. condition], [Typical context],

  [Internal energy $U$],
  [$S, V, m_j$],
  [Minimum at constant $S$ and $V$],
  [Isolated or adiabatic systems],

  [Helmholtz free energy $F$],
  [$T, V, m_j$],
  [Minimum at constant $T$ and $V$],
  [Closed vessels at fixed temperature],

  [Gibbs energy $G$],
  [$T, p, m_j$],
  [Minimum at constant $T$ and $p$],
  [Open-atmosphere reactions and phase diagrams],
)

== Conditions for stable equilibrium
It is not sufficient that the energy be stationary; it must be a minimum. The second
variation of $U$ with respect to all admissible displacements must be positive, which
requires that the heat capacity at constant volume be positive, that the isothermal
compressibility be positive, and that analogous inequalities hold for every chemical
degree of freedom @maxwell1871.

A system that satisfies only the first-order conditions may rest in unstable
equilibrium --- a state from which an infinitesimal fluctuation precipitates a finite
change. The spinodal curve, within which these stability conditions fail, marks the
boundary of the region where a homogeneous phase cannot persist.

The same reasoning extends to systems of many components and many phases. The phase
rule, which fixes the number of independent intensive variables as $f = n - r + 2$
where $n$ is the number of components and $r$ the number of coexisting phases, is a
direct consequence of the equilibrium conditions: it counts the degrees of freedom that
remain after all equalities of temperature, pressure, and chemical potential have been
imposed.

#bibliography(
  title: [References],
  style: "apa",
  "refs.bib",
)
