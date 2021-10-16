@react.component
let make = () => {
  let setState = Recoil.useSetRecoilState(State.phase)

  let onClick = _ => setState(_ => State.Title())

  <>
    <h1> {Data.title->React.string} </h1>
    <h2> {Data.notAvailable->React.string} </h2>
    <button onClick> {Data.returnToTitle->React.string} </button>
  </>
}
