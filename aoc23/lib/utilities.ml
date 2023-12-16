let read_lines (file_name : string) : string list =
  In_channel.with_open_text file_name In_channel.input_lines

(*stolen from https://stackoverflow.com/a/29957532 *)
let string_of_chars chars =
  let buf = Buffer.create 16 in
  List.iter (Buffer.add_char buf) chars;
  Buffer.contents buf

let chars_of_string s =
  let rec aux st i =
    if i == String.length s - 1 then [ st.[i] ] else st.[i] :: aux st (i + 1)
  in
  aux s 0
