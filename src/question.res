open Belt

type choice = Yes | No | DontKnow

@react.component
let make = (~data: Data.t, ~core, ~questions, ~objectCandidates, ()) => {
  let setState = Recoil.useSetRecoilState(State.phase)

  let question = core->Core.calculateLowestEntropyQuestion(questions, objectCandidates)

  let onClick = (choice, _) => {
    let nextQuestions = questions->Array.keep(q => q != question)
    let nextObjectCandidates = objectCandidates->Array.keep(object => {
      switch choice {
      | Yes => core.answerTable->Array.getExn(question)->Array.getExn(object) == 1
      | No => core.answerTable->Array.getExn(question)->Array.getExn(object) == 0
      | DontKnow => true
      }
    })

    switch (nextQuestions, nextObjectCandidates) {
    | ([], []) => setState(_ => State.NotAvailable())
    | ([], _) =>
      setState(_ => State.GameOver({core: core, object: nextObjectCandidates->Array.getExn(0)}))
    | (_, [object]) => setState(_ => State.GameOver({core: core, object: object}))
    | (_, _) =>
      setState(_ => State.Question({
        core: core,
        questions: nextQuestions,
        objectCandidates: nextObjectCandidates,
      }))
    }
  }

  <>
    <h1> {data.title->React.string} </h1>
    <h2> {core.questionTexts->Array.getExn(question)->React.string} </h2>
    <p>
      <button onClick={onClick(Yes)}> {data.yes->React.string} </button>
      <button onClick={onClick(No)}> {data.no->React.string} </button>
      <button onClick={onClick(DontKnow)}> {data.dontKnow->React.string} </button>
    </p>
  </>
}
