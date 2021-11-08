@get external value: Js.t<'a> => string = "value"

@react.component
let make = (~urlPrefix) => {
  let (data, setData) = React.useState(() => Data.initialData)
  let (url, setURL) = React.useState(() => "")

  let {
    title,
    description,
    start,
    yes,
    no,
    dontKnow,
    notAvailable,
    returnToTitle,
    gameOver,
    table,
  } = data

  <>
    <p>
      {"title:"->React.string}
      <input
        value=title
        onChange={e => {
          setData(_ => {
            ...data,
            title: e->ReactEvent.Form.target->value,
          })
        }}
      />
    </p>
    <p>
      {"description:"->React.string}
      <textarea
        value=description
        onChange={e => {
          setData(_ => {
            ...data,
            description: e->ReactEvent.Form.target->value,
          })
        }}
      />
    </p>
    <p>
      {"start:"->React.string}
      <input
        value=start
        onChange={e => {
          setData(_ => {
            ...data,
            start: e->ReactEvent.Form.target->value,
          })
        }}
      />
    </p>
    <p>
      {"yes:"->React.string}
      <input
        value=yes
        onChange={e => {
          setData(_ => {
            ...data,
            yes: e->ReactEvent.Form.target->value,
          })
        }}
      />
    </p>
    <p>
      {"no:"->React.string}
      <input
        value=no
        onChange={e => {
          setData(_ => {
            ...data,
            no: e->ReactEvent.Form.target->value,
          })
        }}
      />
    </p>
    <p>
      {"dontKnow:"->React.string}
      <input
        value=dontKnow
        onChange={e => {
          setData(_ => {
            ...data,
            dontKnow: e->ReactEvent.Form.target->value,
          })
        }}
      />
    </p>
    <p>
      {"notAvailable:"->React.string}
      <input
        value=notAvailable
        onChange={e => {
          setData(_ => {
            ...data,
            notAvailable: e->ReactEvent.Form.target->value,
          })
        }}
      />
    </p>
    <p>
      {"returnToTitle:"->React.string}
      <input
        value=returnToTitle
        onChange={e => {
          setData(_ => {
            ...data,
            returnToTitle: e->ReactEvent.Form.target->value,
          })
        }}
      />
    </p>
    <p>
      {"gameOver:"->React.string}
      <input
        value=gameOver
        onChange={e => {
          setData(_ => {
            ...data,
            gameOver: e->ReactEvent.Form.target->value,
          })
        }}
      />
    </p>
    <p>
      {"table:"->React.string}
      <textarea
        value=table
        onChange={e => {
          setData(_ => {
            ...data,
            table: e->ReactEvent.Form.target->value,
          })
        }}
      />
    </p>
    <p>
      <button
        onClick={_ => {
          setURL(_ => data->Data.toBase64)
        }}>
        {"make"->React.string}
      </button>
    </p>
    {if url != "" {
      <a href={`${urlPrefix}${url}`} target="_blank"> {`${urlPrefix}${url}`->React.string} </a>
    } else {
      React.null
    }}
  </>
}
