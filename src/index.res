module App = {
  @react.component
  let make = () => {
    let phase = Recoil.useRecoilValue(State.phase)

    switch phase {
    | State.Title() => <Title />
    | State.Question({questions, objectCandidates}) => <Question questions objectCandidates />
    | State.GameOver({object}) => <GameOver object />
    | State.NotAvailable() => <NotAvailable />
    }
  }
}

switch ReactDOM.querySelector("#app") {
| Some(app) => ReactDOM.render(<Recoil.RecoilRoot> <App /> </Recoil.RecoilRoot>, app)

| None => ()
}
