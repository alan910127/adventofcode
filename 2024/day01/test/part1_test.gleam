import gleeunit/should
import part1

pub fn part1_test() {
  let content =
    "3   4
4   3
2   5
1   3
3   9
3   3
"

  should.equal(part1.part1(content), 11)
}
