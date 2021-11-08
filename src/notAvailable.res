@react.component
let make = (~data: Data.t) => {
  let setState = Recoil.useSetRecoilState(State.phase)

  let onClick = _ => setState(_ => State.Title())

  <>
    <h1> {data.title->React.string} </h1>
    <h2> {data.notAvailable->React.string} </h2>
    <button onClick> {data.returnToTitle->React.string} </button>
  </>
}
