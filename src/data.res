type t = {
  version: int,
  title: string,
  start: string,
  description: string,
  yes: string,
  no: string,
  dontKnow: string,
  notAvailable: string,
  returnToTitle: string,
  gameOver: string,
  table: string,
}

let initialData = {
  version: 1,
  title: "Title",
  description: "Description",
  start: "Start",
  yes: "Yes",
  no: "No",
  dontKnow: "I don't know",
  notAvailable: "Not available",
  returnToTitle: "Return to title",
  gameOver: "I guess you imagine:",
  table: "",
}

@val @scope("JSON") external stringify: t => string = "stringify"
@val @scope("JSON") external parse: string => t = "parse"
@val @module("js-base64") external encodeURI: string => string = "encodeURI"
@val @module("js-base64") external decode: string => string = "decode"

let toBase64 = data => data->stringify->encodeURI
let fromBase64 = data => data->decode->parse
