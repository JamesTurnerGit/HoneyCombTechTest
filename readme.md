# HoneyComb TV - Tech test  

## Description of task

https://github.com/honeycomb-tv-recruitment/makers-test
## Approach

In the briefing provided there was an example of the project lacking the discount implementation. While not strictly part of the briefing I've decided to take this as "legacy" code since in a more real world example there would be prexisting code for handling orders to integrate any solution into.

I decided to make a discount out of various subclasses as each behaviour potentially needs different params. I spiked a version with Procs as they can ignore what they don't need, but decided they weren't flexible enough to add a nice to_string method or any other future extensions needed.

When changing the delivery class there's a problem, Having the price fully mutable creates an issue where you might apply the same discount twice. Making the a new var to contain the discounted price means code elswhere needs to point to that instead or errors occur. Making the new var the one that is static seems to be the safest option. Ideally prices would not be stored in the item itself and instead be stored in a pricelist object.
## Concepts

* A discount has three components
  * How the discount is applied  
  * What it's valid targets are
  * if it has any conditions before it's active
* Alters as little of the existing classes as possible while maintaining something neat and sensible.

### New Classes

* _discount_ - Has all info needed for a single discount.
* _discountList_ - Contains all discounts to apply to an order.
* _discountFactory_ - brings together the next three classes and constructs discounts. I'm not sure on the nescessity of this but the generation of a discount is complex enough to warrent seperating the concern out of the discount class itself.
* _discountAmounts_ - contains all the various subclasses for amounts and selects the right one, another class that could be merged into discountFactory but is kept seperate to make the code communicate better. The reason these classes are stored in another class are to try and not polute the global namespace too much.
* _discountTargets_ - contains all the various subclasses for targets.
* _discountConditions_ - contains all the various subclasses for conditions.

### Changes to existing Classes

#### Order

* new var _discountList_ - stores a  _discountList_
* new method _add_discount_ - adds a discount to the _discount_list_
* new method _apply_discount_ - this goes through each "delivery" to calculate _discounted_price_ and also the final _discounted_total_.
* new method _discounted_total_ - returns new total cost of order after discounts
* new method _itemsOfType_ - this returns all items of a type from the order
* changed method _output_ - now uses _discounted_total_ and _discounted_price_.

#### delivery

* changed var _price_ - is now unchangable after initialisation of order
* added _dicountedPrice_ - added and is what will be shown in the output of _order_
* added _type_ - what type of order a product is.

#### improvements to make
  _discountAmounts_, _discountTargets_ and _discountConditions_ are all very similar, i'm sure there's a ducktype hiding in them.

  In the same classes I'm not happy with the case statement to return the subclasses within them. I feel there's probably a better way to do that.

  would like to solidify how multible discounts work, atm its just the last item on the discount list that overwrites any others on a particular item.
#### usage

### adding a discount to an order
  * create a order in the same way as before
  * to apply discounts to an order you have some options
    * you can now call _add_discount_ (details later)
    * you can set the discount list on the order to an already existing one

| Ways to Apply Discount | Ways to Target Discount | Conditions on Discount |
|------------------------|-------------------------|------------------------|
| :percentOff            | :onAll                  | :none                  |
| :changePrice           | :byType                 | :typeTotal             |
|                        |                         | :priceTotal            |

### making an addition to the system
#### thoughts
### What i like about my solution
### What i don't like about my solution
