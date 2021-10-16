type phase =
  | Title(unit)
  | Question({questions: array<int>, objectCandidates: array<int>})
  | GameOver({object: int})
  | NotAvailable(unit)

let phase = Recoil.atom({
  key: "phase",
  default: Title(),
})
