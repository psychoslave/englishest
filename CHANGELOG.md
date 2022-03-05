## [Unreleased]

## [0.2.0] - 2022-03-05

- Move alises previously defined in Object to Kernel, as all aimed methods belong
  to it.
- Add methods
  - `String#subshell`: allow to execute a command without using backticks
- Add aliases for
  - `Array::[]`: create engender generate gig
  - `BasicObject#!`: bad? con? negative? ko?
  - `BasicObject#__id__`: badge bib emblem identifier insigne insignia
  - `BasicObject#!=`: inæqual? inequal? unequal? unlike? wry?
  - `BasicObject#instance_eval`: contextually so tho wis
  - `BasicObject#instance_exec`: aptly pat plumb suitably
  - `BasicObject#method_missing`: gap lake vacant on_vacancy way_off
  - `BasicObject#__send__`: address fax hop pst transmit
  - `BasicObject#singleton_method_added`: hail hey hi on_attachment
  - `BasicObject#singleton_method_removed`: ban ciao leave_taking on_detachment
  - `BasicObject#singleton_method_undefined`: farewell nix on_unattachment]
  - `Dir::[]`: conform native_global_match orb suit
  - ``Kernel#```: subshell run
  - `String#subshell`: run
  - `SystemCallError::===`: encompass? fit? gird?


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
