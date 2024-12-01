import gleeunit/should
import part2

pub fn part2_test() {
  let content =
    "3   4
4   3
2   5
1   3
3   9
3   3
"

  should.equal(part2.part2(content), 31)
}
