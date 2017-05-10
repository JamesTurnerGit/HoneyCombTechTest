# HoneyComb TV - Tech test  

## Description of task

https://github.com/honeycomb-tv-recruitment/makers-test
## Approach

In the briefing provided there was an example of the project lacking the discount implementation. While not strictly part of the briefing I've decided to take this as "legacy" code since in a more real world example there would be prexisting code for handling orders to integrate any solution into.

## Concepts

* A discount can apply to the whole order or each item individually
* Original price is not changed, Current price is instead generated
* Alters as little of the existing classes as possible while maintaining something neat and sensible.

### New Classes

* _discount_ - Has all info needed for a single discount
* _discounts_ - Contains all discounts to apply to an order

### Changes to existing Classes

#### Order

* new method _ApplyDiscount_ - this goes through each "delivery" to calculate _discountedPrice_ and also the final _discountedTotal_.

* _output_ - now uses _discountedTotal_ and _discountedPrice_.

#### delivery

* _price_ - is now unchangable after initialisation of order
* added _discountedPrice_ - added and is what will be shown in the output of _order_
* added _type_ - what type of order a product is.

## critique on example





## final thoughts
