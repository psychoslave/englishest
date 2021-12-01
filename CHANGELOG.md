## [Unreleased]

## [0.1.0] - 2021-12-01

- Initial release
- All provided identifiers have at least one three letter synonymous,
  except `negative?` and `positive?`
- Incorporate a first set of mere aliases plus a few methods
- Covered types include BasicObject, Comparable, Object, Regexp, String
- introduced fully qualified methods are:
  - `BasicObject#consent?(topic = true)`
  - `BasicObject#dissent?(topic = true)`
  - `BasicObject#positive?`
  - `BasicObject#spot(pattern)`
- Target/synonymous aliases are:
  - `BasicObject#==`: apt? congruent? equipotent? equiquantal? equivalue? worth?
  - `BasicObject#consent?`: nod?
  - `BasicObject#dissent?`: axe? deny?
  - `BasicObject#!=`: dissent? inæqual inequal unequal? unlike? wry?
  - `BasicObject#equal?`: equireferent? peg? univocal?
  - `BasicObject#!`: negative?
  - `BasicObject#spot`: reach win
  - `Comparable#>=`: above? accede? at_least? comprise? on? onward? prosupercede? upward? upon?
  - `Comparable#<`: afore? ahead? antecede? before? ere? inferior_to? less_than?
  - `Comparable#>`: after? beyond? excede? exceed? greater_than? higher_than? over? outdo? outstrip? postcede? supercede?
  - `Comparable#==`: apt? concede? # also has other aliases through BasicObject
  - `Comparable#<=`: at_most? behind? ben? below? beneath? comprised? proconcede?
  - `Object#!~`: absent? devoid? off? miss?
  - `Object#===`: encompass? fit? gird?
  - `Object#eql?`: akin? equisummable? isoepitomizable? like? tie?
  - `Object#=~`: hit
  - `Object#<=>`: trichotomise trichotomize spy wye
  - `Regexp#=~`: hit index_of_first_matching
  - `Regexp#~`: hit_tacitely index_of_first_hot_matching hot
  - `String#=~`: hit index_of_first_matching
