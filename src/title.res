open Belt

@react.component
let make = (~data: Data.t) => {
  let setState = Recoil.useSetRecoilState(State.phase)

  let onClick = _ => {
    let core = Core.new(data)

    setState(_ => State.Question({
      core: core,
      questions: Array.range(0, core.questionsNum - 1),
      objectCandidates: Array.range(0, core.objectsNum - 1),
    }))
  }
  <>
    <h1> {data.title->React.string} </h1>
    <p> {data.description->React.string} </p>
    <p> <button onClick> {data.start->React.string} </button> </p>
  </>
}
