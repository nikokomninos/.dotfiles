#set text(
  font: "New Computer Modern",
)

#set par(
  first-line-indent: (amount: 1em, all: true),
  leading: 1.5em,
  spacing: 1.5em,
)

#show figure: set align(center)

#let title = [
  Title
]

#let author = [
  Nikolaos Komninos
]

#let class = ""

#set align(center)

#title \
#if class == "" {
  author
} else {
  author + "- " + class
}

#set align(left)
\
