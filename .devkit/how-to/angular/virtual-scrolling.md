# Virtual Scrolling

## Scope
This how-to covers configuring Angular CDK virtual scrolling for large lists and tuning buffer settings. It focuses on item sizing and appropriate use cases for virtualized rendering.

## Prerequisites

## Steps

## Rules & patterns
- Large lists MUST use CDK virtual scrolling. — <cdk-virtual-scroll-viewport> with *cdkVirtualFor
- itemSize MUST be set for fixed-height items in virtual scrolling.
- autosize MAY be used for variable-height items in virtual scrolling.
- minBufferPx and maxBufferPx SHOULD be configured for virtual scrolling.

## Anti-patterns
- Thousands of items MUST NOT be rendered using regular ngFor.
- trackBy MUST NOT be omitted when using virtual scrolling.
- Virtual scrolling SHOULD NOT be used for small lists. — <50–100 items

## Allowed deviations
- Teams MAY choose between fixed-height and variable-height virtual scrolling based on trade-offs.

## Examples

## Cross-references