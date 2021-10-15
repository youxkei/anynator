@val external window: Dom.window = "window"

switch ReactDOM.querySelector("#app") {
| Some(app) => ReactDOM.render(<p>{ "Hello, world!"->React.string }</p>, app)

| None => ()
}
