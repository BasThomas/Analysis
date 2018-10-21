# next

- **Breaking**: Nested `LengthOption` under the `Analysis` namespace. If it is accessed without type inference,
such as like `LengthOption.word`, you'll need to use `Analysis.LengthOption.word` going forward. Type inference will continue
to work as expected, allowing you to use `.word` or `.sentence`.

# [0.3.0](https://github.com/BasThomas/Analysis/releases/tag/0.3.0)

- Updated to Swift 4.2.

# [0.2.0](https://github.com/BasThomas/Analysis/releases/tag/0.2.0)

- Added `syllableCount()`, which counts the total amount of syllables of the `input`.
- Added `wordSyllables()`, which returns the syllables of every unique word.
- Added `fleschReadingEase()`, which calculates the [Flesch reading ease score](https://en.wikipedia.org/wiki/Flesch–Kincaid_readability_tests#Flesch_reading_ease).
- Added `fleschKincaidGradeLevel()`, which calculates the [Flesch-Kincaid grade level](https://en.wikipedia.org/wiki/Flesch–Kincaid_readability_tests#Flesch.E2.80.93Kincaid_grade_level).
- Dropped the deployment target from iOS `8.3` to `8.0`.

# [0.1.0](https://github.com/BasThomas/Analysis/releases/tag/0.1.0)
Initial release.
