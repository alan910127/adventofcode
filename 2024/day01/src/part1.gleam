import argv
import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

pub fn main() {
  case argv.load().arguments {
    [filename] -> {
      let assert Ok(content) = simplifile.read(filename)
      let sum = part1(content)

      io.println("Sum is: " <> int.to_string(sum))
    }
    _ -> {
      io.println_error("Usage: gleam run -m part1 -- <filename>")
    }
  }
}

pub fn part1(content) {
  string.split(content, on: "\n")
  |> list.filter_map(parse_line)
  |> list.unzip
  |> fn(nums) {
    #(list.sort(nums.0, int.compare), list.sort(nums.1, int.compare))
  }
  |> fn(nums) { list.zip(nums.0, nums.1) }
  |> list.map(fn(pair) { int.absolute_value(pair.0 - pair.1) })
  |> int.sum
}

fn parse_line(line) {
  case string.split_once(line, "   ") {
    Ok(#(left, right)) -> {
      let assert Ok(left) = int.parse(left)
      let assert Ok(right) = int.parse(right)
      Ok(#(left, right))
    }
    Error(e) -> Error(e)
  }
}
