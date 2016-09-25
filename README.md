# Apportion

## An Elixir implementation for apportionment

### Description
Apportionment is most often associated with the [US Congressional apportionment][congress_ep],
using the **Equal Proportions** (or Huntington-Hill) method.

In general, apportionment involves the distribution of a scarce resource among recipients, according
to a pre-determined set of recipient weights. Further, a series of apportionments might occur over
time, with each new apportionment overlaying the previous.

Different domains might make use of apportionment. One example is the allocation (or distribution)
of sellable inventory among a number of retail stores, according to the expected sales rate for
each store. For this usage, recipients would likely begin an apportionment with varying quantities
of existing inventory.

Other apportionment methods exist, notably the [**Quota**][ams_balinski] method,
that address issues with **Equal Proportions**.

## Installation

Add `apportion` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:apportion, "~> 0.0"}]
  end
  ```

## Usage

### Apportion.distribute(weights, quantity, options = %{})

Returns a map (a key for each recipient) with the quantity distributed among recipients
(as values)

#### Parameters

`weights` (required) a [Map] of relative integer proportions for each recipient

`quantity` (required) an [Integer] quantity to apportion

`options` (optional) [Map] keys

* **:prior_portions** a [Map] prior portions for each recipient from a previous apportionment
* **:required_minimum** an [Integer] smallest portion for each recipient

## License

The package is available as open source under the terms of the [MIT License][license].

[congress_ep]: https://en.wikipedia.org/wiki/United_States_congressional_apportionment#The_method_of_equal_proportions
[ams_balinski]: https://www.maa.org/sites/default/files/pdf/upload_library/22/Ford/BalinskiYoung.pdf
[license]: http://opensource.org/licenses/MIT
