+++
title = "How to disable Ripple effect in Jetpack Compose"
date = "2021-05-23"
author = "Mathan Raj"
authorTwitter = "immathanr" #do not include @
cover = ""
screenshot="../img/avatar.jpg"
tags = ["kotlin", "jetpack compose", "material"]
keywords = ["kotlin", "jetpack compose"]
description = "How to disable the default ripple effect of MaterialTheme while clicking in Jetpack Compose"
showFullContent = false
+++

Jetpack compose uses [Indication](https://developer.android.com/reference/kotlin/androidx/compose/foundation/Indication) to represent the visual indication of the interactions. By default, when you add to any [clickable](https://developer.android.com/reference/kotlin/androidx/compose/foundation/package-summary#(androidx.compose.ui.Modifier).clickable(kotlin.Boolean,kotlin.String,androidx.compose.ui.semantics.Role,kotlin.Function0)) modifier to a component, it picks up the [LocalIndication](https://developer.android.com/reference/kotlin/androidx/compose/foundation/package-summary.html#localindication) from the `CompositionLocal` hierarchy.

![ripple animation by](https://cdn.dribbble.com/users/950579/screenshots/4444211/ripple_effect_1.gif "Ripple animation")

###### &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  Ripple illustration by [JungIk Lee](https://dribbble.com/jjangik)

If you are using [MaterialTheme](https://developer.android.com/reference/kotlin/androidx/compose/material/MaterialTheme?hl=en) as your current theme, the `LocalIndication` available in the CompositionLocal hiearchy by default will pick up Ripple as the default interaction feedback for clicks. At some places, you necessarily don't want any indications for your click. So to disable it, *Compose* allows easy way to disable/alter the `Indication`.

To achive that, in `clickable` modifier pass `null` for the indication parameter.

```kotlin
val interactionSource = remember { MutableInteractionSource() }
Row (modifier = Modifier.clickable(
                    indication = null, 
                    interactionSource = remember { interactionSource }
          ) { // action

           }
)
```

One of the best things about Jetpack Compose is use can take advantage of kotlin-extension functions to create your own custom modifiers for reusability.

To achieve that,

```kotlin
inline fun Modifier.noRippleClickable(
    crossinline onClick: () -> Unit
): Modifier = composed {
    val interactionSource = remember { MutableInteractionSource() }
    clickable(
        indication = null,
        interactionSource = interactionSource
    ) {
        onClick()
    }
}
```

Now `noRippleClickable` modifier can be used in any component to disable ripple effect in interactions.