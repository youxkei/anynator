open Belt

type choice = Yes | No | DontKnow

@react.component
let make = (~questions, ~objectCandidates, ()) => {
  let setState = Recoil.useSetRecoilState(State.phase)

  let question = questions->Core.calculateLowestEntropyQuestion(objectCandidates)

  let onClick = (choice, _) => {
    let nextQuestions = questions->Array.keep(q => q != question)
    let nextObjectCandidates = objectCandidates->Array.keep(object => {
      switch choice {
      | Yes => Core.answerTable->Array.getExn(question)->Array.getExn(object) == 1
      | No => Core.answerTable->Array.getExn(question)->Array.getExn(object) == 0
      | DontKnow => true
      }
    })

    switch (nextQuestions, nextObjectCandidates) {
    | ([], []) => setState(_ => State.NotAvailable())
    | ([], _) => setState(_ => State.GameOver({object: nextObjectCandidates->Array.getExn(0)}))
    | (_, [object]) => setState(_ => State.GameOver({object: object}))
    | (_, _) =>
      setState(_ => State.Question({
        questions: nextQuestions,
        objectCandidates: nextObjectCandidates,
      }))
    }
  }

  <>
    <h1> {Data.title->React.string} </h1>
    <h2> {Core.questionTexts->Array.getExn(question)->React.string} </h2>
    <p>
      <button onClick={onClick(Yes)}> {Data.yes->React.string} </button>
      <button onClick={onClick(No)}> {Data.no->React.string} </button>
      <button onClick={onClick(DontKnow)}> {Data.dontKnow->React.string} </button>
    </p>
  </>
}
