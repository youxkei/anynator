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
@val @module("js-base64") external fromUint8Array: (string, bool) => string = "fromUint8Array"
@val @module("js-base64") external toUint8Array: string => string = "toUint8Array"
@val @module("pako") external gzip: string => string = "gzip"
@val @module("pako") external ungzip: (string, {"to": string}) => string = "ungzip"

let toBase64 = data => data->stringify->gzip->fromUint8Array(true)
let fromBase64 = data => data->toUint8Array->ungzip({"to": "string"})->parse
