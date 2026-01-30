# Change Detection Reactivity

## Scope
This playbook covers Angular change detection strategy choices, reactivity patterns, and subscription lifecycle cleanup. It focuses on OnPush usage, signals, and list rendering performance techniques.

## Core guidance

## Rules & patterns
- Components that receive immutable data or observables MUST use ChangeDetectionStrategy.OnPush.
- OnPush components SHOULD rely on Angular’s subtree skipping when parent inputs do not change.
- Signals MUST be used for synchronous reactive state management where appropriate instead of RxJS.
- Signals SHOULD be combined with OnPush components so that reading signals in templates triggers change detection.
- Infrequently updated, heavy components MAY detach change detection and manually trigger updates.
- trackBy MUST be provided in ngFor to avoid unnecessary DOM recreation when lists change.
- trackBy MUST be added for any dynamic ngFor list.
- trackBy MUST use a unique stable identifier and MUST NOT use the index. — item.id
- trackBy SHOULD remain pure and simple.
- trackBy MUST be used with virtual scrolling.
- Manual subscriptions MUST be unsubscribed in ngOnDestroy. — .unsubscribe()
- The async pipe SHOULD be used for template observables. — | async
- The takeUntil pattern MAY be used for managing multiple subscriptions. — takeUntil(destroy$)
- takeUntilDestroyed MUST be used for automatic subscription cleanup where available. — takeUntilDestroyed()
- Event listeners MUST be removed in ngOnDestroy. — removeEventListener
- Timers and intervals MUST be cleared on component destruction. — clearInterval; clearTimeout

## Anti-patterns
- Components that receive immutable inputs MUST NOT omit ChangeDetectionStrategy.OnPush.
- Inputs in OnPush components MUST NOT be mutated.
- trackBy MUST NOT be omitted in large lists rendered with ngFor.
- Signals MUST NOT be repeatedly read outside reactive contexts.
- Dynamic ngFor lists MUST NOT omit trackBy.
- trackBy MUST NOT track by array index.
- trackBy MUST NOT contain heavy or expensive logic.
- Manual subscriptions MUST NOT be left active after component destruction.
- Subscriptions MUST NOT be used for template values instead of the async pipe.
- DOM event listeners MUST NOT remain after component destruction.
- Timers and intervals MUST NOT continue executing after component destruction.

## Allowed deviations
- Teams MAY use OnPush only when they consistently pass new immutable references. — { ...user, name: 'new' }
- Signals and RxJS MAY be used together according to their respective synchronous and asynchronous responsibilities.
- trackBy MAY be treated as consistently recommended without alternative guidance.
- Teams MAY choose between takeUntilDestroyed, takeUntil, or manual unsubscription patterns.

## Examples

## Cross-references