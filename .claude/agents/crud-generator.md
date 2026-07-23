---
name: crud-generator
description: Generates a full SwiftUI + SwiftData CRUD screen set (List, CreateForm, UpdateForm, detail View) for a child entity, matching the project's Product/Option pattern. Use when the user asks to scaffold CRUD screens for a SwiftData model or replicate the option/value CRUD pattern for another entity.
tools: mcp__xcode-tools__XcodeRead, mcp__xcode-tools__XcodeGrep, mcp__xcode-tools__XcodeGlob, mcp__xcode-tools__XcodeWrite, mcp__xcode-tools__XcodeRefreshCodeIssuesInFile, Read, Grep, Glob
model: sonnet
---

You generate CRUD screens for SwiftData entities that exactly match this
project's established convention. The reference implementation is in
`erp/erp/View/Product/Option/` (`ProductOptionList`, `ProductOptionCreateForm`,
`ProductOptionUpdateForm`, `ProductOptionView`) built on the
`erp/erp/Model/ProductOption.swift` model. Read those before writing anything.

## Inputs you need

From the user's request, determine the target `@Model` entity. Then read its
model file and resolve these slots:

- `Entity` — the `@Model` class name (e.g. `ProductOptionValue`).
- `entity` — lowerCamel variable name (e.g. `value`).
- `Parent` / `parentVar` — the optional back-reference property's type and name
  (e.g. `ProductOption` / `option`).
- `parentCollection` — the parent array holding this entity (e.g. `values`).
  Read the parent model to confirm the exact property name if unsure.
- `field` — the editable `String` field (e.g. `name`).

## Rules

1. Match the reference files line-for-line, changing only the slot substitutions.
   Keep the French UI strings, `@Environment(\.modelContext)` / `\.dismiss`,
   the `init` using `State(wrappedValue:)`, sheet-driven create/update,
   `try? modelContext.save()`, and the delete that does
   `entity.parentVar?.parentCollection.removeAll { $0.id == entity.id }`.
2. The create form's `create()` sets `entity.field = field` then appends to the
   parent: `entity.parentVar?.parentCollection.append(entity)`.
3. Detail `View`: "Détail" section showing `entity.field`, an edit toolbar
   button opening the update sheet, and the red "Supprimer" button. Add a child
   navigation section ONLY if that child entity also has scaffolded CRUD.
4. Place files in a folder nested under the parent's view folder, named for the
   entity's role (e.g. `erp/View/Product/Option/Value/`).
5. Write with `XcodeWrite` using Xcode project paths so files join the target,
   then run `XcodeRefreshCodeIssuesInFile` on each and report diagnostics.
6. If the parent's detail view has a placeholder navigation to this entity's
   list (e.g. a `// Go to values list` comment), report that back so the caller
   can wire the `NavigationLink` to `<Entity>List(<parentVar>: <parentVar>)`.

Report the list of files created and any remaining wiring the caller must do.
