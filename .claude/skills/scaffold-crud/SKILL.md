---
name: scaffold-crud
description: Scaffold a full SwiftUI + SwiftData CRUD screen set (List, CreateForm, UpdateForm, detail View) for a child entity, matching the project's established Product/Option pattern. Use when asked to add CRUD screens for a SwiftData model, replicate the option/value CRUD pattern, or generate list/create/update/detail views for a new entity.
---

# Scaffold CRUD (Product/Option pattern)

This project uses a consistent four-file CRUD convention for any SwiftData child
entity that belongs to a parent and exposes an editable `name`. The canonical
reference implementation lives in `erp/erp/View/Product/Option/`:

- `ProductOptionList.swift` — list of children under a parent, with a `+` toolbar button that opens the create sheet.
- `ProductOptionCreateForm.swift` — create sheet (a `Form` with a single `TextField`).
- `ProductOptionUpdateForm.swift` — edit sheet, same form, confirm disabled while unchanged.
- `ProductOptionView.swift` — detail screen with a "Détail" section, optional child-navigation section, edit toolbar button, and a red "Supprimer" button.

## The model shape this pattern expects

The reference model (`erp/erp/Model/ProductOption.swift`):

```swift
@Model
final class ProductOption {
    #Unique<ProductOption>([\.product, \.name])
    var product: Product?                       // PARENT (optional back-reference)
    var name: String                            // EDITABLE FIELD
    @Relationship(deleteRule: .cascade, inverse: \ProductOptionValue.option)
    var values: [ProductOptionValue] = []       // CHILD collection (optional)
    init(product: Product, name: String = "") { ... }
}
```

Before scaffolding, read the target `@Model` and identify:

| Slot | Reference value | How to find it |
|------|-----------------|----------------|
| `Entity` | `ProductOption` | the `@Model` class name |
| `entity` | `option` | lowerCamel local/var name |
| `Parent` | `Product` | type of the optional back-reference property |
| `parentVar` | `product` | that property's name |
| `parentCollection` | `options` | the parent's array that holds this entity |
| `field` | `name` | the editable `String` field |
| `ChildCollection` | `values` | this entity's own child array (may be absent) |

## Workflow

Delegate the generation to the **crud-generator** agent, or follow these steps
directly:

1. **Read the model** for the entity and confirm the seven slots above. If the
   parent's `parentCollection` name is ambiguous, read the parent model to find
   the array whose element type is `Entity`.
2. **Pick the folder.** Files go in a folder named after the entity's role,
   nested under the parent's folder (e.g. `Product/Option/Value/` for
   `ProductOptionValue`).
3. **Generate the four files** by substituting the slots into the reference
   files. Preserve the pattern exactly: French UI strings ("Requis", "Nouveau",
   "Édition", "Détail", "Supprimer", "Valeurs"), `@Environment` usage,
   `State(wrappedValue:)` init, sheet-based create/update, `try? modelContext.save()`,
   and the delete that removes self from the parent collection.
4. **Wire the parent up.** In the parent's detail `View`, replace any
   `// Go to <children> list` placeholder / navigation with a `NavigationLink`
   to the new `<Entity>List(<parentVar>: <parentVar>)`.
5. **Create files with `XcodeWrite`** (Xcode project paths, e.g.
   `erp/View/Product/Option/Value/ProductOptionValueView.swift`) so they are
   added to the target automatically, then verify with
   `XcodeRefreshCodeIssuesInFile`.

## File templates

Substitute the slots (`Entity`, `entity`, `Parent`, `parentVar`,
`parentCollection`, `field`, `Children`/`ChildCollection`) into the four
reference files verbatim. The only structural choice is whether the detail
`View` includes a child-navigation section: include it only when the entity has
its own scaffolded child CRUD; otherwise show just the "Détail" section, edit
button, and delete button.
