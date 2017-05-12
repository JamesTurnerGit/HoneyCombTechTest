# HoneyComb TV - Tech test  

## Description of task

https://github.com/honeycomb-tv-recruitment/makers-test
## Approach

In the briefing provided there was an example of the project lacking the discount implementation. While not strictly part of the briefing I've decided to take this as "legacy" code since in a more real world example there would be prexisting code for handling orders to integrate any solution into.

besides intergrating into the old code, flexibility and expandability are what i've been foccused on. I'm very happy with how extendable this system is.

I decided to make a discount out of various subclasses as each behaviour potentially needs different params. I spiked a version with Procs as they can ignore what they don't need, but decided they weren't flexible enough to add a nice to_s method or any other future extensions needed.

The final cost of an item is stored in the `order.items` array at the second index of each sub array. `[broadcaster,delivery,final_price]` ideally this subarray would be changed into a class, but since i was trying to preserve the original codebase as much as possible it was left as an array.

while it was possible to just reuse the % off application for both examples requested, It seemed natural to add something to change the price to show the flexablity of my solution.

## Concepts

* A discount has three components
  * How the discount is applied  
  * What it's valid targets are
  * if it has any conditions before it's active
* Alters as little of the existing classes as possible while maintaining something neat and sensible.

## New Classes

* `discount` - Has all info needed for a single discount.
* `discountList` - Contains all discounts to apply to an order.
* `discountFactory` - brings together the next three classes and constructs discounts. I'm not sure on the nescessity of this but the generation of a discount is complex enough to warrent seperating the concern out of the discount class itself.
* `discountAmounts` - contains all the various subclasses for amounts and selects the right one, another class that could be merged into discountFactory but is kept seperate to make the code communicate better. The reason these classes are stored in another class are to try and not polute the global namespace too much.
* `discountTargets` - contains all the various subclasses for targets.
* `discountConditions` - contains all the various subclasses for conditions.

## Changes to existing Classes

### Order

* new var `discountList` - stores a  _discountList_
* new method `add_discount` - adds a discount to the _discount_list_
* new method `apply_discount` - this goes through each "delivery" to calculate _discounted_price_ and also the final _discounted_total_.
* new method `discounted_total` - returns new total cost of order after discounts
* new method `items_of_type` - this returns all items of a type from the order
* changed method `output` - now also shows discounted values.

## usage
the described example scenarios have been set out in feature_spec.rb, additionally a discount was added to run.rb and the output impoved to reflect this.

### adding a discount to an order
  * create a order in the same way as before
  * to apply discounts to an order you have some options
    * you can now call `add_discount` on your order
    * you can set the discount list on the order to an already existing one
    * you could have even created the order with the discountlist as a parameter!

| Ways to Apply Discount | Ways to Target Discount | Conditions on Discount |
|------------------------|-------------------------|------------------------|
| :percentOff            | :onAll                  | :none                  |
| :changePrice           | :type                   | :typeTotal             |
|                        |                         | :priceTotal            |

an example of how to build a discount
```ruby
site_discounts.add ({:amount =>    :changePrice,amountParam:   {amount: 5},
                     :condition => :priceTotal ,conditionParam:{amount: 50}})
 ```
this sets all delivery costs to cost 5 as long as the order costs over 50.

### params for subclasses
* `percentOff` - _amount_ - how much % to remove from the cost of the item
* `changePrice` - _amount_ - what to change the price into
* `onAll` - no params
* `byType` - _type_ - what type of items to trigger on
* `none` - no params
* `typeTotal` - _type_ - what type of items to count - _amount_ -how many items before condition is met.

### making an addition to the system
decide what kind of new aspect you want to add and go to the appropriate file _discountAmounts_, _discountConditions_,_discountTargets_. extend the base class there and add the behaviour, then add your new class to the hash at the bottom of the file.

## thoughts
### What i like about my solution
It's super flexable, could very easily extend to add all kinds of other options to any of the aspects. eg adding a discount on a particular broadcaster.
### What i don't like about my solution
Building a discount means describing it in a lot of detail, Not obvious enough if something goes wrong in creation untill you try to use the result, but that can be improved on.
### improvements to make
I'd like to go over when my subclasses are created to give them better errors and make them check if they are initialized incorrectly.

I'd like to change the Items array of _order_ to contain a new class, would not change without a better understanding of what uses it though (outside of this small window/project)

figure out a better name for the application aspect (applicator, calculator,method) nothing seems to fit in all contexts it's used

Would like to change target so it returns a list of all items that match it, this would allow for more flexibiltiy in terms of implementing things like BOGOF.
