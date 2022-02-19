# SDK Design Notes

My goals in writing `lotrb` were the following:
1) get something _working_ -- in truth, I've never written a Ruby gem OR any sort of SDK before
2) build something with a relatively simple, straightforward interface
3) write as little code as possible, within reason

The SDK mirrors the API fairly closely. I took a good amount of inspiration from [Stripe's ruby library](https://github.com/stripe/stripe-ruby), because it's one of the most pleasant I've worked with.

The most satisfying part of this SDK so far is the way it maps fields in the objects from the JSON response into Ruby objects without going crazy with any explicit mapping or config, etc. I do this by a bit of metaprogramming to convert the JSON field names into `attr_accessor`s on the relevant class and then set each field's value as it's "hydrated," if you will. For example, the `Book` class doesn't have a `name` field defined in code -- it's dynamically defined and assigned when we hydrate each `Book` instance from an API response.

We can list any resource type (Book, Movie, Chapter, Character, and Quote) by calling the class method `list` on the corresponding class. This will return a `ListObject` containing an array of the corresponding resource objects along with the pagination fields:

```ruby
characters = Lotrb::Character.list # This will give you a ListObject
characters.results # This will give you the array of Character objects
characters.pages # This will give you the number of pages in the result of you list request

# Since `characters.results` is a plain Ruby array, we can access it like any old array:
characters.results.first.name
```

Likewise, we can fetch a single resource by ID by calling the class method `retrieve` on the corresponding class. This will return an instance of the class itself.

```ruby
quote = Lotrb::Quote.retrieve("5cd96e05de30eff6ebccebca") # This returns an actual Quote object
quote.dialog # This returns the dialog field of the quote
```

Finally (and this is a piece I'm not very happy with yet), classes for which the API allows fetching nested resources each have a `list_blahs` method, where `blah` is the nested resource. This `list_blahs` method quacks just like a `list` method on one of the resource classes, returning a `ListObject`. For example...

```ruby
book = Lotrb::Book.list.results.first # Returns a ListObject
book.list_chapters.results # Returns an array of Chapter objects
```

