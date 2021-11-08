open Belt

let log2 = value =>
  if value == 0.0 {
    0.0
  } else {
    Js.Math.log2(value)
  }

type t = {
  objectTexts: array<string>,
  objectsNum: int,
  questionTexts: array<string>,
  questionsNum: int,
  answerTable: array<array<int>>,
}

let new = (data: Data.t) => {
  let table = (data.table->Papa.parse).data
  Js.log(table)

  let objectTexts = table->Array.getExn(0)->Array.sliceToEnd(1)
  let objectsNum = objectTexts->Array.length

  let questionTexts = table->Array.sliceToEnd(1)->Array.map(row => row->Array.getExn(0))
  let questionsNum = questionTexts->Array.length

  let answerTable =
    table
    ->Array.sliceToEnd(1)
    ->Array.map(row => {
      row->Array.sliceToEnd(1)->Array.map(answer => answer->Int.fromString->Option.getExn)
    })

  {
    objectTexts: objectTexts,
    objectsNum: objectsNum,
    questionTexts: questionTexts,
    questionsNum: questionsNum,
    answerTable: answerTable,
  }
}

let getYesNoObjectCandidates = (core, question, objectCandidates) => {
  objectCandidates->Array.reduce(([], []), ((yesCandidates, noCandidates), object) => {
    if core.answerTable->Array.getExn(question)->Array.getExn(object) == 1 {
      let _ = yesCandidates->Js.Array2.push(object)
    } else {
      let _ = noCandidates->Js.Array2.push(object)
    }

    (yesCandidates, noCandidates)
  })
}

let calculateQuestionEntropy = (core, question, objectCandidates) => {
  let (yesCandidates, noCandidates) = core->getYesNoObjectCandidates(question, objectCandidates)

  let yesCandidatesNum = yesCandidates->Array.length->Int.toFloat
  let noCandidatesNum = noCandidates->Array.length->Int.toFloat
  let objectCandidatesNum = objectCandidates->Array.length->Int.toFloat

  (yesCandidatesNum *. log2(yesCandidatesNum) +. noCandidatesNum *. log2(noCandidatesNum)) /.
    objectCandidatesNum
}

let calculateLowestEntropyQuestion = (core, questions, objectCandidates) => {
  let (question, _) =
    questions
    ->Array.map(question => {
      (question, core->calculateQuestionEntropy(question, objectCandidates))
    })
    ->Js.Array2.sortInPlaceWith(((_, leftEntropy), (_, rightEntropy)) =>
      if leftEntropy -. rightEntropy < 0.0 {
        -1
      } else {
        1
      }
    )
    ->Array.getExn(0)

  question
}
