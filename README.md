# 🌙 Somnia

A sleep tracking iOS app built with **SwiftUI** and **Clean Architecture**.

Somnia helps you build better sleep habits: track your nights live, log past
nights manually, and watch your weekly trends take shape.

## Features

- **Live sleep tracking** — tap *Start Sleeping* at bedtime and *Wake Up* in
  the morning; a live timer shows elapsed sleep and the session survives app
  restarts
- **Morning check-in** — rate each night on a five-point scale (😫 → 😴) and
  attach notes
- **Manual logging** — backfill past nights with a date-picker form
- **History** — every night at a glance with times, duration, and quality;
  swipe to delete
- **Stats** — a 7-day Swift Charts bar chart with an 8-hour goal line, plus
  average duration, average quality, and your best night

## Architecture

Somnia follows Clean Architecture with a strict inward dependency rule:

```
Presentation ──▶ Domain ◀── Data
      │                       │
      └────── App (CompositionRoot wires everything)
```

| Layer | Contents | Depends on |
|---|---|---|
| **Domain** | Entities (`SleepSession`, `SleepStatistics`), repository protocols, use cases | Nothing (pure Swift) |
| **Data** | `JSONSleepRepository`, `UserDefaultsTrackingRepository`, DTOs | Domain protocols |
| **Presentation** | MVVM: one `@Observable` ViewModel per screen + SwiftUI views split into small components | Domain use cases |
| **App** | `SomniaApp`, `ContentView`, `CompositionRoot` | Everything (wiring only) |

Key decisions:

- **Use cases** encapsulate one business action each (`LogSleepUseCase`
  validates that wake time follows bedtime, `TrackSleepUseCase` manages the
  live session lifecycle)
- **Codable stays in the Data layer** — `SleepSessionDTO` mirrors the domain
  entity, so the on-disk format is an implementation detail
- **MVVM in the Presentation layer** — each screen has its own ViewModel
  (`TonightViewModel`, `HistoryViewModel`, `StatsViewModel`, plus
  `WakeUpViewModel` and `LogSleepViewModel` for the sheets); views stay
  declarative while form state, validation, and refresh logic live in the VM
- **ViewModels talk only to use cases**, never to repositories or views;
  swapping JSON persistence for SwiftData or HealthKit means changing one
  line in `CompositionRoot`
- **No Combine** — modern `@Observable` ViewModels observed directly by SwiftUI

## Project structure

```
test/
├── App/            SomniaApp, ContentView, CompositionRoot
├── Domain/
│   ├── Entities/
│   ├── Repositories/   (protocols — the boundary)
│   └── UseCases/
├── Data/           JSON + UserDefaults implementations
└── Presentation/
    ├── Tonight/    live tracking, wake-up flow, manual log
    ├── History/    session list
    ├── Stats/      weekly chart + stat cards
    └── Shared/     reusable components & formatting
```

## Requirements

- Xcode 26+
- iOS 26+ deployment target
- No external dependencies — 100% first-party frameworks (SwiftUI, Charts,
  Observation, Foundation)

## Getting started

```bash
git clone https://github.com/AnasNasr-afk/Somnia.git
cd Somnia
open test.xcodeproj
```

Select an iPhone simulator and press **⌘R**.

---

Built with the help of [Claude Code](https://claude.com/claude-code) 🤖
