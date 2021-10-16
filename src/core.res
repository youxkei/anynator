open Belt

let log2 = value =>
  if value == 0.0 {
    0.0
  } else {
    Js.Math.log2(value)
  }

let objectTexts = Data.data->Array.getExn(0)->Array.sliceToEnd(1)
let objectsNum = objectTexts->Array.length

let questionTexts = Data.data->Array.sliceToEnd(1)->Array.map(row => row->Array.getExn(0))
let questionsNum = questionTexts->Array.length

let answerTable =
  Data.data
  ->Array.sliceToEnd(1)
  ->Array.map(row => {
    row->Array.sliceToEnd(1)->Array.map(answer => answer->Int.fromString->Option.getExn)
  })

let getYesNoObjectCandidates = (question, objectCandidates) => {
  objectCandidates->Array.reduce(([], []), ((yesCandidates, noCandidates), object) => {
    if answerTable->Array.getExn(question)->Array.getExn(object) == 1 {
      let _ = yesCandidates->Js.Array2.push(object)
    } else {
      let _ = noCandidates->Js.Array2.push(object)
    }

    (yesCandidates, noCandidates)
  })
}

let calculateQuestionEntropy = (question, objectCandidates) => {
  let (yesCandidates, noCandidates) = question->getYesNoObjectCandidates(objectCandidates)

  let yesCandidatesNum = yesCandidates->Array.length->Int.toFloat
  let noCandidatesNum = noCandidates->Array.length->Int.toFloat
  let objectCandidatesNum = objectCandidates->Array.length->Int.toFloat

  (yesCandidatesNum *. log2(yesCandidatesNum) +. noCandidatesNum *. log2(noCandidatesNum)) /.
    objectCandidatesNum
}

let calculateLowestEntropyQuestion = (questions, objectCandidates) => {
  let (question, _) =
    questions
    ->Array.map(question => {
      (question, question->calculateQuestionEntropy(objectCandidates))
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
