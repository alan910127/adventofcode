import argv
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn main() {
  case argv.load().arguments {
    [filename] -> {
      let assert Ok(content) = simplifile.read(filename)
      let sum = part2(content)

      io.println("Sum is: " <> int.to_string(sum))
    }
    _ -> {
      io.println_error("Usage: gleam run -m part1 -- <filename>")
    }
  }
}

pub fn part2(content) {
  let #(left, right) =
    string.split(content, on: "\n")
    |> list.filter_map(parse_line)
    |> list.unzip

  let right_dict =
    list.group(right, fn(num) { num })
    |> dict.map_values(fn(_, value) { list.length(value) })

  left
  |> list.map(fn(num) { num * result.unwrap(dict.get(right_dict, num), 0) })
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
