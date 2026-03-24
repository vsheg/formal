#let star(
  size: 0.70em,
  arms: 8,
  tip-radius: 1.2,
  waist-radius: 0.30,
  rotation: -90deg,
  fill: black,
  stroke: none,
) = {
  let vertices = range(arms * 2).map(i => {
    let angle = rotation + i * 360deg / (arms * 2)
    let radius = if calc.even(i) {
      tip-radius
    } else {
      waist-radius
    }

    (
      50% + 50% * radius * calc.cos(angle),
      50% + 50% * radius * calc.sin(angle),
    )
  })

  box(
    width: size,
    height: size,
    polygon(
      fill: fill,
      stroke: stroke,
      ..vertices,
    ),
  )
}
