type result = {
  data: array<array<string>>,
  errors: array<string>,
}
@val @module("papaparse") external parse: string => result = "parse"
