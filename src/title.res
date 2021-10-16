open Belt

@react.component
let make = () => {
  let setState = Recoil.useSetRecoilState(State.phase)

  let onClick = _ => {
    setState(_ => State.Question({
      questions: Array.range(0, Core.questionsNum - 1),
      objectCandidates: Array.range(0, Core.objectsNum - 1),
    }))
  }
  <>
    <h1> {Data.title->React.string} </h1>
    <p> {Data.description->React.string} </p>
    <p> <button onClick> {"Start"->React.string} </button> </p>
  </>
}
