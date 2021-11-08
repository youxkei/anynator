@val @scope(("window", "location")) external hash: string = "hash"

module App = {
  @react.component
  let make = () => {
    let phase = Recoil.useRecoilValue(State.phase)

    if hash != "" {
      let data = hash->Js.String2.sliceToEnd(~from=1)->Data.fromBase64

      switch phase {
      | State.Title() => <Title data />
      | State.Question({core, questions, objectCandidates}) =>
        <Question data core questions objectCandidates />
      | State.GameOver({core, object}) => <GameOver data core object />
      | State.NotAvailable() => <NotAvailable data />
      }
    } else {
      <Maker urlPrefix="https://anynator.netlify.app/#" />
    }
  }
}

switch ReactDOM.querySelector("#app") {
| Some(app) => ReactDOM.render(<Recoil.RecoilRoot> <App /> </Recoil.RecoilRoot>, app)

| None => ()
}
