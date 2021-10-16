open Belt

@react.component
let make = (~object, ()) => {
  let setState = Recoil.useSetRecoilState(State.phase)

  let onClick = _ => setState(_ => State.Title())

  <>
    <h1> {Data.title->React.string} </h1>
    <h2> {Data.gameOver->React.string} {Core.objectTexts->Array.getExn(object)->React.string} </h2>
    <button onClick> {Data.returnToTitle->React.string} </button>
  </>
}
