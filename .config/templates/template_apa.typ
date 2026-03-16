#set text(
  font: "Times New Roman",
  size: 12pt,
)

#set par(
  first-line-indent: (amount: 1em, all: true),
  leading: 2em,
  spacing: 2em
)

#set list(
  indent: 2em,
)

#set page(
  numbering: "1", 
  number-align: right + top,
  margin: 1in
)

#show figure: set align(center)

#show heading: set block(above: 2em, below: 2em)

#show heading.where(level: 1): it => {
  set text(12pt)
  align(center, it)
}

#show heading.where(level: 2): it => {
  set text(12pt)
  align(left, it)
}

#show heading.where(level: 3): it => {
  set text(12pt, style: "italic")
  align(left, it)
}

#show heading.where(level: 4): it => {
  set text(12pt)
  pad(left: 1em, it)
}

#show heading.where(level: 5): it => {
  set text(12pt, style: "italic")
  pad(left: 1em, it)
}

#let title = [
]

#let author = [
]

#let dept = [
]

#let class = [
]

#let prof = [
]

#let due = [
]

#set align(center + horizon)

*#title*

\

#author

#dept

#class

#prof

#due

#set align(center + horizon)

#pagebreak()

#set align(center + top)

=== *#title*

#set align(left)
