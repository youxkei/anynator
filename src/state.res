type phase =
  | Title(unit)
  | Question({core: Core.t, questions: array<int>, objectCandidates: array<int>})
  | GameOver({core: Core.t, object: int})
  | NotAvailable(unit)

let phase = Recoil.atom({
  key: "phase",
  default: Title(),
})
