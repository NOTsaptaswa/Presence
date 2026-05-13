# Presence

Presence is a premium privacy-first behavioral intelligence app for iOS built with SwiftUI.

The app helps users better understand:

* Sleep
* Recovery
* Focus
* Screen Time
* Behavioral Consistency
* Digital Wellness Patterns

Presence combines ideas inspired by Apple Health, Apple Journal, Oura, and Whoop into a calm, modern, Apple-style experience focused on behavioral awareness and self-understanding.

---

# Current Status

⚠️ Presence is currently under active development and is not yet production complete.

The project is transitioning from a prototype architecture into a fully production-grade behavioral analytics platform.

Many systems are already implemented, while several advanced production features are still being refined, tested, and optimized.

---

# Core Philosophy

Presence is designed around:

* Privacy-first architecture
* Local-first data processing
* Calm and minimal UI
* On-device behavioral intelligence
* Apple ecosystem integration
* Human-centered analytics

User data is intended to remain primarily on-device whenever possible.

---

# Tech Stack

## Frontend

* SwiftUI
* Swift Charts
* WidgetKit

## Architecture

* MVVM
* Modular folder structure
* Async/Await
* SwiftData

## System Integrations

* HealthKit
* DeviceActivity
* FamilyControls
* Notifications

---

# Current Features

## Onboarding System

* Multi-step onboarding flow
* Privacy education screens
* Permission onboarding
* Persistent onboarding state

## Dashboard

* Behavioral analytics dashboard
* Recovery insights
* Sleep tracking
* Focus metrics
* Daily summaries
* Smooth scrolling experience

## Analytics

* Trend analysis
* Behavioral scoring systems
* Consistency tracking
* Interactive charts

## Widgets

* WidgetKit integration
* Behavioral summary widgets
* Recovery widgets
* Shared app/widget architecture

## Settings

* Health permission management
* Screen Time authorization handling
* Notification preferences
* Appearance preferences
* Data export groundwork

## Behavioral Intelligence

* Recovery scoring
* Focus scoring
* Consistency scoring
* Insight generation system
* Correlation-based behavioral observations

---

# Architecture Highlights

Presence uses a modular production-oriented architecture.

Example structure:

```text
Presence
│
├── App
├── Core
│   ├── Components
│   ├── Motion
│   ├── Theme
│   └── Utilities
│
├── Features
│   ├── Dashboard
│   ├── Analytics
│   ├── Insights
│   ├── Settings
│   ├── Notifications
│   └── Onboarding
│
├── Services
│   ├── AI
│   ├── HealthKit
│   ├── ScreenTime
│   ├── Notifications
│   └── Settings
│
└── Widgets
```

---

# Production Work In Progress

The following systems are currently under active refinement:

* Real HealthKit behavioral pipelines
* Screen Time integration improvements
* Widget synchronization
* Behavioral intelligence engine
* Scoring calibration
* Permission edge-case handling
* Production optimization
* Accessibility improvements
* Real-device performance testing
* App Store preparation

---

# Development Goals

Presence aims to become:

* A fully production-ready iOS behavioral intelligence platform
* A privacy-focused alternative to cloud-heavy wellness apps
* A premium Apple-style analytics experience
* A scalable modular SwiftUI architecture project

---

# Current Development Focus

The project is currently focused on:

1. Replacing remaining mock data with real system data
2. Refining HealthKit integration
3. Improving WidgetKit synchronization
4. Production-level testing on real iPhones
5. Optimizing scoring and insight generation
6. Hardening permission and error handling
7. UI/UX refinement and performance optimization

---

# Requirements

* iOS 26+
* Xcode 26+
* Swift 6
* Physical iPhone recommended for full HealthKit and Screen Time testing

---

# Important Notes

Some features may still:

* use placeholder logic
* require additional permissions
* behave differently without Apple Watch data
* evolve during production refinement

This repository reflects an actively evolving product architecture and engineering process.

---

# Future Plans

Planned future improvements include:

* Advanced behavioral correlations
* Better AI-generated summaries
* Enhanced recovery modeling
* Improved widget ecosystem
* Expanded personalization
* Production analytics refinement
* App Store launch preparation

---

# Disclaimer

Presence is not a medical application.

The app is intended for wellness insights and behavioral awareness only and should not be used for medical diagnosis or treatment.

---

# Author

Built by Saptaswa Nandi.

Currently under active production-level development.
